function main()
    path_0 = "/media/wind/Data Disk/intan/HA_210819_091933/";
    file_0 = "all.rhd";
    split(path_0, file_0);

    path_1 = "/media/wind/Data Disk/intan/HB_210819_160638/";
    file_1 = "HB_210819_160638.rhd";
    split(path_1, file_1);
    
    concate(path_0, path_1);
    
    sort(path_0);
end


% Split files
function split(path, file)
    % Split Channels
    % Three probes
    channel_1 = [10, 8, 24, 18, 22, 16, 11, 6, 23, 20, 7, 19, 21, 9, 17, 5] + 1;
    channel_2 = [13, 4, 1, 26, 34, 12, 31, 2, 30, 28, 0, 14, 19, 3, 25, 27] + 1;
%   channel_3 = [41, 43, 46, 35, 39, 42, 15, 45, 32, 33, 47, 40, 36, 44, 38, 37] + 1;
%   channel_4 = [] + 1;

    amplifier_data = read_Intan_RHD2000_file(path, file, 0, 0);
    amplifier_data = int16(amplifier_data);
    size(amplifier_data)

    mkdir(path + "1/");
    fid = fopen(path + "1/data.bin", 'w');
    fwrite(fid, amplifier_data(channel_1, :), 'int16');
    fclose(fid);

    mkdir(path + "2/");
    fid = fopen(path + "2/data.bin", 'w');
    fwrite(fid, amplifier_data(channel_2, :), 'int16');
    fclose(fid);

%   mkdir(path + "sorting/3/");
%   fid = fopen(path + "sorting/3/data.bin", 'w');
%   fwrite(fid, amplifier_data(channel_3, :), 'int16');
%   fclose(fid);
%         
%   mkdir(path + "sorting/all/");
%   fid = fopen(path + "sorting/all/data.bin", 'w');
%   fwrite(fid, amplifier_data([channel_1 channel_2 channel_3], :), 'int16');
%   fclose(fid);
end


% Concate files
function concate(path_0, path_1)
    for i=['1', '2']
        file_0 = path_0 + i + "/data.bin";
        file_1 = path_1 + i + "/data.bin";
    
        fid = fopen(file_0, 'r');
        data_0 = fread(fid, '*int16');
        fclose(fid);
    
        fid = fopen(file_1, 'r');
        data_1 = fread(fid, '*int16');
        fclose(fid);
        
        data = [data_0; data_1];
        mkdir(path_0 + "concate_" + i + "/");
        fid = fopen(path_0 + "concate_" + i + "/data.bin", 'w');
        fwrite(fid, data, 'int16');
        fclose(fid);
    end
end

    
function sort(path_0)
    % Load config
    run("./config.m")   
    % Sorting Channels
    for i=['1', '2']
        ops.fbinary = path_0 + "concate_" + i + "/";
        run_kilosort30(ops);
    end
end