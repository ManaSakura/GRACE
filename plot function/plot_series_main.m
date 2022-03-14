% ���ƻ�������ˮ��Դ�仯ʱ��ͼ,ѡ��ͬģ��
clear;clc;
addpath('G:\Auxiliary function\GLDAS function\');
msk_hbpy='G:\Data\msk_file\huabei_msk.mat';%grid_data��ʽ

%����GLDAS ½��ˮ�仯������ˮ�仯ʱ�����У���λmm

GLDAS_get_time_series('G:\result\GLDAS\CLM\grid_swenson_300_025_land_GLDAS_CLM_10_200204_201608.mat',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_clm_land','GLDAS');
GLDAS_get_time_series('G:\result\GLDAS\CLM\grid_swenson_300_025_soil_GLDAS_CLM_10_200204_201608.mat',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_clm_soil','GLDAS');

GLDAS_get_time_series('G:\result\GLDAS\MOSAIC\grid_swenson_300_025_land_GLDAS_MOSAIC_10_200204_201812',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_mosaic_land','GLDAS');
GLDAS_get_time_series('G:\result\GLDAS\MOSAIC\grid_swenson_300_025_soil_GLDAS_MOSAIC_10_200204_201812',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_mosaic_soil','GLDAS');

GLDAS_get_time_series('G:\result\GLDAS\NOAH10\grid_swenson_300_025_land_GLDAS_NOAH10_10_200001_202102',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_noah10_land','GLDAS');
GLDAS_get_time_series('G:\result\GLDAS\NOAH10\grid_swenson_300_025_soil_GLDAS_NOAH10_10_200001_202102',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_noah10_soil','GLDAS');

GLDAS_get_time_series('G:\result\GLDAS\VIC\grid_swenson_300_025_land_GLDAS_VIC_10_200001_202102',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_vic_land','GLDAS');
GLDAS_get_time_series('G:\result\GLDAS\VIC\grid_swenson_300_025_soil_GLDAS_VIC_10_200001_202102',...
    msk_hbpy,'mask','G:\result\time series\GLDAS\time_series_vic_soil','GLDAS');


%����½��ˮ�仯ʱ�����У���λm
GLDAS_get_time_series('G:\result\GRACE\grid_data',...
    msk_hbpy,'mask','G:\result\time series\GRACE\time_series_TWS','GRACE');

%�������ˮ�仯ʱ�����У���λcm
[time_series_clm_gw]=get_time_series('G:\result\GW\grid_gw month\grace_gldas_gw_clm_2002_2015',...
    msk_hbpy,'mask','G:\result\time series\GW\time_series_clm_gw_hbpy','month');
[time_series_mosaic_gw]=get_time_series('G:\result\GW\grid_gw month\grace_gldas_gw_mosaic_2002_2015',...
    msk_hbpy,'mask','G:\result\time series\GW\time_series_moaic_gw_hbpy','month');
[time_series_noah10_gw]=get_time_series('G:\result\GW\grid_gw month\grace_gldas_gw_noah10_2002_2015',...
    msk_hbpy,'mask','G:\result\time series\GW\time_series_noah10_gw_hbpy','month');
[time_series_vic_gw]=get_time_series('G:\result\GW\grid_gw month\grace_gldas_gw_vic_2002_2015',...
    msk_hbpy,'mask','G:\result\time series\GW\time_series_vic_gw_hbpy','month');
%����ʱ������ͼ
plot_time_series('G:\result\time series\GW\time_series_clm_gw_hbpy',...
    'month','��Чˮ��(cm)','������������ˮ�仯ʱ������','GRACE-CLM','month');

%% ���㲢���Ʊ����еĵ���ˮʱ�����У���λcm
clear;clc;
bj_msk_name='G:\Data\msk_file\bj_msk_720_1440.mat';
%�Ȱѱ�����gw��721�и�Ϊ720�У���lg_mskͬ��
load('G:\result\GW\grid_gw month_025\grace_gldas_gw_noah025_2002_2015.mat');
grid_data_720=grid_data_721_2_720(grid_data);
clear grid_data;
grid_data=grid_data_720;
save('G:\result\GW\grid_gw month_025\grace_gldas_gw_720_1440_noah025_2002_2015.mat',...
    'grid_data','str_year','str_month','time');
disp('save grid data successfully');
%���㱱������ˮ�仯ʱ������
time_series_clm_bj=get_time_series('G:\result\GW\grid_gw month_025\grace_gldas_gw_720_1440_noah025_2002_2015',...
    bj_msk_name,'mask','G:\result\time series\GW\time_series_noah025_gw_bj','month');

%���㱱��½��ˮ�仯ʱ������
%�Ȱѱ�����TWS��721�и�Ϊ720�У���lg_mskͬ��
clear;clc;
bj_msk_name='G:\Data\msk_file\bj_msk_720_1440.mat';
load('G:\result\GRACE\GRACE025\grid_data_025_leakagefree.mat');
grid_data_720=grid_data_721_2_720(grid_data);
clear grid_data;
grid_data=grid_data_720;
save('G:\result\GRACE\GRACE025\grid_data_025_720_1440_leakagefree',...
    'grid_data','str_year','str_month','time');%����grid_data����
GLDAS_get_time_series('G:\result\GRACE\GRACE025\grid_data_025_720_1440_leakagefree',...
    bj_msk_name,'mask','G:\result\time series\GRACE\time_series_TWS_bj_720_1440_leakagefree','GRACE');%����time_series����

%���㱱���ر�ˮ�仯ʱ������
clear;clc;
bj_msk_name='G:\Data\msk_file\bj_msk_720_1440.mat';
load('G:\result\GLDAS\NOAH025\grid_swenson_300_land_GLDAS_NOAH025_025_200001_202102.mat');
grid_data_720=grid_data_721_2_720(grid_data);
clear grid_data;
grid_data=grid_data_720;
save('G:\result\GLDAS\NOAH025\grid_swenson_300_land__NOAH025_720_1440_200001_202102.mat',...
    'grid_data','int_year','int_month','time');
GLDAS_get_time_series('G:\result\GLDAS\NOAH025\grid_swenson_300_land__NOAH025_720_1440_200001_202102.mat',...
    bj_msk_name,'mask','G:\result\time series\GLDAS\time_series_land_bj_720_1440','GLDAS');

%���㱱������ˮ�仯ʱ������
clear;clc;
bj_msk_name='G:\Data\msk_file\bj_msk_720_1440.mat';
load('G:\result\GLDAS\NOAH025\grid_swenson_300_soil_GLDAS_NOAH025_025_200001_202102.mat');
grid_data_720=grid_data_721_2_720(grid_data);
clear grid_data;
grid_data=grid_data_720;
save('G:\result\GLDAS\NOAH025\grid_swenson_300_soil__NOAH025_720_1440_200001_202102.mat',...
    'grid_data','int_year','int_month','time');
GLDAS_get_time_series('G:\result\GLDAS\NOAH025\grid_swenson_300_soil__NOAH025_720_1440_200001_202102.mat',...
    bj_msk_name,'mask','G:\result\time series\GLDAS\time_series_soil_bj_720_1440','GLDAS');

%plot
plot_time_series('G:\result\time series\GW\time_series_noah025_gw_bj',...
     'month','��Чˮ��(cm)','�����е���ˮ�仯ʱ������','GRACE-NOAH025','month');

plot_time_series('G:\result\time series\GRACE\time_series_TWS_bj_720_1440_leakagefree',...
     'month','��Чˮ��(m)','������½��ˮ�仯ʱ������','GRACE','month');
 
plot_time_series('G:\result\time series\GLDAS\time_series_land_bj_720_1440',...
     'month','��Чˮ��(mm)','�����еر�ˮ�仯ʱ������','G','month');

 