%����grid_data����ʱ������
clear;clc;
savepath1='G:\GRACE_processing\bj\time_series_grace_2002_2021_original.mat';
savepath2='G:\GRACE_processing\bj\time_series_grace_2002_2017_original.mat';

GLDAS_get_time_series('G:\GRACE_processing\hbpy2002_2021\grid_data_721_1440.mat',...
    'G:\GRACE_processing\bj\bj_msk_721_1440.mat','mask',...
    'G:\GRACE_processing\bj\bj_grace_time_series_200204_202112','GRACE');%�˺�����GLDAS function�ļ���������
save(savepath1,'time_series','time','int_month','int_year');

GLDAS_get_time_series('G:\GRACE_processing\hbpy2002_2017\grid_data_721_1440.mat',...
    'G:\GRACE_processing\bj\bj_msk_721_1440.mat','mask',...
    'G:\GRACE_processing\bj\bj_grace_time_series_200204_201706','GRACE');%�˺�����GLDAS function�ļ���������
save(savepath2,'time_series','time','int_month','int_year');
