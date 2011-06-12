function varargout = guiGenerator(varargin)
% GUIGENERATOR M-file for guiGenerator.fig
%      GUIGENERATOR, by itself, creates a new GUIGENERATOR or raises the existing
%      singleton*.
%
%      H = GUIGENERATOR returns the handle to a new GUIGENERATOR or the handle to
%      the existing singleton*.
%
%      GUIGENERATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIGENERATOR.M with the given input arguments.
%
%      GUIGENERATOR('Property','Value',...) creates a new GUIGENERATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiGenerator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiGenerator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiGenerator

% Last Modified by GUIDE v2.5 19-Oct-2010 16:16:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiGenerator_OpeningFcn, ...
                   'gui_OutputFcn',  @guiGenerator_OutputFcn, ...
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


% --- Executes just before guiGenerator is made visible.
function guiGenerator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiGenerator (see VARARGIN)

% Choose default command line output for guiGenerator
handles.output = hObject;

handles.wavfile.feq=0;
handles.flag.blank=0;
handles.init.Left=0;
guidata(hObject, handles);
uiwait(handles.guiGenerator);
% Update handles structure
% UIWAIT makes guiGenerator wait for user response (see UIRESUME)
% uiwait(handles.guiGenerator);


% --- Outputs from this function are returned to the command line.
function varargout = guiGenerator_OutputFcn(hObject, eventdata, handles) 
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

% --- Executes on selection change in popTypeOfWave.
function popTypeOfWave_Callback(hObject, eventdata, handles)
% hObject    handle to popTypeOfWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popTypeOfWave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTypeOfWave
% handles.TW=get(handles.popTypeOfWave,'Value');
% guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popTypeOfWave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTypeOfWave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSamplingRate_Callback(hObject, eventdata, handles)
% hObject    handle to txtSamplingRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSamplingRate as text
%        str2double(get(hObject,'String')) returns contents of txtSamplingRate as a double


% --- Executes during object creation, after setting all properties.
function txtSamplingRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSamplingRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to txtFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtFrequency as text
%        str2double(get(hObject,'String')) returns contents of txtFrequency as a double


% --- Executes during object creation, after setting all properties.
function txtFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtTimeLength_Callback(hObject, eventdata, handles)
% hObject    handle to txtTimeLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTimeLength as text
%        str2double(get(hObject,'String')) returns contents of txtTimeLength as a double


% --- Executes during object creation, after setting all properties.
function txtTimeLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTimeLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnGenerate.
function btnGenerate_Callback(hObject, eventdata, handles)
% hObject    handle to btnGenerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TW=get(handles.popTypeOfWave,'Value');
DC=get(handles.slideDutyCycle,'Value');
Fs=str2double(get(handles.txtSamplingRate,'String'));
f=str2double(get(handles.txtFrequency,'String'));
TL=str2double(get(handles.txtTimeLength,'String'));
Amp=str2double(get(handles.txtAmplitude,'String'));

t=0:Fs*TL-1;
switch TW
    case 1
        y=sin(2*pi*f*t/Fs);
    case 2
        y=square(2*pi*f*t/Fs,DC*100);
    case 3
        y=sawtooth(2*pi*f*t/Fs,DC);
    case 4
        y=rand(1,Fs*TL);
        y=y-(max(y)-min(y))/2;
        y=y/max(y);
    otherwise
        y=randn(1,Fs*TL);
        y=y-(max(y)-min(y))/2;
        y=y/max(y);
end

%-------------数据初始化--------------------%
handles.flag.save=0;
handles.flag.blank=0;
handles.flag.opname=0;
handles.flag.oplevel=1;
handles.flag.opL=0;
handles.wavfile.data=Amp*y;%音频数据
handles.wavfile.data1=Amp*y;%音频数据副本,所有处理用副本数据
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
uiresume(handles.guiGenerator);


% --- Executes when user attempts to close guiGenerator.
function guiGenerator_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to guiGenerator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(handles.guiGenerator);


% --- Executes on key press with focus on popTypeOfWave and none of its controls.
function popTypeOfWave_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popTypeOfWave (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function txtAmplitude_Callback(hObject, eventdata, handles)
% hObject    handle to txtAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtAmplitude as text
%        str2double(get(hObject,'String')) returns contents of txtAmplitude as a double


% --- Executes during object creation, after setting all properties.
function txtAmplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slideDutyCycle_Callback(hObject, eventdata, handles)
% hObject    handle to slideDutyCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slideDutyCycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slideDutyCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


