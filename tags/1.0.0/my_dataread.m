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
function [y1,y2,y3,y4,y5,y6,y7]=my_dataread(oplevel,opL)
% L=opL(end-(length(opL)+1-oplevel):end);
% LL=(sum(L)+length(L)*6)*8;
fid=fopen(fullfile(pwd,'data.dqr'), 'rb');
L=opL(oplevel-1);
LL=(L+6)*8;
fseek(fid,-LL,'eof');
y1=fread(fid,L,'double');
y2=fread(fid,1,'double');
y3=fread(fid,1,'double');
y4=fread(fid,1,'double');
y5=fread(fid,1,'double');
y6=fread(fid,1,'double');
y7=fread(fid,1,'double');
fclose(fid);
