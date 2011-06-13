function varargout = guiDenoising(varargin)
%-----------------------------------------%
% handles.wavfile.data
% handles.wavfile.feq
% handles.wavfile.data1:改变的数据
% handles.wavfile.feq1：改变的采样频率
%-----------------------------------------%
% GUIDENOISING M-file for guiDenoising.fig
%      GUIDENOISING, by itself, creates a new GUIDENOISING or raises the existing
%      singleton*.
%
%      H = GUIDENOISING returns the handle to a new GUIDENOISING or the handle to
%      the existing singleton*.
%
%      GUIDENOISING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDENOISING.M with the given input arguments.
%
%      GUIDENOISING('Property','Value',...) creates a new GUIDENOISING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiDenoising_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiDenoising_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiDenoising

% Last Modified by GUIDE v2.5 12-May-2011 12:01:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiDenoising_OpeningFcn, ...
                   'gui_OutputFcn',  @guiDenoising_OutputFcn, ...
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


% --- Executes just before guiDenoising is made visible.
function guiDenoising_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiDenoising (see VARARGIN)

% Choose default command line output for guiDenoising
handles.output = hObject;

handles.wavfile.data=varargin{1};
handles.wavfile.feq=varargin{2};
handles.wavfile.data1=handles.wavfile.data;
handles.wavfile.feq1=handles.wavfile.feq;

handles.wavfile.T=get(handles.sliderDenoising,'Value');

set(handles.txtThresDisplay,'String',num2str(handles.wavfile.T));
set(handles.sliderDenoising,'Max',6);
set(handles.sliderDenoising,'Min',0);


data=handles.wavfile.data;
Fs=handles.wavfile.feq;
t=(0:length(data)-1)/Fs;
plot(t,data);
axis([min(t) max(t) min(data)*1.2 max(data)*1.2]);
xlabel('Time/s');
ylabel('Amplitude');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiDenoising wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiDenoising_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sliderDenoising_Callback(hObject, eventdata, handles)
% hObject    handle to sliderDenoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slidervalue=get(handles.sliderDenoising,'Value');
handles.wavfile.T=slidervalue;
guidata(hObject, handles);
set(handles.txtThresDisplay,'String',num2str(slidervalue));

% --- Executes during object creation, after setting all properties.
function sliderDenoising_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderDenoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in btnDenoising.
function btnDenoising_Callback(hObject, eventdata, handles)
% hObject    handle to btnDenoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.wavfile.data1,handles.wavfile.feq1]=Denoising(handles.wavfile.data,handles.wavfile.feq,handles.wavfile.T);
guidata(hObject, handles);

data=handles.wavfile.data1;
Fs=handles.wavfile.feq1;
t=(0:length(data)-1)/Fs;
plot(t,data);
axis([min(t) max(t) min(data)*1.2 max(data)*1.2]);
xlabel('Time/s');
ylabel('Amplitude');

% --- Executes on button press in btnPlay.
function btnPlay_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wavplay(handles.wavfile.data1,handles.wavfile.feq1);

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname pathname]=uiputfile('.wav','Save file');
if ~isequal(fname,0)
    S=sprintf('%s%s',pathname,fname);
    wavwrite(handles.wavfile.data1,handles.wavfile.feq,S);
end



% --- 去噪主程序
% input_sigal:输入带噪数据
% fs：采样频率
% choice：算法选择参数
function [output_signal,Fs] = Denoising(input_signal, fs, threshold, choice)

if nargin<4
    choice=0;
end

Fs=fs;

x=input_signal(100000:end,1).';  %remove the beginning of the sample
Nx=length(x);

%algorithm parameters
apriori_SNR=1;  %select 0 for a posteriori SNR estimation and 1 for a priori (see [2])
alpha=0.05;      %only used if apriori_SNR=1
beta1=0.5;
beta2=1;
% lambda=3;
lambda=threshold;

%Signal parameters
t_min=0.4;    %interval for learning the noise
t_max=1.00;   %spectrum (in second)

%STFT parameters
NFFT=1024;
window_length=round(0.031*fs); 
window=hamming(window_length);
window = window(:);
overlap=floor(0.45*window_length); % number of windows samples without overlapping

%construct spectrogram 
signal=x+i*eps;
noverlap=window_length-overlap;
[S,F,T] = spectrogram(signal,window,noverlap,NFFT,fs); %put a short imaginary part to obtain two-sided spectrogram
[Nf,Nw]=size(S);

%----------------------------%
%        noisy spectrum      %
%          extraction        %
%----------------------------%
t_index=find(T>t_min & T<t_max);
absS_vuvuzela=abs(S(:,t_index)).^2;
vuvuzela_spectrum=mean(absS_vuvuzela,2); %average spectrum of the vuvuzela (assumed to be ergodic))
vuvuzela_specgram=repmat(vuvuzela_spectrum,1,Nw);

%---------------------------%
%       Estimate SNR        %
%---------------------------%
absS=abs(S).^2;
SNR_est=max((absS./vuvuzela_specgram)-1,0); % aposteriori SNR
if apriori_SNR==1
    SNR_est=filter((1-alpha),[1 -alpha],SNR_est);  %apriori SNR: see [2]
end    


%---------------------------%
%  Compute attenuation map  %
%---------------------------%
an_lk=max((1-lambda*((1./(SNR_est+1)).^beta1)).^beta2,0);  %an_l_k or anelka, sorry stupid french joke :)
STFT=an_lk.*S;

%--------------------------%
%   Compute Inverse STFT   %
%--------------------------%
ind=mod((1:window_length)-1,Nf)+1;
output_signal=zeros((Nw-1)*overlap+window_length,1);
% Compute Inverse STFT:
h=waitbar(0,'Please wait...');
for indice=1:Nw %Overlapp add technique
    left_index=((indice-1)*overlap) ;
    index=left_index+[1:window_length];
    temp_ifft=real(ifft(STFT(:,indice),NFFT));
    output_signal(index)= output_signal(index)+temp_ifft(ind).*window;
    waitbar(indice/Nw, h);
end
close(h);
output_signal=output_signal/max(output_signal);


