function varargout = guiPitchModulation(varargin)
%-----------------------------------------%
% handles.wavfile.data
% handles.wavfile.feq
% handles.wavfile.data1:改变的数据
% handles.wavfile.feq1：改变的采样频率
%-----------------------------------------%
% GUIPITCHMODULATION M-file for guiPitchModulation.fig
%      GUIPITCHMODULATION, by itself, creates a new GUIPITCHMODULATION or raises the existing
%      singleton*.
%
%      H = GUIPITCHMODULATION returns the handle to a new GUIPITCHMODULATION or the handle to
%      the existing singleton*.
%
%      GUIPITCHMODULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIPITCHMODULATION.M with the given input arguments.
%
%      GUIPITCHMODULATION('Property','Value',...) creates a new GUIPITCHMODULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiPitchModulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiPitchModulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiPitchModulation

% Last Modified by GUIDE v2.5 13-Jun-2011 11:04:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiPitchModulation_OpeningFcn, ...
                   'gui_OutputFcn',  @guiPitchModulation_OutputFcn, ...
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


% --- Executes just before guiPitchModulation is made visible.
function guiPitchModulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiPitchModulation (see VARARGIN)

% Choose default command line output for guiPitchModulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiPitchModulation wait for user response (see UIRESUME)
% uiwait(handles.guiPitchModulation);


% --- Outputs from this function are returned to the command line.
function varargout = guiPitchModulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sliderPitchModulation_Callback(hObject, eventdata, handles)
% hObject    handle to sliderPitchModulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.wavfile.feq1=get(handles.sliderPitchModulation,'Value');
guidata(hObject, handles);

if(get(handles.radioCPCS,'Value'))
    data=handles.wavfile.data;
    data1=data;
    Fs=handles.wavfile.feq1;
    t=(0:length(data)-1)/Fs;
    plot(t,data);
    axis([min(t) max(t) min(data)*1.2 max(data)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');
elseif(get(handles.radioCSR,'Value'))
    Fs1=handles.wavfile.feq1;
    Fs=handles.wavfile.feq;
    data=handles.wavfile.data;
    L=length(data);
    L1=round(L*Fs1/Fs);%新数据长度
    df=L-L1;
    data1=data;
    if(df~=0)
        T=round(L/abs(df));
        if(df>0)
            data1=enframe(data,T);
            data1=data1(:,1:end-1);
            data1=data1';
            data1=data1(:);
        else
            data1=enframe(data,T);
            insertdata=zeros(size(data1,1),1);
            for i=1:size(data1,1)-1
                insertdata(i)=(data1(i,end)+data1(i+1,1))*0.5;
            end
            insertdata(size(data1,1))=data1(end,end);
            data1=[data1,insertdata];
            data1=data1';
            data1=data1(:);
        end
    end
    t=(0:length(data1)-1)/Fs1;
    plot(t,data1);
    axis([min(t) max(t) min(data1)*1.2 max(data1)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');
elseif(get(handles.radioCSNCP,'Value'))
    scale=get(handles.sliderPitchModulation,'Value')/handles.wavfile.feq;
    [xfinal,Fs]=TSM_Using_STFTM(handles.wavfile.data,handles.wavfile.feq,scale);
    data1=xfinal;
    handles.wavfile.feq1=Fs;
    guidata(hObject, handles);

    t=(0:length(data1)-1)/Fs;
    plot(t,data1);
    axis([min(t) max(t) min(data1)*1.2 max(data1)*1.2]);
    xlabel('Time/sss');
    ylabel('Amplitude');
else
    semitone=get(handles.sliderPitchModulation,'Value')/handles.wavfile.feq;
    semitone=log10(semitone)*39.6;
    [xfinal,Fs]=Pitch_Modification(handles.wavfile.data,handles.wavfile.feq,semitone);
    data1=xfinal;
    handles.wavfile.feq1=Fs;
    guidata(hObject, handles);

    t=(0:length(data1)-1)/Fs;
    plot(t,data1);
    axis([min(t) max(t) min(data1)*1.2 max(data1)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');
end
handles.wavfile.data1=data1;
guidata(hObject, handles);

if(get(handles.radioCPCS,'Value'))
    set(handles.txtSamplingRate,'String',strcat(num2str(handles.wavfile.feq1),'Hz'));
    set(handles.txtPitch,'String',strcat(num2str(handles.wavfile.feq1/handles.wavfile.feq),' Unit'));
elseif(get(handles.radioCSR,'Value'))
    set(handles.txtSamplingRate,'String',strcat(num2str(handles.wavfile.feq1),'Hz'));
    set(handles.txtPitch,'String','1 Unit');
elseif(get(handles.radioCSNCP,'Value'))
    set(handles.txtSamplingRate,'String',strcat(num2str(handles.wavfile.feq1),'Hz'));
    set(handles.txtPitch,'String','1 Unit');
else
    set(handles.txtSamplingRate,'String',strcat(num2str(handles.wavfile.feq1),'Hz'));
    set(handles.txtPitch,'String',strcat(num2str(get(handles.sliderPitchModulation,'Value')/handles.wavfile.feq),' Unit'));
end

% --- Executes during object creation, after setting all properties.
function sliderPitchModulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderPitchModulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% set(handles.sliderPitchModulation,'Max',20000);
% set(handles.sliderPitchModulation,'Min',5000);
% set(handles.sliderPitchModulation,'Value',10000);

% --- Executes on button press in radioCPCS.
function radioCPCS_Callback(hObject, eventdata, handles)% Converting Pitch Changing Voice Speech
% hObject    handle to radioCPCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioCPCS
set(handles.radioCPCS,'Value',1);
set(handles.radioCSR,'Value',0);
set(handles.radioCPNCS,'Value',0);
set(handles.radioCSNCP,'Value',0);
sliderPitchModulation_Callback(hObject, eventdata, handles);

% --- Executes on button press in radioCSR.
function radioCSR_Callback(hObject, eventdata, handles)% Coverting Sampling Rate
% hObject    handle to radioCSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioCSR
set(handles.radioCPCS,'Value',0);
set(handles.radioCSR,'Value',1);
set(handles.radioCPNCS,'Value',0);
set(handles.radioCSNCP,'Value',0);
sliderPitchModulation_Callback(hObject, eventdata, handles);

% --- Executes on button press in btnPlay.
function btnPlay_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.wavfile.data;
% Fs=handles.wavfile.feq;
data1=handles.wavfile.data1;
Fs1=handles.wavfile.feq1;
if(get(handles.radioCPCS,'Value'))
    wavplay(data,Fs1);
elseif(get(handles.radioCSR,'Value'))
    wavplay(data1,Fs1);
elseif(get(handles.radioCSNCP,'Value'))
    wavplay(data1,Fs1);
else
    wavplay(data1,Fs1);
end


% --- Executes on button press in radioCSNCP.
function radioCSNCP_Callback(hObject, eventdata, handles)
% hObject    handle to radioCSNCP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioCSNCP
set(handles.radioCPCS,'Value',0);
set(handles.radioCSR,'Value',0);
set(handles.radioCPNCS,'Value',0);
set(handles.radioCSNCP,'Value',1);
sliderPitchModulation_Callback(hObject, eventdata, handles);

% --- Executes on button press in radioCPNCS.
function radioCPNCS_Callback(hObject, eventdata, handles)
% hObject    handle to radioCPNCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioCPNCS
set(handles.radioCPCS,'Value',0);
set(handles.radioCSR,'Value',0);
set(handles.radioCPNCS,'Value',1);
set(handles.radioCSNCP,'Value',0);
sliderPitchModulation_Callback(hObject, eventdata, handles);


% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data1=handles.wavfile.data1;
Fs1=handles.wavfile.feq1;
[fname pathname]=uiputfile('.wav','Save file');
if ~isequal(fname,0)
    S=sprintf('%s%s',pathname,fname);
    wavwrite(data1,Fs1,S);
end


% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname pathname]=uigetfile('*.wav','Pick file');
if ~isequal(fname,0)
    S=sprintf('%s%s',pathname,fname);
    [y,Fs]=wavread(S);

    %---------------音频文件数据----------------------%
    y=y/max(y);
    handles.wavfile.data=y;%音频数据
    handles.wavfile.data1=y;%音频数据副本
    handles.wavfile.feq=Fs;%声音频率
    handles.wavfile.feq1=Fs;

    handles.wavfile.filename=fname;%文件名
    handles.wavfile.pathname=pathname;%路径名
    %------------------------------------------------&
    guidata(hObject,handles);
    
    set(handles.sliderPitchModulation,'Value',handles.wavfile.feq);
    set(handles.sliderPitchModulation,'Max',2*handles.wavfile.feq);
    set(handles.sliderPitchModulation,'Min',0.5*handles.wavfile.feq);
    set(handles.sliderPitchModulation,'Enable','on');
    set(handles.radioCPCS,'Value',1);
    set(handles.radioCPCS,'Enable','on');
    set(handles.radioCSR,'Value',0);
    set(handles.radioCSR,'Enable','on');
    set(handles.radioCSNCP,'Value',0);
    set(handles.radioCSNCP,'Enable','on');
    set(handles.radioCPNCS,'Value',0);
    set(handles.radioCPNCS,'Enable','on');
    set(handles.btnPlay,'Enable','on');
    set(handles.btnSave,'Enable','on');
    set(handles.txtSamplingRate,'String',strcat(num2str(handles.wavfile.feq1),'Hz'));
    set(handles.txtPitch,'String','1 Unit');

    data=handles.wavfile.data;
    Fs=handles.wavfile.feq;
    t=(0:length(data)-1)/Fs;
    plot(t,data);
    axis([min(t) max(t) min(data)*1.2 max(data)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');
    guidata(hObject,handles);
end


% --------------------------------------------------------------------
function menuExit_Callback(hObject, eventdata, handles)
% hObject    handle to menuExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

