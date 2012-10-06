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
        
        function obj = setAvailableCells(obj, controller, handles)
            
            %get the selected files
            sfiles_index = get(handles.listbox_valid_files, 'Value');
            validfiles = get(handles.listbox_valid_files, 'String');
            sfiles = cell(length(sfiles_index), 1);
            for k = 1:length(sfiles_index)
                sfiles{k} = validfiles{sfiles_index(k)};
            end            
            
            %check the available files against the selected files and build
            %up a list of cells
            allCells = {};            
            for k = 1:length(sfiles)
                fkey = sfiles{k};
                if controller.availableCells.isKey(fkey)
                    clist = controller.availableCells(fkey);
                    for j = 1:length(clist)                       
                        allCells{end+1} = clist{j};                        
                    end
                end                
            end
            
            %set the listbox with the values
            set(handles.listbox_cells, 'String', allCells);            
        end
        
        function obj = setDefaults(obj, controller, handles)
            
            
            
        end        
    end
    
end

