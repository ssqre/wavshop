function varargout = guiWavShop(varargin)
%---------------handles数据结构-------------%
%--------文件数据-----------%
% handles.wavfile.data：音频数据，即原始装载或录音数据
% handles.wavfile.data1：音频副本数据,原始数据如有修改，存此
% handles.wavfile.feq：声音频率
% handles.wavfile.nbit：声音存储的bit数
% handles.wavfile.filename：文件名
% handles.wavfile.pathname：路径名
%--------------------------%
%------标识数据--------------%
% handles.flag.save:是否已保存0:未保存1：已保存
% handles.flag.blank:是否装载有波形0：未装载1：已装载
% handles.flag.opname:操作标识，=0表示没有操作，1标识Extract，2标识Trim
% handles.flag.oplevel:当前操作次数
% handles.flag.opL:每次操作的数据的长度
%---------------------------%

%-------初始化数据---------%(just for Zoon In/Out)
% handles.init.Left:显示坐标轴左端
% handles.init.Right:显示坐标轴右端
% handles.init.ZoonLevel:缩放水平
% handles.init.Left1=Left1;
% handles.init.Right1=Right1;
%------------------------%
% GUIWAVSHOP M-file for guiWavShop.fig
%      GUIWAVSHOP, by itself, creates a new GUIWAVSHOP or raises the existing
%      singleton*.
%
%      H = GUIWAVSHOP returns the handle to a new GUIWAVSHOP or the handle to
%      the existing singleton*.
%
%      GUIWAVSHOP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIWAVSHOP.M with the given input arguments.
%
%      GUIWAVSHOP('Property','Value',...) creates a new GUIWAVSHOP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiWavShop_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiWavShop_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiWavShop

% Last Modified by GUIDE v2.5 29-Nov-2011 15:36:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiWavShop_OpeningFcn, ...
                   'gui_OutputFcn',  @guiWavShop_OutputFcn, ...
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


% --- Executes just before guiWavShop is made visible.
function guiWavShop_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiWavShop (see VARARGIN)

% Choose default command line output for guiWavShop
handles.output = hObject;

%--------------标识数据初始化-------------------------%
handles.flag.save=0;
handles.flag.blank=0;
handles.flag.opname=0;
handles.flag.oplevel=1;
handles.flag.opL=0;
%----------------------------------------------%
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiWavShop wait for user response (see UIRESUME)
% uiwait(handles.guiWavShop);


% --- Outputs from this function are returned to the command line.
function varargout = guiWavShop_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

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


% --------------------------------------------------------------------
function menuNew_Callback(hObject, eventdata, handles)
% hObject    handle to menuNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------标识数据初始化-------------------------%
handles.flag.save=0;
handles.flag.blank=0;
handles.flag.opname=0;
handles.flag.oplevel=1;
handles.flag.opL=0;
guidata(hObject,handles);
%----------------------------------------------%

[fname pathname]=uigetfile('*.wav','Pick file');
if ~isequal(fname,0)
    S=sprintf('%s%s',pathname,fname);
    [y,Fs,nbit]=wavread(S);

    %---------------音频文件数据----------------------%
    y=y/max(y);
    handles.wavfile.data=y;%音频数据
    handles.wavfile.data1=y;%音频数据副本
    handles.wavfile.feq=Fs;%声音频率
    handles.wavfile.nbit=nbit;%声音存储的bit数
    handles.wavfile.filename=fname;%文件名
    handles.wavfile.pathname=pathname;%路径名
    %------------------------------------------------&
    %--------------初始化数据-------------------------%
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
    %------------------------------------------------%
    handles.flag.blank=1;
    guidata(hObject,handles);

    t=(1:length(y))/Fs;
    plot(t,y);
    axis([min(t) max(t) min(y)*1.2 max(y)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');

    my_isdqrexist();
    set(handles.txtDispFile,'String',fname);
    set(handles.txtDispFeq,'String',strcat(num2str(Fs),'Hz'));
    set(handles.menuZoonInOrOut,'Enable','on');
    set(handles.menuPlay,'Enable','on');
    set(handles.menuExtract,'Enable','on');
    set(handles.menuTrim,'Enable','on');
    set(handles.menuSaveAs,'Enable','off');
    set(handles.menuAnalysis,'Enable','on');
    set(handles.menuAplications,'Enable','on');
    set(handles.sliderSpeechDisplay,'Visible','off');
end

% --------------------------------------------------------------------
function menuSaveAs_Callback(hObject, eventdata, handles)
% hObject    handle to menuSaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % Left=handles.init.Left;
% % Right=handles.init.Right;
Fs=handles.wavfile.feq;
N=handles.wavfile.nbit;
% % y=ceil(Left*handles.wavfile.feq):floor(Right*handles.wavfile.feq);
[fname pathname]=uiputfile('.wav','Save file');
if ~isequal(fname,0)
    S=sprintf('%s%s',pathname,fname);
    wavwrite(handles.wavfile.data1,Fs,N,S);
    handles.flag.save=0;
    handles.wavfile.filename=fname;
    handles.wavfile.pathname=pathname;
    guidata(hObject, handles);
    set(handles.txtDispFile,'String',fname);
end

% --------------------------------------------------------------------
function menuExit_Callback(hObject, eventdata, handles)
% hObject    handle to menuExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(hObject);
close all;

% --------------------------------------------------------------------
function menuBlank_Callback(hObject, eventdata, handles)
% hObject    handle to menuBlank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.flag.save=0;
handles.flag.blank=0;
handles.flag.opname=0;
handles.flag.oplevel=1;
handles.flag.opL=0;
handles.wavfile.pathname=pwd;
handles.wavfile.filename='blank';
guidata(hObject, handles);


set(handles.txtDispFile,'String',handles.wavfile.filename);
set(handles.txtDispFeq,'String',strcat('0','Hz'));
set(handles.menuZoonInOrOut,'Enable','off');
set(handles.menuExtract,'Enable','off');
set(handles.menuTrim,'Enable','off');
set(handles.menuUndo,'Enable','off');
set(handles.menuPlay,'Enable','off');
set(handles.menuSaveAs,'Enable','off');
set(handles.menuAnalysis,'Enable','off');
set(handles.menuAplications,'Enable','off');
set(handles.sliderSpeechDisplay,'Visible','off');
plot(0,0);
% --------------------------------------------------------------------
function menuWaveGenerator_Callback(hObject, eventdata, handles)
% hObject    handle to menuWaveGenerator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.wavfile,handles.flag,handles.init]=guiGenerator();
if(handles.wavfile.feq~=0)
    guidata(hObject, handles);
    t=(1:length(handles.wavfile.data1))/handles.wavfile.feq;
    axes(handles.axSpeechDisplay);
    plot(handles.axSpeechDisplay,t,handles.wavfile.data1);
    axis([min(t) max(t) min(handles.wavfile.data1)*1.2 max(handles.wavfile.data1)*1.2]);
%     set(handles.axSpeechDisplay,'YLim',[-1.6*max(handles.wavfile.data1) 1.6*max(handles.wavfile.data1)]);
    xlabel('Time/s');
    ylabel('Amplitude');
    %--------------激活按钮---------------------%
    my_isdqrexist();
    set(handles.txtDispFile,'String',handles.wavfile.filename);
    set(handles.txtDispFeq,'String',strcat(num2str(handles.wavfile.feq),'Hz'));
    set(handles.menuZoonInOrOut,'Enable','on');
    set(handles.menuPlay,'Enable','on');
    set(handles.menuExtract,'Enable','on');
    set(handles.menuTrim,'Enable','on');
    set(handles.menuSaveAs,'Enable','on');
    set(handles.menuAnalysis,'Enable','on');
    set(handles.menuAplications,'Enable','on');
    set(handles.sliderSpeechDisplay,'Visible','off');
end

% --------------------------------------------------------------------
function menuWaveRecorder_Callback(hObject, eventdata, handles)
% hObject    handle to menuWaveRecorder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.wavfile,handles.flag,handles.init]=guiRecorder();
if(handles.wavfile.feq~=0)
    guidata(hObject, handles);
    t=(1:length(handles.wavfile.data1))/handles.wavfile.feq;
    axes(handles.axSpeechDisplay);
    plot(handles.axSpeechDisplay,t,handles.wavfile.data1);
    axis([min(t) max(t) min(handles.wavfile.data1)*1.2 max(handles.wavfile.data1)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');
    %--------------激活按钮---------------------%
    my_isdqrexist();
    set(handles.txtDispFile,'String',handles.wavfile.filename);
    set(handles.txtDispFeq,'String',strcat(num2str(handles.wavfile.feq),'Hz'));
    set(handles.menuZoonInOrOut,'Enable','on');
    set(handles.menuPlay,'Enable','on');
    set(handles.menuExtract,'Enable','on');
    set(handles.menuTrim,'Enable','on');
    set(handles.menuSaveAs,'Enable','on');
    set(handles.menuAnalysis,'Enable','on');
    set(handles.menuAplications,'Enable','on');
    set(handles.sliderSpeechDisplay,'Visible','off');
end


% --------------------------------------------------------------------
function menuEdit_Callback(hObject, eventdata, handles)
% hObject    handle to menuEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuZoonInOrOut_Callback(hObject, eventdata, handles)
% hObject    handle to menuZoonInOrOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Left=handles.init.Left;
Right=handles.init.Right;
ZoonLevel=handles.init.ZoonLevel;
Left1=handles.init.Left1;
Right1=handles.init.Right1;
Fs=handles.wavfile.feq;

while(1)
    [xx,yy,btn]=ginput(2);
    if(btn(1)==1&&btn(2)==1)
        if(xx(2)>xx(1))
            Left=xx(1);
            Right=xx(2);
        else
            Left=xx(2);
            Right=xx(1);
        end
        if(Left<Left1(ZoonLevel))
            Left=Left1(ZoonLevel);
        end
        if(Right>Right1(ZoonLevel))
            Right=Right1(ZoonLevel);
        end
        ZoonLevel=ZoonLevel+1;
        Left1(ZoonLevel)=Left;
        Right1(ZoonLevel)=Right;
        y=ceil(Left*Fs):floor(Right*Fs);
        t=y/Fs;
        plot(t,handles.wavfile.data1(y));
        axis([min(t) max(t) min(handles.wavfile.data1(y))*1.2 max(handles.wavfile.data1(y))*1.2]);
        xlabel('Time/s');
        ylabel('Amplitude');
    elseif((btn(1)==1&&btn(2)==3)||(btn(1)==3&&btn(2)==1))
        ZoonLevel=ZoonLevel-1;
        if(ZoonLevel<=0)
            ZoonLevel=1;
        end
        Left=Left1(ZoonLevel);
        Right=Right1(ZoonLevel);
        y=ceil(Left*Fs):floor(Right*Fs);
        t=y/Fs;
        plot(t,handles.wavfile.data1(y));
        axis([min(t) max(t) min(handles.wavfile.data1(y))*1.2 max(handles.wavfile.data1(y))*1.2]);
        xlabel('Time/s');
        ylabel('Amplitude');
    elseif(btn(1)==3&&btn(2)==3)
        handles.init.Left=Left;
        handles.init.Right=Right;
        handles.init.ZoonLevel=ZoonLevel;
        handles.init.Left1=Left1;
        handles.init.Right1=Right1;
        guidata(hObject, handles);
        break;
    end
end

%-----------初始化sliderSpeechDisplay------------%
if(handles.init.ZoonLevel>1)
    set(handles.sliderSpeechDisplay,'Visible','on');
    WindowLength=ceil((Right-Left)*Fs);
    DataLength=length(handles.wavfile.data1);
    set(handles.sliderSpeechDisplay,'Min',1);
    set(handles.sliderSpeechDisplay,'Max',DataLength-WindowLength);
    set(handles.sliderSpeechDisplay,'Value',Left*Fs);
else
    set(handles.sliderSpeechDisplay,'Visible','off');
end
%----------------------------------------------%

% --------------------------------------------------------------------
function menuTrim_Callback(hObject, eventdata, handles)
% hObject    handle to menuTrim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xx,yy,btn]=ginput(2);
if(btn(1)==1&&btn(2)==1)
    x1=handles.wavfile.data1;
    x2=handles.wavfile.feq;
    x3=handles.wavfile.nbit;
    x4=handles.flag.save;
    x5=handles.flag.blank;
    x6=handles.flag.opname;
    x7=handles.flag.oplevel;
    handles.flag.opL(x7)=length(x1);
    guidata(hObject, handles);
    my_datawrite(x1,x2,x3,x4,x5,x6,x7);
    Fs=handles.wavfile.feq;
    if(xx(2)>xx(1))
        Left=xx(1);
        Right=xx(2);
    else
        Left=xx(2);
        Right=xx(1);
    end
    if(Left<0)
        Left=0.001;
    end
    if(Right>length(handles.wavfile.data1)/Fs)
        Right=length(handles.wavfile.data1)/Fs;
    end
    y=[ceil(0.001*Fs:(Left*Fs)),floor((Right*Fs):length(handles.wavfile.data1))];
    handles.wavfile.data1=handles.wavfile.data1(y);
    t=(1:length(handles.wavfile.data1))/Fs;
    handles.flag.opname=2;
    handles.flag.oplevel=handles.flag.oplevel+1;
    handles.flag.save=1;
    guidata(hObject, handles);

    plot(t,handles.wavfile.data1);
    axis([min(t) max(t) min(handles.wavfile.data1)*1.2 max(handles.wavfile.data1)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');

    my_initdata;
    set(handles.menuSaveAs,'Enable','on');
    set(handles.menuUndo,'Enable','on');
    set(handles.sliderSpeechDisplay,'Visible','off');
end
% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close guiWavShop.
function guiWavShop_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to guiWavShop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mblank=handles.flag.blank;
if(mblank==0)
    delete(hObject);
    close all;
else
    mflag=handles.flag.save;
    if(mflag==0)
        delete(hObject);
        close all;
    else
        mfname=handles.wavfile.filename;
        mpathname=handles.wavfile.pathname;
        filename=fullfile(mpathname,mfname);
        diag=['Save changes to ',filename];
        answer=questdlg(diag,'Exit WaveShop Confirm','Yes','No','Cancel','Cancel');
        switch(answer)
            case 'Yes'
                menuSaveAs_Callback(hObject, eventdata, handles);
                delete(hObject);
                close all;
            case 'No'
                delete(hObject);
                close all;
        end
    end
end


% --------------------------------------------------------------------
function menuPlay_Callback(hObject, eventdata, handles)
% hObject    handle to menuPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=get(handles.axSpeechDisplay,'XLim');
Fs=handles.wavfile.feq;
y=ceil(T(1)*Fs):floor(T(2)*Fs);
wavplay(handles.wavfile.data1(y),Fs);


% --------------------------------------------------------------------
function menuExtract_Callback(hObject, eventdata, handles)
% hObject    handle to menuExtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xx,yy,btn]=ginput(2);
if(btn(1)==1&&btn(2)==1)
    x1=handles.wavfile.data1;
    x2=handles.wavfile.feq;
    x3=handles.wavfile.nbit;
    x4=handles.flag.save;
    x5=handles.flag.blank;
    x6=handles.flag.opname;
    x7=handles.flag.oplevel;
    handles.flag.opL(x7)=length(x1);
    guidata(hObject, handles);
    my_datawrite(x1,x2,x3,x4,x5,x6,x7);
    Fs=handles.wavfile.feq;
    if(xx(2)>xx(1))
        Left=xx(1);
        Right=xx(2);
    else
        Left=xx(2);
        Right=xx(1);
    end
    if(Left<0)
        Left=0.001;
    end
    if(Right>length(handles.wavfile.data1)/Fs)
        Right=length(handles.wavfile.data1)/Fs;
    end
    y=ceil(Left*Fs):floor(Right*Fs);
    handles.wavfile.data1=handles.wavfile.data1(y);
    t=(1:length(handles.wavfile.data1))/Fs;
    handles.flag.opname=1;
    handles.flag.oplevel=handles.flag.oplevel+1;
    handles.flag.save=1;
    guidata(hObject, handles);

    plot(t,handles.wavfile.data1);
    axis([min(t) max(t) min(handles.wavfile.data1)*1.2 max(handles.wavfile.data1)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');

    my_initdata;
    set(handles.menuSaveAs,'Enable','on');
    set(handles.menuUndo,'Enable','on');
    set(handles.sliderSpeechDisplay,'Visible','off');
end
% --------------------------------------------------------------------
function menuUndo_Callback(hObject, eventdata, handles)
% hObject    handle to menuUndo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.flag.oplevel>1)
    [x1,x2,x3,x4,x5,x6,x7]=my_dataread(handles.flag.oplevel,handles.flag.opL);
    handles.wavfile.data1=x1;
    handles.wavfile.feq=x2;
    handles.wavfile.nbit=x3;
    handles.flag.save=x4;
    handles.flag.blank=x5;
    handles.flag.opname=x6;
    handles.flag.oplevel=x7;
    guidata(hObject, handles);
    
    Fs=handles.wavfile.feq;
    t=(1:length(handles.wavfile.data1))/Fs;
    plot(t,handles.wavfile.data1);
    axis([min(t) max(t) min(handles.wavfile.data1)*1.2 max(handles.wavfile.data1)*1.2]);
    xlabel('Time/s');
    ylabel('Amplitude');
    if(handles.flag.oplevel==1)
        set(handles.menuUndo,'Enable','off');
    end
    
    handles.flag.opL=handles.flag.opL(1:handles.flag.oplevel-1);
    guidata(hObject, handles);
    fid=fopen(fullfile(pwd,'data.dqr'), 'rb');
    LL=sum(handles.flag.opL)+length(handles.flag.opL)*6;
    y=fread(fid,LL,'double');
    fclose(fid);

    fid=fopen(fullfile(pwd,'data.dqr'), 'wb');
    fwrite(fid,y,'double');
    fclose(fid); 
end
my_initdata;
set(handles.sliderSpeechDisplay,'Visible','off');

% --------------------------------------------------------------------
function menuBlank_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuBlank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuBlank_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuOpen_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuOpen_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuSaveAs_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuSaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuSaveAs_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuUndo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuUndo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuUndo_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuExtract_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuExtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuExtract_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menuTrim_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuTrim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuTrim_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuZoonInOrOut_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuZoonInOrOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuZoonInOrOut_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuPlay_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menuPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menuPlay_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function menuAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuAplications_Callback(hObject, eventdata, handles)
% hObject    handle to menuAplications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSS_Callback(hObject, eventdata, handles)
% hObject    handle to menuSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guiSyllableSplit(handles.wavfile.data1,handles.wavfile.feq);

% --------------------------------------------------------------------
function menuTDA_Callback(hObject, eventdata, handles)
% hObject    handle to menuTDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuFDA_Callback(hObject, eventdata, handles)
% hObject    handle to menuFDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function sliderSpeechDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSpeechDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Left=handles.init.Left;
Right=handles.init.Right;
ZoonLevel=handles.init.ZoonLevel;
data=handles.wavfile.data1;
Fs=handles.wavfile.feq;

WindowLength=floor((Right-Left)*Fs);
LL=ceil(get(handles.sliderSpeechDisplay,'Value'));
RR=LL+WindowLength;
t=(LL:RR)/Fs;
plot(t,data(LL:RR));
axis([LL/Fs RR/Fs min(data)*1.2 max(data)*1.2]);
xlabel('Time/s');
ylabel('Amplitude');

handles.init.Left=LL/Fs;
handles.init.Right=RR/Fs;
handles.init.Left1(ZoonLevel)=Left;
handles.init.Right1(ZoonLevel)=Right;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sliderSpeechDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSpeechDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function menuModification_Callback(hObject, eventdata, handles)
% hObject    handle to menuModification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=get(handles.axSpeechDisplay,'XLim');
Fs=handles.wavfile.feq;
y=ceil(T(1)*Fs):floor(T(2)*Fs);
guiPitchModulation(handles.wavfile.data1(y),Fs);


% --------------------------------------------------------------------
function menuLPC_Callback(hObject, eventdata, handles)
% hObject    handle to menuLPC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=get(handles.axSpeechDisplay,'XLim');
Fs=handles.wavfile.feq;
y=ceil(T(1)*Fs):floor(T(2)*Fs);
guiLPC(handles.wavfile.data1(y),Fs);


% --------------------------------------------------------------------
function menuDenoising_Callback(hObject, eventdata, handles)
% hObject    handle to menuDenoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
T=get(handles.axSpeechDisplay,'XLim');
Fs=handles.wavfile.feq;
y=ceil(T(1)*Fs):floor(T(2)*Fs);
guiDenoising(handles.wavfile.data1(y),Fs);


% --------------------------------------------------------------------
function menuTTS_Callback(hObject, eventdata, handles)
% hObject    handle to menuTTS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guiTTS;


% --------------------------------------------------------------------
function menuAplications2_Callback(hObject, eventdata, handles)
% hObject    handle to menuAplications2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
