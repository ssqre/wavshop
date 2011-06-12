%--------文件数据-----------%
% 1.handles.wavfile.data1：音频数据
% 2.handles.wavfile.feq：声音频率
% 3.handles.wavfile.nbit：声音存储的bit数
%------标识数据--------------%
% 4.handles.flag.save:是否已保存
% 5.handles.flag.blank:是否装载有波形
% 6.handles.flag.opname:操作标识，=0表示没有操作，1标识Extract，2标识Trim
% 7.handles.flag.oplevel:缩放水平
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
