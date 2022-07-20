% Windowing

window_length = 100;
downsampling_ratio = 1;

take = 'Logs/0720/ATake1';
savename = ['_wl=' num2str(window_length) '_dsr=' num2str(downsampling_ratio) '.mat'];

reading_path = [take 'csi.mat'];
time_path = [take 'timediff.mat'];
csi_w_path = [take 'csi' savename];
time_w_path = [take 'timediff' savename];

% read csis
% read time_diff
load(reading_path);
load(time_path);

% save windowed_csis
% save windowed_time_diff

num_windows = floor(size(csis,3) / (window_length * downsampling_ratio));
windowed_csis = zeros(3, num_windows, window_length, 30);
windowed_time_diff = zeros(num_windows, window_length);

for i=1:3
    pos = 1;
    for j=1:num_windows
        for k=1:window_length
            windowed_csis(i,j,k,:)=squeeze(csis(i,30,pos));
            if i==1
                windowed_time_diff(j,k)=time_diff(pos);
            end
            pos = pos + downsampling_ratio;
        end
    end
end

save(csi_w_path, 'windowed_csis');
save(time_w_path, 'windowed_time_diff');