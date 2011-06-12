function fid=isdqrexist()
fid=fopen(fullfile(pwd,'data.dqr'), 'wb');
fclose(fid);