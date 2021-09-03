function P64_2_16x3ChanMap(fpath)
% Makes channel map for LianHuaXing P64-2 16x4.
% Mapping is made for ordered channels.


name = 'P64_2_16x3';

chanMap = (1:48)';
chanMap0ind = chanMap - 1;

connected = true(48, 1);

xcoords = reshape(repmat([24 0], [1, 8]), [16, 1]);
xcoords = [xcoords; xcoords + 250; xcoords + 500];

ycoords = reshape([(0:7)*25; (0:7)*25+13], [16, 1]);
ycoords = repmat(ycoords, [3, 1]);
ycoords = ycoords * -1;

kcoords = [ones(16,1); ones(16,1)*2; ones(16,1)*3];

fs = 20000;

% Saving
save(fullfile(fpath, 'P64_2_16x3ChanMap.mat'), 'name', 'chanMap', 'connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')

