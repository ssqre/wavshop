%--------�ļ�����-----------%
% 1.handles.wavfile.data1����Ƶ����
% 2.handles.wavfile.feq������Ƶ��
% 3.handles.wavfile.nbit�������洢��bit��
%------��ʶ����--------------%
% 4.handles.flag.save:�Ƿ��ѱ���
% 5.handles.flag.blank:�Ƿ�װ���в���
% 6.handles.flag.opname:������ʶ��=0��ʾû�в�����1��ʶExtract��2��ʶTrim
% 7.handles.flag.oplevel:����ˮƽ
%------------------------------%
function datawrite(x1,x2,x3,x4,x5,x6,x7)
L=length(x1)+6;
data(L)=x7;
data(L-1)=x6;
data(L-2)=x5;
data(L-3)=x4;
data(L-4)=x3;
data(L-5)=x2;
data(1:L-6)=x1;
fid=fopen(fullfile(pwd,'data.dqr'),'a');
fwrite(fid,data,'double');
fclose(fid);