classdef LaserShuffleController
    %LaserShuffleController Main class for dealing with Laser Shuffle UI    
    
    properties
        dataDir;
        dataFiles;
    end
    
    methods
        
        function obj = setDataDir(obj, dataDirToUse)
           obj.dataDir = dataDirToUse;
           obj.dataFiles = obj.loadFiles(obj.dataDir);
           
           if isempty(obj.dataFiles) 
               errordlg('The data directory has no data files!');              
           else
               fprintf('Set data dir to %s\n', obj.dataDir);
           end           
        end
                
    end
    
    methods (Static)
        function goodFiles = loadFiles(dataDir)
            fprintf('Loading files from %s\n', dataDir);
            fnames = dir(dataDir);
            goodFiles = {};
            for k = 1:length(fnames)
                if ~fnames(k).isdir
                    goodFiles{end+1} = fnames(k).name;
                    %todo - file contents checking?
                end                
            end                     
        end
                
    end
    
end

