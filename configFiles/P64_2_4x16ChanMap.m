function P64_2_4x16ChanMap(fpath)
% Makes channel map for LianHuaXing P64-2 16x4.
% Mapping is made for ordered channels.


name = 'P64_2_4x16';

chanMap0ind = [8, 18, 16, 6, 20, 19, 9, 5,...
    10, 24, 22, 11, 23, 7, 21, 17,...
    4, 26, 12, 2, 28, 14, 3, 27,...
    13, 1, 34, 31, 30, 0, 29, 25,...
    59, 35, 51, 61, 33, 49, 60, 38,...
    50 ,62, 48, 15, 32, 63, 36, 40,...
    55, 43, 45, 57, 41, 46, 54, 58,...
    53, 37, 39, 52, 42, 56, 44, 47];
chanMap0ind = chanMap0ind';
chanMap = chanMap0ind + 1;

bad_channels = (49:64);
connected = true(64, 1);
connected(bad_channels) = 0;


xcoords = [ones(8, 1)*0; ones(8, 1)*24;...
    ones(8, 1)*0+250; ones(8, 1)*24+250;...
    ones(8, 1)*0+500; ones(8, 1)*24+500;...
    ones(8, 1)*0+750; ones(8, 1)*24+750];
xcoords(bad_channels) = NaN;

ycoords = [(1:8)*-25 (1:8)*-25+13 ...
    (1:8)*-25 (1:8)*-25+13 ...
    (1:8)*-25 (1:8)*-25+13 ...
    (1:8)*-25 (1:8)*-25+13];
ycoords = ycoords';
ycoords(bad_channels) = NaN;

kcoords = [ones(16,1); ones(16, 1)*2; ones(16,1)*3; ones(16,1)*4];
kcoords(bad_channels) = NaN;

fs = 20000;

% Saving
save(fullfile(fpath, 'P64_2_4x16ChanMap.mat'), 'name', 'chanMap', 'connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')

