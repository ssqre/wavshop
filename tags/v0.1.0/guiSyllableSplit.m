function varargout = guiSyllableSplit(varargin)
% GUISYLLABLESPLIT M-file for guiSyllableSplit.fig
%      GUISYLLABLESPLIT, by itself, creates a new GUISYLLABLESPLIT or raises the existing
%      singleton*.
%
%      H = GUISYLLABLESPLIT returns the handle to a new GUISYLLABLESPLIT or the handle to
%      the existing singleton*.
%
%      GUISYLLABLESPLIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISYLLABLESPLIT.M with the given input arguments.
%
%      GUISYLLABLESPLIT('Property','Value',...) creates a new GUISYLLABLESPLIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiSyllableSplit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiSyllableSplit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiSyllableSplit

% Last Modified by GUIDE v2.5 14-Oct-2010 21:34:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiSyllableSplit_OpeningFcn, ...
                   'gui_OutputFcn',  @guiSyllableSplit_OutputFcn, ...
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


% --- Executes just before guiSyllableSplit is made visible.
function guiSyllableSplit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiSyllableSplit (see VARARGIN)

% Choose default command line output for guiSyllableSplit
handles.output = hObject;

handles.wavfile.data=varargin{1};
handles.wavfile.feq=varargin{2};
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiSyllableSplit wait for user response (see UIRESUME)
% uiwait(handles.guiSyllableSplit);


% --- Outputs from this function are returned to the command line.
function varargout = guiSyllableSplit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtSuperE_Callback(hObject, eventdata, handles)
% hObject    handle to txtSuperE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSuperE as text
%        str2double(get(hObject,'String')) returns contents of txtSuperE as a double


% --- Executes during object creation, after setting all properties.
function txtSuperE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSuperE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSuperZCR_Callback(hObject, eventdata, handles)
% hObject    handle to txtSuperZCR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSuperZCR as text
%        str2double(get(hObject,'String')) returns contents of txtSuperZCR as a double


% --- Executes during object creation, after setting all properties.
function txtSuperZCR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSuperZCR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDTASaveSlices.
function btnDTASaveSlices_Callback(hObject, eventdata, handles)
% hObject    handle to btnDTASaveSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=handles.wavfile.data;
fs=handles.wavfile.feq;
G1=str2double(get(handles.txtSuperE,'String'));
G2=str2double(get(handles.txtSuperZCR,'String'));
G3=str2double(get(handles.txtSubE,'String'));
G4=str2double(get(handles.txtSubZCR,'String'));

x=[x;zeros(round(0.5*fs),1)];%�ڶ�ȡ������ĩβ����һ�뾲��
t=linspace(0,(length(x)-1)/fs,length(x));%��ʱ��(length(x)-1)/fs�ڲ���length(x)����
x=x/max(abs(x));%���������ι�һ������

%x=filter([2,-0.96],1,x);%Ԥ�����˲�
%-----------------�����߽���------------------------------%
%-----------------������������--------------------%
lengthframe=round(0.1*fs);%�趨֡��Ϊ0.1�룬����ò����ή���������ֶȣ���Ӧ����ʱ�������
transframe=round(0.02*fs);%�趨֡��Ϊ0.02��,����ò����ή���������ֶȣ���Ӧ����ʱ������
x1=enframe(x(1:end-1),lengthframe,transframe);%��֡,����enframe����voicebox������
x2=enframe(x(2:end),lengthframe,transframe);
x1_=x1;
x1_(abs(x1_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
x2_=x2;
x2_(abs(x2_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
E1=sum(abs(x1_),2);%��ÿ֡������E1��E2�������
E2=sum(abs(x2_),2);
E=(E1+E2)/2;
E=E/max(abs(E));

signs=(x1.*x2)<0;%��ÿ֡�����ʴ���ZCR
diffs=abs(x1-x2)>0.005;
ZCR=sum(signs.*diffs,2);
ZCR=ZCR/max(abs(ZCR));

[startpoint,endpoint]=segDTA(E,ZCR,G1,G2,G3,G4);
%------------------�洢-------------------------------%
for i=1:length(startpoint)
    sp(i)=round((2*startpoint(i)*(transframe-1)+lengthframe)/2);
    ep(i)=round((2*endpoint(i)*(transframe-1)+lengthframe)/2);
end
pathname=strcat(pwd,'\SplitedSyllableUingDTA\');
mkdir(pathname);
cd(pathname);
for k=1:length(sp)
    filename=strcat(pathname,num2str(k));
    wavwrite(handles.wavfile.data(sp(k):ep(k)),fs,filename);
end
cd('..');
function txtSubE_Callback(hObject, eventdata, handles)
% hObject    handle to txtSubE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSubE as text
%        str2double(get(hObject,'String')) returns contents of txtSubE as a double


% --- Executes during object creation, after setting all properties.
function txtSubE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSubE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSubZCR_Callback(hObject, eventdata, handles)
% hObject    handle to text100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text100 as text
%        str2double(get(hObject,'String')) returns contents of text100 as a double


function txtSuperT_Callback(hObject, eventdata, handles)
% hObject    handle to txtSuperT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSuperT as text
%        str2double(get(hObject,'String')) returns contents of txtSuperT as a double


% --- Executes during object creation, after setting all properties.
function txtSuperT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSuperT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSubT_Callback(hObject, eventdata, handles)
% hObject    handle to txtSubT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSubT as text
%        str2double(get(hObject,'String')) returns contents of txtSubT as a double


% --- Executes during object creation, after setting all properties.
function txtSubT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSubT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSTADrawSlices.
function btnSTADrawSlices_Callback(hObject, eventdata, handles)
% hObject    handle to btnSTADrawSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=handles.wavfile.data;
fs=handles.wavfile.feq;
choice=get(handles.popSTA,'Value');
G1=str2double(get(handles.txtSuperT,'String'));
G2=str2double(get(handles.txtSubT,'String'));

x=[x;zeros(round(0.5*fs),1)];%�ڶ�ȡ������ĩβ����һ�뾲��
t=linspace(0,(length(x)-1)/fs,length(x));%��ʱ��(length(x)-1)/fs�ڲ���length(x)����
x=x/max(abs(x));%���������ι�һ������

%x=filter([2,-0.96],1,x);%Ԥ�����˲�
%-----------------�����߽���------------------------------%
%-----------------������������--------------------%
lengthframe=round(0.1*fs);%�趨֡��Ϊ0.1�룬����ò����ή���������ֶȣ���Ӧ����ʱ�������
transframe=round(0.02*fs);%�趨֡��Ϊ0.02��,����ò����ή���������ֶȣ���Ӧ����ʱ������
x1=enframe(x(1:end-1),lengthframe,transframe);%��֡,����enframe����voicebox������
x2=enframe(x(2:end),lengthframe,transframe);
x1_=x1;
x1_(abs(x1_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
x2_=x2;
x2_(abs(x2_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
E1=sum(abs(x1_),2);%��ÿ֡������E1��E2�������
E2=sum(abs(x2_),2);
E=(E1+E2)/2;
E=E/max(abs(E));

signs=(x1.*x2)<0;%��ÿ֡�����ʴ���ZCR
diffs=abs(x1-x2)>0.005;
ZCR=sum(signs.*diffs,2);
ZCR=ZCR/max(abs(ZCR));

EZCR=E.*ZCR;%�ۺϲ���EZCR
EZCR=EZCR/max(abs(EZCR));
MEZCR=EZCR.^0.1;%��0--1����⻯

%-----------------������������--------------------%
[startpoint,endpoint]=segSTA(E,ZCR,EZCR,choice,G1,G2);%����seg����
%-----------------�����߽���------------------------------%
%---------------------��ͼ----------------------%
figure;
set(gcf,'Name','Figure of Splitted Syllable Using STA');
subplot(5,1,1),hold on,plot(t,x),xlabel('t/s'),ylabel('speech magnitude');
subplot(5,1,2),grid,hold on,plot(E),xlabel('frame'),ylabel('E');
subplot(5,1,3),grid,hold on,plot(ZCR),xlabel('frame'),ylabel('ZCR');
subplot(5,1,4),grid,hold on,plot(EZCR),xlabel('frame'),ylabel('EZCR');
subplot(5,1,5),grid,hold on,plot(MEZCR),xlabel('frame'),ylabel('MEZCR');
subplot(5,1,1);
for i=1:length(startpoint)
    sp(i)=round((2*startpoint(i)*(transframe-1)+lengthframe)/2)/fs;
    ep(i)=round((2*endpoint(i)*(transframe-1)+lengthframe)/2)/fs;
    line([sp(i),sp(i)],ylim,'color',[1,0,0]);
    line([ep(i),ep(i)],ylim,'color',[0,1,0]);
end
switch choice  
    case 1
        subplot(5,1,2);
        for i=1:length(startpoint)
            line([startpoint(i),startpoint(i)],ylim,'color',[1,0,0]);
            line([endpoint(i),endpoint(i)],ylim,'color',[0,1,0]);
        end
    case 2
        subplot(5,1,3);
        for i=1:length(startpoint)
            line([startpoint(i),startpoint(i)],ylim,'color',[1,0,0]);
            line([endpoint(i),endpoint(i)],ylim,'color',[0,1,0]);
        end
    case 3
        subplot(5,1,4);
        for i=1:length(startpoint)
            line([startpoint(i),startpoint(i)],ylim,'color',[1,0,0]);
            line([endpoint(i),endpoint(i)],ylim,'color',[0,1,0]);
        end
    otherwise
        subplot(5,1,5);
        for i=1:length(startpoint)
            line([startpoint(i),startpoint(i)],ylim,'color',[1,0,0]);
            line([endpoint(i),endpoint(i)],ylim,'color',[0,1,0]);
        end
end

% --- Executes on button press in btnDTADrawSlices.
function btnDTADrawSlices_Callback(hObject, eventdata, handles)
% hObject    handle to btnDTADrawSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=handles.wavfile.data;
fs=handles.wavfile.feq;
G1=str2double(get(handles.txtSuperE,'String'));
G2=str2double(get(handles.txtSuperZCR,'String'));
G3=str2double(get(handles.txtSubE,'String'));
G4=str2double(get(handles.txtSubZCR,'String'));

x=[x;zeros(round(0.5*fs),1)];%�ڶ�ȡ������ĩβ����һ�뾲��
t=linspace(0,(length(x)-1)/fs,length(x));%��ʱ��(length(x)-1)/fs�ڲ���length(x)����
x=x/max(abs(x));%���������ι�һ������

%x=filter([2,-0.96],1,x);%Ԥ�����˲�
%-----------------�����߽���------------------------------%
%-----------------������������--------------------%
lengthframe=round(0.1*fs);%�趨֡��Ϊ0.1�룬����ò����ή���������ֶȣ���Ӧ����ʱ�������
transframe=round(0.02*fs);%�趨֡��Ϊ0.02��,����ò����ή���������ֶȣ���Ӧ����ʱ������
x1=enframe(x(1:end-1),lengthframe,transframe);%��֡,����enframe����voicebox������
x2=enframe(x(2:end),lengthframe,transframe);
x1_=x1;
x1_(abs(x1_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
x2_=x2;
x2_(abs(x2_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
E1=sum(abs(x1_),2);%��ÿ֡������E1��E2�������
E2=sum(abs(x2_),2);
E=(E1+E2)/2;
E=E/max(abs(E));

signs=(x1.*x2)<0;%��ÿ֡�����ʴ���ZCR
diffs=abs(x1-x2)>0.005;
ZCR=sum(signs.*diffs,2);
ZCR=ZCR/max(abs(ZCR));

[startpoint,endpoint]=segDTA(E,ZCR,G1,G2,G3,G4);
%-------------��ͼ---------------%
figure;
set(gcf,'Name','Figure of Splitted Syllable Using DTA');
subplot(3,1,1),hold on,plot(t,x);
for i=1:length(startpoint)
    sp(i)=round((2*startpoint(i)*(transframe-1)+lengthframe)/2)/fs;
    ep(i)=round((2*endpoint(i)*(transframe-1)+lengthframe)/2)/fs;
    line([sp(i),sp(i)],ylim,'color',[1,0,0]);
    line([ep(i),ep(i)],ylim,'color',[1,0,0]);
end
subplot(3,1,2),hold on,plot(E);
for i=1:length(startpoint)
    line([startpoint(i),startpoint(i)],ylim,'color',[1,0,0]);
    line([endpoint(i),endpoint(i)],ylim,'color',[1,0,0]);
end
subplot(3,1,3),hold on,plot(ZCR);
for i=1:length(startpoint)
    line([startpoint(i),startpoint(i)],ylim,'color',[1,0,0]);
    line([endpoint(i),endpoint(i)],ylim,'color',[1,0,0]);
end



% --- Executes on button press in btnSTASaveSlices.
function btnSTASaveSlices_Callback(hObject, eventdata, handles)
% hObject    handle to btnSTASaveSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=handles.wavfile.data;
fs=handles.wavfile.feq;
choice=get(handles.popSTA,'Value');
G1=str2double(get(handles.txtSuperT,'String'));
G2=str2double(get(handles.txtSubT,'String'));

x=[x;zeros(round(0.5*fs),1)];%�ڶ�ȡ������ĩβ����һ�뾲��
t=linspace(0,(length(x)-1)/fs,length(x));%��ʱ��(length(x)-1)/fs�ڲ���length(x)����
x=x/max(abs(x));%���������ι�һ������

%x=filter([2,-0.96],1,x);%Ԥ�����˲�
%-----------------�����߽���------------------------------%
%-----------------������������--------------------%
lengthframe=round(0.1*fs);%�趨֡��Ϊ0.1�룬����ò����ή���������ֶȣ���Ӧ����ʱ�������
transframe=round(0.02*fs);%�趨֡��Ϊ0.02��,����ò����ή���������ֶȣ���Ӧ����ʱ������
x1=enframe(x(1:end-1),lengthframe,transframe);%��֡,����enframe����voicebox������
x2=enframe(x(2:end),lengthframe,transframe);
x1_=x1;
x1_(abs(x1_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
x2_=x2;
x2_(abs(x2_)<0.05)=0;%����һ���ޣ���ȥ�����ڶε���������߸����޿�������������ֶȣ������ܺ��Ե�С�������� 
E1=sum(abs(x1_),2);%��ÿ֡������E1��E2�������
E2=sum(abs(x2_),2);
E=(E1+E2)/2;
E=E/max(abs(E));

signs=(x1.*x2)<0;%��ÿ֡�����ʴ���ZCR
diffs=abs(x1-x2)>0.005;
ZCR=sum(signs.*diffs,2);
ZCR=ZCR/max(abs(ZCR));

EZCR=E.*ZCR;%�ۺϲ���EZCR
EZCR=EZCR/max(abs(EZCR));
% MEZCR=EZCR.^0.1;%��0--1����⻯

%-----------------������������--------------------%
[startpoint,endpoint]=segSTA(E,ZCR,EZCR,choice,G1,G2);%����seg����
%-----------------�����߽���------------------------------%
%------------------�洢-------------------------------%
for i=1:length(startpoint)
    sp(i)=round((2*startpoint(i)*(transframe-1)+lengthframe)/2);
    ep(i)=round((2*endpoint(i)*(transframe-1)+lengthframe)/2);
end
pathname=strcat(pwd,'\SplitedSyllableUingSTA\');
mkdir(pathname);
cd(pathname);
for k=1:length(sp)
    filename=strcat(pathname,num2str(k));
    wavwrite(handles.wavfile.data(sp(k):ep(k)),fs,filename);
end
cd('..');
% --- Executes on selection change in popSTA.
function popSTA_Callback(hObject, eventdata, handles)
% hObject    handle to popSTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popSTA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popSTA
handles.choice=get(handles.popSTA,'Value');
% switch val
%     case 1
%         handles.choice=1;
%     case 2
%         handles.choice=2;
%     case 3
%         handles.choice=3;
%     otherwise
%         handles.choice=4;
% end
guidata(hObject, handles);
     
% --- Executes during object creation, after setting all properties.
function popSTA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popSTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [startpoint,endpoint]=segSTA(E,ZCR,EZCR,choice,G1,G2)%�����޷�
switch choice
    case 1
        Ref=E;
    case 2
        Ref=ZCR;
    case 3
        Ref=EZCR;
    otherwise
        Ref=EZCR;
        Ref=Ref.^0.1;
end
startflag=0;endflag=1;%startflagΪ��ʼ���ҵ���ʶ��endflagΪ�������ҵ���ʶ
j=1;
for i=1:length(EZCR)
    if Ref(i)>G1&&startflag==0&&endflag==1
        startpoint(j)=i;%�����ۺϲ���EZCRȷ��������ʼ��
        startflag=1;
        endflag=0;
    end
    if Ref(i)<G2&&startflag==1&&endflag==0
        endpoint(j)=i-1;%�����ۺϲ���EZCRȷ��������ֹ��
        startflag=0;
        endflag=1;
        j=j+1;
    end
end   


% --- Executes during object creation, after setting all properties.
function txtSubZCR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSubZCR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function [startpoint,endpoint]=segDTA(E,ZCR,G1,G2,G3,G4)%˫���޷�
startflag=0;endflag=1;%startflagΪ��ʼ���ҵ���ʶ��endflagΪ�������ҵ���ʶ
j=1;
for i=1:length(E)
    if E(i)>G1&&startflag==0&&endflag==1
        startpoint(j)=i;%�������õ���������ʼ��
%         if ZCR(i)>G2
%             for ii=i:-1:1
%                 if ZCR(ii)<G2
%                     startpoint(j)=ii;%��ZCR����������ʼ��
%                     break;
%                 end
%             end
%         end
        startflag=1;
        endflag=0;
    end
    if E(i)<G3&&startflag==1&&endflag==0
        endpoint(j)=i;%�������õ������ڽ�����
%         if ZCR(i)>G4
%             for ii=i:length(E)
%                 if ZCR(ii)<G4
%                     endpoint(j)=ii;%��ZCR����������ʼ��
%                     break;
%                 end
%             end
%         end
        startflag=0;
        endflag=1;
        j=j+1;
    end
end