% Time difference to check timing perturbation

raw_path = 'dataset/csi0602Btake3.dat';
time_path = 'Logs/0624/ATake1time.mat';


% load(time_path);
% 
% times1 = times(2:end);
% times_diff = times1 - times(1:end-1);
% times_max = max(times_diff);
% times_min = min(times_diff);
% 
% times_diff = times_diff ./ times_max;
% 
% figure();
% x = linspace(1,length(times_diff),length(times_diff));
% scatter(x,times_diff,'red','x');  
% title('Timestamping Perturbation');
% xlabel('Timestamp');
% ylabel('Relative Perturbation');

[a,b,c,d,e] = get_timeinfo(raw_path);


function [a,b,c,d,e] = get_timeinfo(input)
    csi = read_bf_file(input);
    timebuffer = zeros(1, length(csi));
    for i=1:length(csi())
        timebuffer(i)=csi{i}.timestamp_low;
    end

    timebuffer1 = timebuffer(2:end);
    timebuffer_diff = timebuffer1 - timebuffer(1:end-1);
    d = max(timebuffer_diff);
    e = min(timebuffer_diff);
    
    a = timebuffer(end)-timebuffer(1);
    b = length(timebuffer);
    c = a/b;

end


