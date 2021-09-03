function P64_2_16ChanMap(fpath)
% Makes channel map for LianHuaXing P64-2 16x4.
% Mapping is made for ordered channels.


name = 'P64_2_16';

chanMap = (1:16)';
chanMap0ind = chanMap - 1;

connected = true(16, 1);

%xcoords = [ones(8, 1)*0; ones(8, 1)*24];
xcoords = reshape(repmat([24 0], [1, 8]), [16, 1]);

%ycoords = [(1:8)*-25 (1:8)*-25+13];
%ycoords = ycoords';
ycoords = reshape([(0:7)*25; (0:7)*25+13], [16, 1]);
ycoords = ycoords * -1;

kcoords = ones(16,1);

fs = 20000;

% Saving
save(fullfile(fpath, 'P64_2_16ChanMap.mat'), 'name', 'chanMap', 'connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')

