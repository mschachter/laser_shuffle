classdef LaserShuffleView
    %LaserShuffleView takes care of all the UI stuff for Laser Shuffle
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        
        function obj = setDataFiles(obj, dataFiles, handles)           
            dataFiles
            set(handles.listbox_valid_files, 'String', dataFiles);
        end
        
    end
    
end

