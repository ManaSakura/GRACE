%����2002-2021�껪��ƽԭ����ˮ(cm)��½��ˮ����(��λm����ת��Ϊcm��
clear;clc;
tws_filepath='G:\GRACE_processing\hbpy2002_2021\time_series_grace.mat';
gw_filepath='G:\GRACE_processing\hbpy2002_2021\time_series_hbpy_gw.mat';
tws=load(tws_filepath);
gw=load(gw_filepath);
plot(tws.time,tws.time_series*100,'-s');
hold on;
plot(gw.time,gw.time_series,'-s');
xlabel('Year');
ylabel('Equivalent water height (cm)');
title('����ƽԭ½��ˮ�͵���ˮ�����仯ͼ');
legend('TWS','GW');

