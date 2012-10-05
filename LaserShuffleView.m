classdef LaserShuffleView
    %LaserShuffleView takes care of all the UI stuff for Laser Shuffle
    %   Detailed explanation goes here
    
    properties        
        
    end
    
    methods
        
        function obj = setDataFiles(obj, controller, handles)            
            set(handles.listbox_valid_files, 'String', controller.dataFiles);
            set(handles.text_data_dir_value, 'String', controller.dataDir);
        end
        
    end
    
end

