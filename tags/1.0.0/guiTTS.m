function varargout = guiTTS(varargin)
% GUITTS M-file for guiTTS.fig
%      GUITTS, by itself, creates a new GUITTS or raises the existing
%      singleton*.
%
%      H = GUITTS returns the handle to a new GUITTS or the handle to
%      the existing singleton*.
%
%      GUITTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITTS.M with the given input arguments.
%
%      GUITTS('Property','Value',...) creates a new GUITTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiTTS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiTTS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiTTS

% Last Modified by GUIDE v2.5 29-May-2011 14:23:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiTTS_OpeningFcn, ...
                   'gui_OutputFcn',  @guiTTS_OutputFcn, ...
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


% --- Executes just before guiTTS is made visible.
function guiTTS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiTTS (see VARARGIN)

% Choose default command line output for guiTTS
handles.output = hObject;

voicelist=tts('','list');
set(handles.popVoice,'String',voicelist);
set(handles.popVoice,'Value',1);
set(handles.popVoiceSpeed,'Value',7);
set(handles.popFeq,'Value',2);

handles.wavfile.data = 0;
handles.wavfile.data1 = 0;
handles.wavfile.feq = 0;
handles.wavfile.feq1 = 0;

num = get(handles.popVoice,'Value');
voice = get(handles.popVoice,'String');
handles.param.voice = voice(num);

num = get(handles.popVoiceSpeed,'Value');
voicespeed = str2double(get(handles.popVoiceSpeed,'String'));
handles.param.voicespeed = voicespeed(num);

num = get(handles.popFeq,'Value');
feq = str2double(get(handles.popFeq,'String'));
handles.param.feq = feq(num);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiTTS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiTTS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtInput_Callback(hObject, eventdata, handles)
% hObject    handle to txtInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtInput as text
%        str2double(get(hObject,'String')) returns contents of txtInput as a double


% --- Executes during object creation, after setting all properties.
function txtInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popVoiceSpeed.
function popVoiceSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to popVoiceSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popVoiceSpeed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popVoiceSpeed
num = get(handles.popVoiceSpeed,'Value');
voicespeed = str2double(get(handles.popVoiceSpeed,'String'));
handles.param.voicespeed = voicespeed(num);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popVoiceSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popVoiceSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popFeq.
function popFeq_Callback(hObject, eventdata, handles)
% hObject    handle to popFeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popFeq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popFeq
num = get(handles.popFeq,'Value');
feq = str2double(get(handles.popFeq,'String'));
handles.param.feq = feq(num);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popFeq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popFeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popVoice.
function popVoice_Callback(hObject, eventdata, handles)
% hObject    handle to popVoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popVoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popVoice
num = get(handles.popVoice,'Value');
voice = get(handles.popVoice,'String');
handles.param.voice = voice(num);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popVoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popVoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSynthesis.
function btnSynthesis_Callback(hObject, eventdata, handles)
% hObject    handle to btnSynthesis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
txt=get(handles.txtInput,'String');
[list,handles.wavfile.data1]=tts(txt, handles.param.voice, handles.param.voicespeed ,handles.param.feq);
handles.wavfile.data1 = handles.wavfile.data1/max(handles.wavfile.data1);
handles.wavfile.feq1 = handles.param.feq;
guidata(hObject, handles);

data=handles.wavfile.data1;
Fs=handles.wavfile.feq1;
t=(0:length(data)-1)/Fs;
plot(t,data);
axis([min(t) max(t) min(data)*1.2 max(data)*1.2]);
xlabel('Time/s');
ylabel('Amplitude');

set(handles.btnPlay,'Enable','on');
set(handles.btnSave,'Enable','on');

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
    wavwrite(handles.wavfile.data1,handles.wavfile.feq1,S);
end


function [str, wav] = tts(txt,voice,pace,fs)
%TTS text to speech.
%   tts (txt) synthesizes speech from string txt, and speaks it. The audio
%   format is mono, 16 bit, 16k Hz by default.
%   
%   wav = tts(txt) does not vocalize but output to the variable wav.
%
%   tts(txt,voice) uses the specific voice. Use tts('','list') to see a
%   list of availble voices. Default is the first voice.
%
%   tts(...,pace) set the pace of speech to pace. pace ranges from 
%   -10 (slowest) to 10 (fastest). Default 0.
%
%   TTS(...,FS) set the sampling rate of the speech to FS kHz. FS must be
%   one of the following: 8000, 11025, 12000, 16000, 22050, 24000, 32000,
%       44100, 48000. Default 11025.
%   
%   This function requires the Microsoft Win32 Speech API (SAPI).
%
%   Examples:
%       % Speak the text;
%       tts('I can speak.');
%       % List availble voices;
%       tts('I can speak.','List');
%       % Do not speak out, store the speech in a variable;
%       w = tts('I can speak.',[],-4,44100);
%       wavplay(w,44100);
%
%   See also wavread, wavwrite, wavplay.

if ~ispc, error('Microsoft Win32 SAPI is required.'); end
if ~ischar(txt), error('First input must be string.'); end

SV = actxserver('SAPI.SpVoice');
TK = invoke(SV,'GetVoices');

str = java_array('java.lang.String', 1);
if nargin > 1
    % Select voice;
    for k = 0:TK.Count-1
        if strcmpi(voice,TK.Item(k).GetDescription)
            SV.Voice = TK.Item(k);
            break;
        elseif strcmpi(voice,'list')
                str(k+1) = java.lang.String(TK.Item(k).GetDescription);
        end
    end
    str = cell(str);
    % Set pace;
    if nargin > 2
        if isempty(pace), pace = 0; end
        if abs(pace) > 10, pace = sign(pace)*10; end        
        SV.Rate = pace;
    end
end

if nargin < 4 || ~ismember(fs,[8000,11025,12000,16000,22050,24000,32000,...
        44100,48000]), fs = 11025; end

if nargout > 0
   % Output variable;
   MS = actxserver('SAPI.SpMemoryStream');
   MS.Format.Type = sprintf('SAFT%dkHz16BitMono',fix(fs/1000));
   SV.AudioOutputStream = MS;  
end

invoke(SV,'Speak',txt);

if nargout > 1
    % Convert uint8 to double precision;
    wav = reshape(double(invoke(MS,'GetData')),2,[])';
    wav = (wav(:,2)*256+wav(:,1))/32768;
    wav(wav >= 1) = wav(wav >= 1)-2;
    delete(MS);
    clear MS;
end

delete(SV); 
clear SV TK;
pause(0.2);


