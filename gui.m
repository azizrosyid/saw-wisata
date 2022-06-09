function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 18-May-2022 23:17:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global cityPicked weightCriteria categoryValue;
cityPicked = ["Yogyakarta"];
weightCriteria = [2 3 2];
categoryValue = ["Bahari" 2; "Budaya" 3; "Cagar Alam" 4; "Pusat Perbelanjaan" 5; "Taman Hiburan" 2; "Tempat Ibadah" 3];


% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function datasetTable_CreateFcn(hObject, eventdata, handles)
global cityPicked;
dataset = readtable('tourism_with_id.csv');
dataset = removevars(dataset,["Place_Id" "Time_Minutes" "Coordinate", "Lat", "Long", "Var12", "Var13"]);

picked = ismember(dataset.City, cityPicked);
dataset(not(picked), :) = [];
datasetCell = table2cell(dataset);
set(hObject, 'Data', datasetCell);
set(hObject, 'ColumnName', dataset.Properties.VariableNames);


function datasetTable_KeyPressFcn(hObject, eventdata, handles)
function pushbutton1_Callback(hObject, eventdata, handles)
function listbox1_Callback(hObject, eventdata, handles)
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function togglebutton1_Callback(hObject, eventdata, handles)
function popupmenu1_Callback(hObject, eventdata, handles)
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function yogyakarta_Callback(hObject, eventdata, handles)
checkBoxListener(hObject , handles);

function checkBoxListener(checkBox, handles)
global cityPicked;
if (checkBox.Value == 1)
cityPicked(end + 1) = checkBox.String;
else
 cityPicked(strcmp(cityPicked, checkBox.String)) = [];
end

dataset = readtable('tourism_with_id.csv');
dataset = removevars(dataset,["Place_Id" "Time_Minutes" "Coordinate", "Lat", "Long", "Var12", "Var13"]);

picked = ismember(dataset.City, cityPicked);
dataset(not(picked), :) = [];
dataset = table2cell(dataset);
set(handles.datasetTable, 'Data', dataset);


function semarang_Callback(hObject, eventdata, handles)
checkBoxListener(hObject , handles);

function bandung_Callback(hObject, eventdata, handles)
checkBoxListener(hObject , handles);

function jakarta_Callback(hObject, eventdata, handles)
checkBoxListener(hObject , handles);

function surabaya_Callback(hObject, eventdata, handles)
checkBoxListener(hObject , handles);

function categoryInputListener(name, value)
global categoryValue;
categoryValue(categoryValue == name, 2) = value;

function edit1_Callback(hObject, eventdata, handles)
name = "Bahari";
newValue = str2double(hObject.String);
categoryInputListener(name, newValue);

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
name = "Budaya";
newValue = str2double(hObject.String);
categoryInputListener(name, newValue);

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
name = "Cagar Alam";
newValue = str2double(hObject.String);
categoryInputListener(name, newValue);

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
name = "Pusat Perbelanjaan";
newValue = str2double(hObject.String);
categoryInputListener(name, newValue);

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
name = "Taman Hiburan";
newValue = str2double(hObject.String);
categoryInputListener(name, newValue);

function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)
name = "Tempat Ibadah";
newValue = str2double(hObject.String);
categoryInputListener(name, newValue);

function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit11_Callback(hObject, eventdata, handles)
global weightCriteria;
weightCategory = hObject.String;
weightCategory = str2double(weightCategory);
weightCriteria(1) = weightCategory;

function edit11_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
global weightCriteria;
weightPrice = hObject.String;
weightPrice = str2double(weightPrice);
weightCriteria(2) = weightPrice;

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit13_Callback(hObject, eventdata, handles)
global weightCriteria;
weightRating = hObject.String;
weightRating = str2double(weightRating);
weightCriteria(3) = weightRating;

function edit13_CreateFcn(hObject, ~, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btnHitung_Callback(hObject, eventdata, handles)
global cityPicked categoryValue weightCriteria;
result = saw_wisata(cityPicked, weightCriteria, categoryValue);
resultCell = table2cell(result);
set(handles.resultTable, 'Data', resultCell);
set(handles.resultTable, 'ColumnName', result.Properties.VariableNames);
set(handles.text22, 'String', result.Place_Name(1));
set(handles.text23, 'String', result.Description(1));

function resultTable_CreateFcn(hObject, eventdata, handles)
dataset = readtable('tourism_with_id.csv');
dataset = removevars(dataset,["Place_Id" "Time_Minutes" "Coordinate", "Lat", "Long", "Var12", "Var13"]);
set(hObject, 'Data', '');
set(hObject, 'ColumnName', dataset.Properties.VariableNames);

function edit1_ButtonDownFcn(hObject, eventdata, handles)