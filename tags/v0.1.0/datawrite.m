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