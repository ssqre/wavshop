function fid=my_isdqrexist()
fid=fopen(fullfile(pwd,'data.dqr'), 'wb');
fclose(fid);