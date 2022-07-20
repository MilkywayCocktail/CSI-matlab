% Doppler
% Data shape = #Antenna x #Window x Length x 30

center_freq = 5.68 * 1e9;
lightspeed = 299792458;
vspace = linspace(-4.9,5,100);

read_w_path = 'Logs/0720/ATake1csi_wl=100_dsr=1.mat';
time_w_path = 'Logs/0720/ATake1timediff_wl=100_dsr=1.mat';


load(read_w_path);
load(time_w_path);

windowed_time_diff = windowed_time_diff / 1e6;
 
Ps = zeros(size(windowed_time_diff,1),100);

for i=1:size(Ps,1)
    Ps(i,:) = windowed_doppler(squeeze(windowed_csis(:,i,:,:)),squeeze(windowed_time_diff(i,:)), ...
        center_freq, lightspeed, vspace);
end

Pabsmax = max(max(abs(Ps)));
Ps = Ps ./ Pabsmax;
[Pm, IPm] = max(abs(Ps'),[],1);

Ps = 10*log10(abs(Ps));
vmap = zeros(1,size(Ps,1));
for i=1:size(Ps,1)
    vmap(i)=vspace(IPm(i));
end

clip = Ps;

figure();
surf(clip','EdgeColor','None');
view(2);  
clb = colorbar;
clb.Label.String = ('Power(dB)');
yticklabels(-5:1:5);
axis tight;
title('Doppler Spectrogram with Antenna12');
xlabel('#window');
ylabel('speed(m/s)');

figure();
plot(vmap);
title('Doppler Peaks with Antenna23');
xlabel('#window');
ylabel('speed(m/s)');


function p = windowed_doppler(window, time, center_freq, lightspeed, vspace)
%   conj_window shape = 200x30
%   alist shape = 200x1
%   vspace shape = 1xResolution(min,max,interval)
%   amat shape = 200xResolution

    antenna1 = 1;
    antenna2 = 2;
    
    alpha = max(max(abs(window(antenna1,:,:))));
    beta = 1000 * alpha;


%     window(1,:,:) = abs(window(1,:,:) / alpha ) .* exp(1i * angle(window(1,:,:)));
%     window(2,:,:) = abs(window(2,:,:)) .* (beta ^ 2) * exp(1j * angle(window(2,:,:)));
% 
%     conj_window = window(1,:,:) .* conj(window(2,:,:));

    window(antenna1,:,:) = abs(window(antenna1,:,:)) * exp(1i) - alpha;
    window(antenna2,:,:) = abs(window(antenna2,:,:)) .* exp(1i * angle(window(antenna2,:,:))) + beta ^ 2;

    conj_window = squeeze(window(antenna1,:,:) .* conj(window(antenna2,:,:)));
    static_component =mean(conj_window, 1);
    mobile_component = conj_window - repmat(static_component,100,1);

    Rxx = mobile_component * mobile_component';
    [EV,D] = eig(Rxx);

    EVA = diag(D)';
    [EVA,I] = sort(EVA,'descend');
    EV = fliplr(EV(:,I));

    EN = EV(:,2:end);

    deltaphi = time' * vspace * 2* pi *center_freq / lightspeed;

    %alist = exp(-1i * 2* pi * time * center_freq / lightspeed).';
    
    amat = exp(-1i * deltaphi);

    p = sum((amat') * EN * (EN') * amat, 2);

%     anglep = angle(p);
%     for j=1:length(p)
%         if (-pi/2<=anglep(j))&&(anglep(j)<=pi/2)
%             p(j)=1./abs(p(j));
%         else
%             p(j)=-1./abs(p(j));
%         end
%     end
    
    p = 1 ./ abs(p);
    %p = amat;
    
end
