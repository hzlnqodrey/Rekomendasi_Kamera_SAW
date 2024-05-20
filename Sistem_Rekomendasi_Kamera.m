function varargout = Hazlan_Jawaban_2_new(varargin)
% HAZLAN_JAWABAN_2_NEW MATLAB code for Hazlan_Jawaban_2_new.fig
%      HAZLAN_JAWABAN_2_NEW, by itself, creates a new HAZLAN_JAWABAN_2_NEW or raises the existing
%      singleton*.
%
%      H = HAZLAN_JAWABAN_2_NEW returns the handle to a new HAZLAN_JAWABAN_2_NEW or the handle to
%      the existing singleton*.
%
%      HAZLAN_JAWABAN_2_NEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HAZLAN_JAWABAN_2_NEW.M with the given input arguments.
%
%      HAZLAN_JAWABAN_2_NEW('Property','Value',...) creates a new HAZLAN_JAWABAN_2_NEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Hazlan_Jawaban_2_new_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Hazlan_Jawaban_2_new_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Hazlan_Jawaban_2_new

% Last Modified by GUIDE v2.5 21-May-2024 00:30:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Hazlan_Jawaban_2_new_OpeningFcn, ...
                   'gui_OutputFcn',  @Hazlan_Jawaban_2_new_OutputFcn, ...
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


% --- Executes just before Hazlan_Jawaban_2_new is made visible.
function Hazlan_Jawaban_2_new_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Hazlan_Jawaban_2_new (see VARARGIN)

% Choose default command line output for Hazlan_Jawaban_2_new
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Hazlan_Jawaban_2_new wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Hazlan_Jawaban_2_new_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in showTables.
function showTables_Callback(hObject, eventdata, handles)
% hObject    handle to showTables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('data-kamera.xlsx');
opts.SelectedVariableNames =(1:7);
data = readtable('data-kamera.xlsx', opts);
data = table2cell(data);
data = data(:, 1:7);
set(handles.tableData, 'Data', data);


% --- Executes on button press in prosesButton.
function prosesButton_Callback(hObject, eventdata, handles)
% hObject    handle to prosesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% PROSES REKOMENDASI SAW
% "1 - Dapatkan Data Tabel dari Excel"
opts = detectImportOptions('data-kamera.xlsx');
opts.SelectedVariableNames =(1:8);
data = readtable('data-kamera.xlsx', opts);
data = table2cell(data);
data = data(:, 1:7);

% "2 - Analisis Bobot"
bobot = [0.25 0.15 0.20 0.40];
k=[1, 1, 1, -1];
dataTable = get(handles.tableData, 'Data');
dataTable = dataTable(:, 4:7)
dataTable = cell2mat(dataTable);
disp('dataTable');

% "3 - Normalisasi Bobot"
bobot = bobot./sum(bobot);
disp('bobot');
disp(bobot);

% "4 - Normalisasi Matrix"
[m n] = size(dataTable);
R = zeros(m,n);
skor = zeros (m,1);
for j=1:n,
    if k(j)==1
        
R(:,j)=dataTable(:,j)./max(dataTable(:,j));
    else
        R(:,j)=min(dataTable(:,j))./dataTable(:,j);
    end
end
disp('matriks hasil normalisasi');
disp(R);

% "5 - Perangkingan Sum Bobot"
for i=1:m
    skor(i)=sum(bobot.*R(i,:));
end
disp('skor');
disp(skor);
skor = num2cell(skor);
disp('skor');
disp(skor);

% "6 - Set New Table Hasil"
data = readtable('data-kamera.xlsx');
data = table2cell(data);
data = data(:,8);
dataT = [skor, data];

% == Sort the rows based on the first column in descending order
dataHasil = sortrows(dataT, 1, 'descend');

% Get the top 10 rows
top10data = dataHasil(1:min(10, size(dataHasil, 1)),:);

set(handles.tabelHasil, 'data', dataHasil);
disp('data Hasil');
disp(dataHasil);
disp('data Top 10 Hasil');
disp(top10data);

% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = cell(0);
set(handles.tableData, 'Data', data);


% --- Executes on button press in resetHasil.
function resetHasil_Callback(hObject, eventdata, handles)
% hObject    handle to resetHasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = cell(0);
set(handles.tabelHasil, 'Data', data);
