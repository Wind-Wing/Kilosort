%% Set Constants
path = "/media/wind/Data Disk/intan/CA_sleep_210822_102231/";
file = "CA_sleep_210822_102231.rhd";

%% Split Channels
Three probes
channel_1 = [10, 8, 24, 18, 22, 16, 11, 6, 23, 20, 7, 19, 21, 9, 17, 5] + 1;
channel_2 = [13, 4, 1, 26, 34, 12, 31, 2, 30, 28, 0, 14, 19, 3, 25, 27] + 1;
channel_3 = [41, 43, 46, 35, 39, 42, 15, 45, 32, 33, 47, 40, 36, 44, 38, 37] + 1;
channel_4 = [] + 1;

read_Intan_RHD2000_file(path, file, 7200);
amplifier_data = int16(amplifier_data);

mkdir(path + "sorting/1/");
fid = fopen(path + "sorting/1/data.bin", 'w');
fwrite(fid, amplifier_data(channel_1, :), 'int16');
fclose(fid);

mkdir(path + "sorting/2/");
fid = fopen(path + "sorting/2/data.bin", 'w');
fwrite(fid, amplifier_data(channel_2, :), 'int16');
fclose(fid);

mkdir(path + "sorting/3/");
fid = fopen(path + "sorting/3/data.bin", 'w');
fwrite(fid, amplifier_data(channel_3, :), 'int16');
fclose(fid);

%% Sorting Spikes
run("./config.m")

for i=['1','2','3']
    ops.fbinary = path + "sorting/" + i + "/";
    ops.root = ops.root;
    run_kilosort(ops);
end
