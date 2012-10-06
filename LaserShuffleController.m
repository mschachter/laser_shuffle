classdef LaserShuffleController
    %LaserShuffleController Main class for dealing with Laser Shuffle UI    
    
    properties
        dataDir; %directory where all the data files are
        dataFiles; %the valid data files in dataDir
        
        fileHeaders; %the header columns in each data file
        fileName2Index; %map from data file name to index in dataFiles
        
        laserName; %name of selected laser
        
        availableCells; %map of cells per file, key is filename, value is array of cell names
        
        parameters; %map of parameters and their values
        
    end
    
    methods
        
        %initializer method
        function obj = LaserShuffleController(obj)
           
            dparams = containers.Map();
            dparams('bin_size') = 0.005;
            dparams('
            
            
            
        end
        
        %set the data directory, look for valid files
        function obj = setDataDir(obj, dataDirToUse)
           obj.dataDir = dataDirToUse;
           [dfiles,fheaders] = obj.loadFiles(obj.dataDir);
           obj.dataFiles = dfiles;
           obj.fileHeaders = fheaders;
           obj.fileName2Index = containers.Map();
           for k = 1:length(dfiles)              
               obj.fileName2Index(dfiles{k}) = k;               
           end
           
           if isempty(obj.dataFiles) 
               errordlg('The data directory has no data files!');              
           end         
        end
        
        %check to see if column name is valid
        function filesWithCol = filesWithColumn(obj, colName)
            
            filesWithCol = {};
            for k = 1:length(obj.fileHeaders)                
                for j = 1:length(obj.fileHeaders{k})
                    %fprintf('comparing %s with %s\n', obj.fileHeaders{k}{j}, colName)
                    if strcmp(obj.fileHeaders{k}{j}, colName)                       
                        filesWithCol{end+1} = obj.dataFiles{k};                        
                    end
                end
            end            
        end
               
        %set the Laser name and find available cells
        function obj = setLaserName(obj, lname)
        
            filesToSearch = obj.filesWithColumn(lname);
            
            cnames = containers.Map();
            for k = 1:length(filesToSearch)
                
                fname = filesToSearch{k};
                findex = obj.fileName2Index(fname);
                fheaders = obj.fileHeaders{findex};
                
                cells = LaserShuffleController.getCellNames(fheaders, lname);                
                if ~isempty(cells)
                    cnames(fname) = cells;
                end
            end            
            
            obj.availableCells = cnames;
            
        end
        
        
    end
    
    methods (Static)
        
        %get the cells from a file with a specified laser name
        function cNames = getCellNames(fHeaders, lName)            
            cNames = {};
            passed = 0;
            for k = 1:length(fHeaders)
                if passed
                    cNames{end+1} = fHeaders{k};
                end                
                if strcmp(fHeaders{k}, lName)
                    passed = 1;
                end
            end            
        end
        
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

