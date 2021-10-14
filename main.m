function main()
    src_dir = "/media/wind/Data Disk/FearCondition/intan/";
    tar_dir = "/media/wind/Data Disk/FearCondition/databin/";
    file_list = ["HA_210819_091933", "HB_210819_160638", "HA_sleep_210819_101454", "CA_sleep_210822_102231", "TA_210823_083732"];
%     convert(src_dir, file_list, tar_dir);
    
    concate(tar_dir, file_list);
 
%     sort(tar_dir);
end

% Convert rhd file into bin file
function convert(src_dir, file_list, target_dir)
    % Split Channels
    % Three probes
    channel_1 = [10, 8, 24, 18, 22, 16, 11, 6, 23, 20, 7, 19, 21, 9, 17, 5] + 1;
    channel_2 = [13, 4, 1, 26, 34, 12, 31, 2, 30, 28, 0, 14, 19, 3, 25, 27] + 1;
%   channel_3 = [41, 43, 46, 35, 39, 42, 15, 45, 32, 33, 47, 40, 36, 44, 38, 37] + 1;
%   channel_4 = [] + 1;
    
    for file_name = file_list
        disp(file_name);
        amplifier_data = read_Intan_RHD2000_file(src_dir, file_name + "/" + file_name + ".rhd", 0, 17400);
        amplifier_data = int16(amplifier_data);
        size(amplifier_data)
    
        fid = fopen(target_dir + file_name + "_1.bin", 'w');
        fwrite(fid, amplifier_data(channel_1, :), 'int16');
        fclose(fid);
        
        fid = fopen(target_dir + file_name + "_2.bin", 'w');
        fwrite(fid, amplifier_data(channel_2, :), 'int16');
        fclose(fid);
    end
end

% Concate files
function concate(file_dir, file_list)
    info = containers.Map;
    for surfix=["_1.bin", "_2.bin"]
        all_data = [];
        for file_name = file_list
            disp(file_name + surfix);
            fid = fopen(file_dir + file_name + surfix, 'r');
            data = fread(fid, '*int16');
            fclose(fid);
            
            info(file_name) = length(data);
            all_data = [all_data; data];
        end

        
%         fid = fopen(file_dir + "data" + surfix, 'w');
%         fwrite(fid, all_data, 'int16');
%         fclose(fid);
        save(fullfile(file_dir, 'datainfo.mat'), 'info');

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