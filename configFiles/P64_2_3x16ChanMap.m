function P64_2_3x16ChanMap(fpath)
% Makes channel map for LianHuaXing P64-2 16x4.
% Mapping is made for ordered channels.


name = 'P64_2_3x16';

chanMap0ind = [8, 18, 16, 6, 20, 19, 9, 5,...
    10, 24, 22, 11, 23, 7, 21, 17,...
    4, 26, 12, 2, 28, 14, 3, 27,...
    13, 1, 34, 31, 30, 0, 29, 25,...
    43, 35, 42, 45, 33, 40, 44, 37,...
    41 ,46, 39, 15, 32, 47, 36, 38];
chanMap0ind = chanMap0ind';
chanMap = chanMap0ind+1;

connected = true(48, 1);

xcoords = [ones(8, 1)*0; ones(8, 1)*24;...
    ones(8, 1)*0+250; ones(8, 1)*24+250;...
    ones(8, 1)*0+500; ones(8, 1)*24+500];

ycoords = [(1:8)*-25 (1:8)*-25+13 ...
    (1:8)*-25 (1:8)*-25+13 ...
    (1:8)*-25 (1:8)*-25+13];
ycoords = ycoords';

kcoords = [ones(16,1); ones(16, 1)*2; ones(16,1)*3];

fs = 20000;

% Saving
save(fullfile(fpath, 'P64_2_3x16ChanMap.mat'), 'name', 'chanMap', 'connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')

