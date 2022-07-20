% Plotting csi for each antenna

pc1_path = 'dataset/csi0720Atake6.dat';
pc2_path = 'dataset/csi0720Btake6.dat';

pc1csi = get_csi(pc1_path);
pc2csi = get_csi(pc2_path);

figure;
set(gcf,'position',[1, 1, 1000, 5000]);
subplot(3,1,1);
plot(db(abs(squeeze(pc1csi(1,:,:)).')));
xlabel('#Packet');
ylabel('SNR [dB]');
title('PC1 Antenna1');

subplot(3,1,2);
plot(db(abs(squeeze(pc1csi(2,:,:)).')));
xlabel('#Packet');
ylabel('SNR [dB]');
title('PC1 Antenna2');

subplot(3,1,3);
plot(db(abs(squeeze(pc1csi(3,:,:)).')));
xlabel('#Packet');
ylabel('SNR [dB]');
title('PC1 Antenna3');

figure;
set(gcf,'position',[1, 1, 1000, 5000]);
subplot(3,1,1);
plot(db(abs(squeeze(pc2csi(1,:,:)).')));
xlabel('#Packet');
ylabel('SNR [dB]');
title('PC2 Antenna1');

subplot(3,1,2);
plot(db(abs(squeeze(pc2csi(2,:,:)).')));
xlabel('#Packet');
ylabel('SNR [dB]');
title('PC2 Antenna2');

subplot(3,1,3);
plot(db(abs(squeeze(pc2csi(3,:,:)).')));
xlabel('#Packet');
ylabel('SNR [dB]');
title('PC2 Antenna3');

function out = get_csi(data)

csi_trace = read_bf_file(data);
out = zeros(3,30,length(csi_trace));

    for i=1:length(csi_trace)
        out(:,:,i) = get_scaled_csi(csi_trace{i});
    end

end