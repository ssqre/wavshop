function varargout = guiLPC(varargin)
%-----------------------------------------%
% handles.wavfile.data:
% handles.wavfile.feq:
% handles.wavfile.syndata:LPC合成数据
%-----------------------------------------%
% GUILPC M-file for guiLPC.fig
%      GUILPC, by itself, creates a new GUILPC or raises the existing
%      singleton*.
%
%      H = GUILPC returns the handle to a new GUILPC or the handle to
%      the existing singleton*.
%
%      GUILPC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUILPC.M with the given input arguments.
%
%      GUILPC('Property','Value',...) creates a new GUILPC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiLPC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiLPC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiLPC

% Last Modified by GUIDE v2.5 01-Dec-2010 23:06:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiLPC_OpeningFcn, ...
                   'gui_OutputFcn',  @guiLPC_OutputFcn, ...
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


% --- Executes just before guiLPC is made visible.
function guiLPC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiLPC (see VARARGIN)

% Choose default command line output for guiLPC
handles.output = hObject;

handles.wavfile.data=varargin{1};
handles.wavfile.feq=varargin{2};

%---------------显示Original Speech-------------%
data=handles.wavfile.data;
Fs=handles.wavfile.feq;
t=(0:length(data)-1)/Fs;
plot(handles.axesOriginal,t,data);
axis(handles.axesOriginal,[min(t) max(t) min(data)*1.2 max(data)*1.2]);
% xlabel(handles.axesOriginal,'Time/s');
ylabel(handles.axesOriginal,'Original Speech');

xrange=get(handles.axesOriginal,'XLim');
TT1=xrange(2)/2-256/Fs;
TT2=xrange(2)/2;
dualcursor([TT1,TT2],[.02 0.8;.02 0.9],'ro',[],handles.axesOriginal);
%-----------------------------------------------%

%-----------------------------------------------%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiLPC wait for user response (see UIRESUME)
% uiwait(handles.guiLPC);


% --- Outputs from this function are returned to the command line.
function varargout = guiLPC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnPlayOriginal.
function btnPlayOriginal_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlayOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.wavfile.data;
Fs=handles.wavfile.feq;
wavplay(data,Fs);

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.wavfile.syndata;
Fs=handles.wavfile.feq;
[fname pathname]=uiputfile('.wav','Save file');
if ~isequal(fname,0)
    S=sprintf('%s%s',pathname,fname);
    wavwrite(data,Fs,S);
end

% --- Executes on selection change in popLPCOrder.
function popLPCOrder_Callback(hObject, eventdata, handles)
% hObject    handle to popLPCOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popLPCOrder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLPCOrder


% --- Executes during object creation, after setting all properties.
function popLPCOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLPCOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnPlaySynthesis.
function btnPlaySynthesis_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlaySynthesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.wavfile.syndata;
Fs=handles.wavfile.feq;
wavplay(data,Fs);

% --- Executes on button press in btnSynthesis.
function btnSynthesis_Callback(hObject, eventdata, handles)
% hObject    handle to btnSynthesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.wavfile.data;
Fs=handles.wavfile.feq;
syndata=zeros(1,length(data));
framelength=128;
frametrans=32;
framedata=enframe(data,framelength,frametrans);
pOrder=get(handles.popLPCOrder,'Value'); 
for k=1:size(framedata,1)
    data1=framedata(k,:).*hamming(length(framedata(k,:)))';
    [a,g]=lpc(data1,pOrder);
%     xic=filtic(sqrt(g),a,data1(length(a)-1:-1:1),1);%该语句(170)与下一句(171)合起来等价于est_data1=generatedata(a,data1);
%     excitation=geneExcitation(1,length(data1));
%     est_data1=filter(sqrt(g),a,excitation);
    est_data1=filter(0-a(2:end),1,data1);
% %     est_data1=generatedata(a,data1);
    if((k-1)*frametrans+length(est_data1)<=length(syndata))
        syndata(1+(k-1)*frametrans:(k-1)*frametrans+length(est_data1))=syndata(1+(k-1)*frametrans:(k-1)*frametrans+length(est_data1))+est_data1;        
    else
        syndata(1+(k-1)*frametrans:length(syndata))=syndata(1+(k-1)*frametrans:length(syndata))+est_data1(1:length(syndata)-(k-1)*frametrans:length(syndata));
    end
end

syndata=syndata/max(syndata);
t=(0:length(data)-1)/Fs;
plot(handles.axesSynthesis,t,syndata);
axis(handles.axesSynthesis,[min(t) max(t) min(syndata)*1.2 max(syndata)*1.2]);
xlabel(handles.axesSynthesis,'Time/s');
ylabel(handles.axesSynthesis,'Synthesis Speech');

handles.wavfile.syndata=syndata;
set(handles.btnPlaySynthesis,'Enable','on');
set(handles.btnSave,'Enable','on');
guidata(hObject, handles);


% --- Executes on button press in btnLPCAnalysis.
function btnLPCAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to btnLPCAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.wavfile.data;
Fs=handles.wavfile.feq;
axes(handles.axesOriginal);
val=dualcursor;
data1=data(ceil(val(1)*Fs):floor(val(3)*Fs));
data1=data1.*hamming(length(data1));
%---------------------LPC Spectrum---------------%
pOrder=get(handles.popLPCOrder,'Value');
a=lpc(data1,pOrder);
[h,f]=freqz(1,a,512,Fs);
plot(handles.axesSegLPC,f,20*log10(abs(h)+eps));
%------------------------------------------------%
hold(handles.axesSegLPC,'on');
%-----------------------FFT Spectrum---------------%
Y=fft(data1.*hamming(length(data1)));
f=(0:length(Y)/2)*Fs/length(Y);
plot(handles.axesSegLPC,f,20*log10(abs(Y(1:length(f)))+eps),'g');
%--------------------------------------------------%
axes(handles.axesSegLPC);
legend('LPC Spectrum','DFT Spectrum');
xlabel(handles.axesSegLPC,'Frequency (Hz)');
ylabel(handles.axesSegLPC,'Gain (dB)');
hold(handles.axesSegLPC,'off');
%---------------------极点图-----------------------%
axes(handles.axesSegPole);
zplane([1,0],a);

function y=generatedata(a,data)
% a:线性预测系数
% data：方程的初始状态，length(data)=length(a)-1
y=zeros(1,length(data));
p=length(a)-1;
x=data(1:p);
y(1:p)=x;
for k=(p+1):length(data)
    y(k)=-a(2:end)*y(k-1:-1:k-p)';
end

function y=geneExcitation(cL,dL)
% dL:数据长度
% cL：周期长度
l=ceil(dL/cL);
y=[ones(1,l);zeros(cL-1,l)];
y=y(:)';
y=y(1:dL);






