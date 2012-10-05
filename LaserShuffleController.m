classdef LaserShuffleController
    %LaserShuffleController Main class for dealing with Laser Shuffle UI    
    
    properties
        dataDir;
        dataFiles;
        fileHeaders;
    end
    
    methods
        
        %set the data directory, look for valid files
        function obj = setDataDir(obj, dataDirToUse)
           obj.dataDir = dataDirToUse;
           [dfiles,fheaders] = obj.loadFiles(obj.dataDir);
           obj.dataFiles = dfiles;
           obj.fileHeaders = fheaders;
           
           if isempty(obj.dataFiles) 
               errordlg('The data directory has no data files!');              
           end         
        end
        
        %check to see if column name is valid
        function filesWithCol = filesWithColumn(obj, colName)
            
            filesWithCol = {};
            for k = 1:length(obj.fileHeaders)                
                for j = 1:length(obj.fileHeaders{k})
                    fprintf('comparing %s with %s\n', obj.fileHeaders{k}{j}, colName)
                    if strcmp(obj.fileHeaders{k}{j}, colName)                       
                        filesWithCol{end+1} = obj.dataFiles{k};                        
                    end
                end
            end            
        end
                
    end
    
    methods (Static)
        
        function [goodFiles,fheaders] = loadFiles(dataDir)
            fprintf('Loading files from %s\n', dataDir);
            fnames = dir(dataDir);
            goodFiles = {};
            fheaders = {};
            for k = 1:length(fnames)
                if ~fnames(k).isdir
                    fileName = fnames(k).name;
                    fullFileName = fullfile(dataDir, fileName);
                    headers = LaserShuffleController.getFileHeaders(fullFileName);
                    if ~isempty(headers) > 0
                        goodFiles{end+1} = fileName;
                        fheaders{end+1} = headers;
                    end                    
                end                
            end                     
        end
        
        %read the first line of a file to get the headers
        function headerNames = getFileHeaders(fileName)
            headerNames = {};
            f = fopen(fileName, 'r');
            firstLine = fgetl(f);
            if ~isempty(firstLine)
                cols = textscan(firstLine, '%s', 'delimiter', ',');
                if length(cols{1}) > 1
                    headerNames = cols{1};
                end                
            end            
            fclose(f);
        end
                        
    end
    
end

