path = "/media/wind/Data Disk/intan/CA_sleep_210822_102231/";
file = "CA_sleep_210822_102231.rhd";

channel_1 = [8, 18, 16, 6, 20, 19, 9, 5,...
    10, 24, 22, 11, 23, 7, 21, 17] + 1;
channel_2 = [4, 26, 12, 2, 28, 14, 3, 27,...
    13, 1, 34, 31, 30, 0, 29, 25] + 1;
channel_3 = [43, 35, 42, 45, 33, 40, 44, 37,...
    41 ,46, 39, 15, 32, 47, 36, 38] + 1;
channel_4 = [] + 1;

read_Intan_RHD2000_file(path, file);
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
