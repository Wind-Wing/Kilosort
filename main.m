function main()
    raw_dir = "/media/wind/Data Disk/FearCondition/intan/";
    data_dir = "/media/wind/Data Disk/FearCondition/databin/";
    res_dir = "/media/wind/Data Disk/FearCondition/consolidation/";
    file_list = ["HA_210819_091933", "HA_sleep_210819_101454", "HB_210819_160638", "HB_sleep_210819_164817", "CA_sleep_210822_102231", "TA_210823_083732", "TB_210823_144602"]; % Full
%     file_list = ["HA_210819_091933", "HA_sleep_210819_101454", "HB_210819_160638", "CA_sleep_210822_102231", "TA_210823_083732", "TB_210823_144602"];   % Stimulusion
%     file_list = ["HA_210819_091933", "HA_sleep_210819_101454", "HB_210819_160638", "HB_sleep_210819_164817", "TA_210823_083732", "TB_210823_144602"];   % Consolidation
    convert(raw_dir, file_list, data_dir);

    concate(data_dir, res_dir, file_list);
 
    sort(res_dir);
end

% Convert rhd file into bin file
function convert(src_dir, file_list, target_dir)
    % Split Channels
    % Three probes
    channel_1 = [10, 8, 24, 18, 22, 16, 11, 6, 23, 20, 7, 19, 21, 9, 17, 5] + 1;
    channel_2 = [13, 4, 1, 26, 34, 12, 31, 2, 30, 28, 0, 14, 19, 3, 25, 27] + 1;
%   channel_3 = [41, 43, 46, 35, 39, 42, 15, 45, 32, 33, 47, 40, 36, 44, 38, 37] + 1;
%   channel_4 = [] + 1;
    
    num_sample = [];
    dig_signal = [];
    for file_name = file_list
        disp(file_name);
        [amplifier_data, board_dig_in_data] = read_Intan_RHD2000_file(src_dir, file_name + "/" + file_name + ".rhd", 0, 0);
        amplifier_data = int16(amplifier_data);
    
        fid = fopen(target_dir + file_name + "_1.bin", 'w');
        fwrite(fid, amplifier_data(channel_1, :), 'int16');
        fclose(fid);

        fid = fopen(target_dir + file_name + "_2.bin", 'w');
        fwrite(fid, amplifier_data(channel_2, :), 'int16');
        fclose(fid); 
        
        if contains(file_name, "sleep")
            dig_signal = [dig_signal find(board_dig_in_data == 1, 1, 'last')];
        else
            dig_signal = [dig_signal -1];
        end
        num_sample = [num_sample length(amplifier_data)];
    end
    save(fullfile(target_dir, "datainfo.mat"), "file_list", "num_sample", "dig_signal");
end

% Concate files
function concate(src_dir, tar_dir, file_list)
    for surfix=["_1.bin", "_2.bin"]
        all_data = [];    
        for file_name = file_list
            disp(file_name + surfix);
            fid = fopen(src_dir + file_name + surfix, 'r');
            data = fread(fid, '*int16');
            fclose(fid);
            
            all_data = [all_data; data];
        end

        fid = fopen(tar_dir + "data" + surfix, 'w');
        fwrite(fid, all_data, 'int16');
        fclose(fid);
    end
end

% Spike sorting
function sort(file_dir)
    % Load config
    run("./config.m")   
    % Sorting Channels
    for idx=["1", "2"]
        ops.output_surfix = idx;
        ops.fbinary = file_dir;
        run_kilosort30(ops);
    end
end
