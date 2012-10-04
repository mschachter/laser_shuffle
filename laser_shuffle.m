function varargout = laser_shuffle(varargin)
% LASER_SHUFFLE MATLAB code for laser_shuffle.fig
%      LASER_SHUFFLE, by itself, creates a new LASER_SHUFFLE or raises the existing
%      singleton*.
%
%      H = LASER_SHUFFLE returns the handle to a new LASER_SHUFFLE or the handle to
%      the existing singleton*.
%
%      LASER_SHUFFLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LASER_SHUFFLE.M with the given input arguments.
%
%      LASER_SHUFFLE('Property','Value',...) creates a new LASER_SHUFFLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before laser_shuffle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to laser_shuffle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help laser_shuffle

% Last Modified by GUIDE v2.5 03-Oct-2012 19:45:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @laser_shuffle_OpeningFcn, ...
                   'gui_OutputFcn',  @laser_shuffle_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before laser_shuffle is made visible.
function laser_shuffle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to laser_shuffle (see VARARGIN)

% Choose default command line output for laser_shuffle
handles.output = hObject;

    %initialize controller
    c = LaserShuffleController;
    handles.controller = c;
    v = LaserShuffleView;
    handles.view = v;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes laser_shuffle wait for user response (see UIRESUME)
% uiwait(handles.figure1);
  


% --- Outputs from this function are returned to the command line.
function varargout = laser_shuffle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_data_dir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_data_dir as text
%        str2double(get(hObject,'String')) returns contents of edit_data_dir as a double


% --- Executes during object creation, after setting all properties.
function edit_data_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_browse_data_dir.
function button_browse_data_dir_Callback(hObject, eventdata, handles)
% hObject    handle to button_browse_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    c = handles.controller;
    v = handles.view;
    c = c.setDataDir(uigetdir());
    v.setDataFiles(c.dataFiles, handles);


% --- Executes on selection change in listbox_valid_files.
function listbox_valid_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_valid_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_valid_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_valid_files


% --- Executes during object creation, after setting all properties.
function listbox_valid_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_valid_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_laser_name.
function listbox_laser_name_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_laser_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_laser_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_laser_name


% --- Executes during object creation, after setting all properties.
function listbox_laser_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_laser_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
