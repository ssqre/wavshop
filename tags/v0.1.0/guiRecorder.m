function varargout = guiRecorder(varargin)
% GUIRECORDER M-file for guiRecorder.fig
%      GUIRECORDER, by itself, creates a new GUIRECORDER or raises the existing
%      singleton*.
%
%      H = GUIRECORDER returns the handle to a new GUIRECORDER or the handle to
%      the existing singleton*.
%
%      GUIRECORDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIRECORDER.M with the given input arguments.
%
%      GUIRECORDER('Property','Value',...) creates a new GUIRECORDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiRecorder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiRecorder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiRecorder

% Last Modified by GUIDE v2.5 05-Oct-2010 19:44:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiRecorder_OpeningFcn, ...
                   'gui_OutputFcn',  @guiRecorder_OutputFcn, ...
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


% --- Executes just before guiRecorder is made visible.
function guiRecorder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiRecorder (see VARARGIN)

% Choose default command line output for guiRecorder
handles.output = hObject; 
% Update handles structure
handles.wavfile.feq=0;
handles.flag.blank=0;
handles.init.Left=0;
guidata(hObject, handles);
uiwait(handles.guiRecorder);
% UIWAIT makes guiRecorder wait for user response (see UIRESUME)
% uiwait(handles.guiRecorder);


% --- Outputs from this function are returned to the command line.
function varargout = guiRecorder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1}=handles.wavfile;
varargout{2}=handles.flag;
varargout{3}=handles.init;
close(hObject);
delete(hObject);


% --- Executes on button press in btnRecord.
function btnRecord_Callback(hObject, eventdata, handles)
% hObject    handle to btnRecord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=str2double(get(handles.txtRecord,'String'));
Fs=10000;
y=wavrecord(T*Fs,Fs);
y=y/max(y)*0.618;
%-------------数据初始化--------------------%
handles.flag.save=0;
handles.flag.blank=0;
handles.flag.opname=0;
handles.flag.oplevel=1;
handles.flag.opL=0;
handles.wavfile.data=y;%音频数据
handles.wavfile.data1=y;%音频数据副本,所有处理用副本数据
handles.wavfile.feq=Fs;%声音频率
handles.wavfile.nbit=16;%声音存储的bit数
handles.wavfile.filename='untitled.wav';%文件名
handles.wavfile.pathname=pwd;%路径名
Left=0.001;
Right=length(y)/Fs;
ZoonLevel=1;
Left1(ZoonLevel)=Left;
Right1(ZoonLevel)=Right;
handles.init.Left=Left;%显示坐标轴左端
handles.init.Right=Right;%显示坐标轴右端
handles.init.ZoonLevel=ZoonLevel;%缩放水平
handles.init.Left1=Left1;
handles.init.Right1=Right1;
guidata(hObject, handles);
uiresume(handles.guiRecorder);


function txtRecord_Callback(hObject, eventdata, handles)
% hObject    handle to txtRecord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRecord as text
%        str2double(get(hObject,'String')) returns contents of txtRecord as a double


% --- Executes during object creation, after setting all properties.
function txtRecord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRecord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close guiRecorder.
function guiRecorder_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to guiRecorder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(handles.guiRecorder);

