% Plotting conjugate multiplied phases

% Cannot load windowed csis!
reading_path = 'Logs/0720/ATake1csi.mat';
%time_path = 'Logs/0624/ATake1timediff.mat';

% read csis
% read time_diff

load(reading_path);
%load(time_path);

angles = angle(csis);
As1 = squeeze(unwrap(angles(1,:,:)));
As2 = squeeze(unwrap(angles(2,:,:)));
conjm = csis(3,:,:) .* conj(csis(1,:,:));
As3 = squeeze(unwrap(angle(conjm)));

% Plotting phase and caliberated phase
figure();
set(gcf,'position',[1, 1, 1000, 5000]);
subplot(3,1,1);
imagesc(flipud(As1));
colormap('jet');
clb = colorbar;
clb.Label.String = ('Angle(rad)');
title('Phase shifting of Antenna1');
xlabel('#sample');
ylabel('#subcarrier');

subplot(3,1,2);
imagesc(flipud(As2));
colormap('jet');
clb = colorbar;
clb.Label.String = ('Angle(rad)');
title('Phase shifting of Antenna2');
xlabel('#sample');
ylabel('#subcarrier');

subplot(3,1,3);
imagesc(flipud(As3));
colormap('jet');
clb = colorbar;
clb.Label.String = ('Angle(rad)');
title('Phase shifting of Conjugate Multiplication');
xlabel('#sample');
ylabel('#subcarrier');

% Plotting phase and caliberated phase at one moment
% figure();
% set(gcf,'position',[1, 1, 1000, 5000]);
% subplot(3,1,1);
% plot(squeeze(As1(:,1500)));
% title('Phase shifting of Antenna1 @1500');
% xlabel('#subcarrier');
% ylabel('phase');
% 
% subplot(3,1,2);
% plot(squeeze(As2(:,1500)));
% title('Phase shifting of Antenna2 @1500');
% xlabel('#subcarrier');
% ylabel('phase');
% 
% subplot(3,1,3);
% plot(squeeze(As3(:,1500)));
% title('Phase shifting of Conjugate Multiplication @1500');
% xlabel('#subcarrier');
% ylabel('phase');

% Plotting phase and caliberated phase max abs value
figure();
set(gcf,'position',[1, 1, 1000, 5000]);
subplot(3,1,1);
plot(squeeze(max(abs(As1))));
title('Max Phase shifting of Antenna1');
xlabel('#sample');
ylabel('phase');

subplot(3,1,2);
plot(squeeze(max(abs(As2))));
title('Max Phase shifting of Antenna2');
xlabel('#sample');
ylabel('phase');

subplot(3,1,3);
plot(squeeze(max(abs(As3))));
title('Max Phase shifting of Conjugate Multiplication');
xlabel('#sample');
ylabel('phase');
