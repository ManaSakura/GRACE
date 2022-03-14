clc;clear;
addpath('G:\GRACE\GLDAS_fuction');
addpath('G:\Auxiliary function');
addpath('G:\fengweiigg-GRACE_Matlab_Toolbox-61c8064\GRACE_functions');
addpath('G:\fengweiigg-GRACE_Matlab_Toolbox-61c8064\GRACE_functions\simons\');
addpath('G:\fengweiigg-GRACE_Matlab_Toolbox-61c8064');
c11cmn=[-89.5 89.5 -179.5 179.5];

%%  ����GRACE����  %%
%����grace����,������ȡ���ݣ��滻C20,C21,C22,S21,S22���滻һ������вȥ�������Ƴ�GIAЧӦ����˹ƽ��������Ϊcs_gsm_csr_swenson_2002_2015_60degree
% run('GRACE_Matlab_Toolbox_preprocessing.m');
controlfile_path='G:\grace_demo_test\GMT_Control_File_csr_2002_2013.txt';
GRACE_Matlab_Toolbox_preprocessing_core(controlfile_path);
cs_gsm=load('G:\Auxiliary function\result\GRACE\cs_gsm_csr_swenson_2002_2015_60degree.mat');

% %%�ռ���۳�й¶�����ļ�Ϊcs_gsm������Ϊcs_leakage_oceanremoved_swenson_0km
%   ����½�����ݼ���land����(GUI����ĵڶ���ѡ�,�Ƴ�����й©��½�ص��źţ�ͨ������½������
%   'ocean', Ocean Leakage Reduction: remove land's leakage effect ,load lg_msk_land_025.mat
%   'land', Land Leakage Reduction: remove ocean's leakage effect, load lg_msk_ocean_025.mat
addpath('G:\fengweiigg-GRACE_Matlab_Toolbox-61c8064\GRACE_data\msk_files');
run('GRACE_Matlab_Toolbox_LeakageReductionSpatial.m');

% % % % % % % % % %
% %%��Э�ϳɣ�csתΪgrid�������ļ�Ϊ�����cs_gsm_csr_swenson_2002_2015_60degree��cs_leakage_oceanremoved_swenson_0km��cs�ļ���������Ϊgrid_data
run('GRACE_Matlab_Toolbox_SHGrid.m');

% %%����ʱ�����У����ļ�Ϊgrid_data,����Ϊtime_series(Time series of mass variation in XXX)
% ��ʱ���������GLDAS_get_time_series.m��gmt_grid2series�޸ĵķ�������data_typeѡ��'GRACE'��
GLDAS_get_time_series('G:\GRACE_processing\hbpy2018_2021\grid_data.mat','G:\GRACE_processing\hbpy_msk_721_1440.mat','mask',...
    'G:\GRACE_processing\hbpy2018_2021\time_series_msk','GRACE');
GLDAS_get_time_series('G:\GRACE_processing\hbpy2002_2021\grid_data_721_1440.mat',...
    'G:\GRACE_processing\bj\bj_msk_721_1440.mat','mask',...
    'G:\GRACE_processing\bj\bj_grace_time_series_200204_202112','GRACE');
run('GRACE_Matlab_Toolbox_Grid2Series.m');
clear;
load('G:\Data\hbpy result\time_series025.mat');
% %����ʱ������
plot(time,time_series*100,'-s');
xlabel('Year');
ylabel('Equivalent water height (cm)');
title('������½��ˮ�����仯ͼ');

% %% Harmonic analysis
%Do harmonic analysis on time series(��ʱ�����н���г��������,input:time_series
%Do harmonic analysis in the spatial domain���ڿռ������г��������,input:grid_data, output��trend.mat
run GRACE_Matlab_Toolbox_HarmonicAnalysis.m;
%plot the trend map ��Trend map of mass variation from GRACE ��
load('G:\Auxiliary function\result\GRACE\trend');
gmt_grid2map(trend*100,5,'cm/yr','Trend map of mass variations from GRACE')


%% ����GLDAS����
run('GLDAS_main.m');
%% 
% %��GRACE,GLDAS���ݼ���GW(721*1440)
clear;clc;
%����ƽԭ
grace_gldas_gw('G:\GRACE_processing\hbpy2002_2021\grid_data_721_1440.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grid_721_1440_swenson_300_land_GLDAS_NOAH025_025_200001_202111.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grace_gldas_gw_721_1440_JPL06_noah025_200001_202111.mat');

%% ��������ͼ,grid_data��λ��ʲô��trend��λ����ʲô
%�����grid_dataΪ����ˮ���ݣ����������ļ�Ϊ����ˮ������
clear;clc;
% run GRACE_Matlab_Toolbox_HarmonicAnalysis.m;
%ѡȡ��gw�ļ�·������ % grid_data_clm='G:\Auxiliary function\result\GW\grace_gldas_gw_clm_2002_2015.mat';
% trend_gw_clm=load('G:\Auxiliary function\result\Trend\trend_GW_clm');%gw,cm
% trend_gw_mosaic=load('G:\Auxiliary function\result\Trend\trend_GW_mosaic');%gw,cm
trend_gw_noah10=load('G:\Auxiliary function\result\Trend\trend_GW_noah10');%gw,cm
% trend_gw_vic=load('G:\Auxiliary function\result\Trend\trend_GW_vic');%gw,cm
trend=trend_gw_noah10.trend;
gmt_grid2map(trend,5,'cm/yr','����ˮ������Чˮ�߱仯����ͼ');

%%��721*1440����תΪ720*1440
GRACE_grid_data=grid_data_721_2_720_vary('G:\GRACE_processing\hbpy2002_2017\grid_data_721_1440.mat',...
    'G:\GRACE_processing\hbpy2002_2017\grid_data_720_1440.mat','GRACE');
GLDAS_LAND=grid_data_721_2_720_vary('G:\GRACE_processing\hbpy2002_2021\grid_721_1440_swenson_300_land_GLDAS_NOAH025_025_200001_202111.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grid_720_1440_swenson_300_land_GLDAS_NOAH025_025_200001_202111.mat','GLDAS');
GLDAS_SOIL=grid_data_721_2_720_vary('G:\GRACE_processing\hbpy2002_2021\grid_721_1440_swenson_300_soil_GLDAS_NOAH025_025_200001_202111.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grid_720_1440_swenson_300_soil_GLDAS_NOAH025_025_200001_202111.mat','GLDAS');
GW=grid_data_721_2_720_vary('G:\GRACE_processing\hbpy2002_2021\grace_gldas_gw_721_1440_JPL06_noah025_200001_202111.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grace_gldas_gw_720_1440_JPL06_noah025_200001_202111.mat','GW');
Precip=grid_data_721_2_720_vary('G:\Data\GPCP_Precip_mat\GCPC_721_1440_025_mm_d_200201_202112.mat',...
    'G:\Data\GPCP_Precip_mat\GCPC_720_1440_025_mm_d_200201_202112.mat','GCPC');
%% ���Ƶ���ˮ������Чˮ����仯��ʱ������
clear;clc;
plot_time_series('G:\Auxiliary function\result\time_series\year series\time_series_year_clm_hbpy','��','��Чˮ��(cm)','������������ˮ�仯ʱ������','GRACE-NOAH025','month');

plot_series('G:\GRACE_processing\hbpy2018_2021\grid_data_720_1440.mat',...
    'G:\GRACE_processing\hbpy2018_2021\grid_720_1440_swenson_300_land_GLDAS_NOAH025_025_201805_202111.mat',...
    'G:\GRACE_processing\hbpy2018_2021\grid_720_1440_swenson_300_soil_GLDAS_NOAH025_025_201805_202111.mat',...
    'G:\GRACE_processing\hbpy2018_2021\grace_gldas_gw_720_1440_JPL06_noah025_201805_202111.mat',...
    'G:\GRACE_processing\hbpy_720_1440.mat',[2018 2022 -10 20],'G:\GRACE_processing\TRMM\precipitation_1998_2019__M_025.mat');
plot_series('G:\GRACE_processing\hbpy2002_2017\grid_data_720_1440.mat',...
    'G:\GRACE_processing\hbpy2002_2017\grid_720_1440_swenson_300_land_GLDAS_NOAH025_025_200201_201712.mat',...
    'G:\GRACE_processing\hbpy2002_2017\grid_720_1440_swenson_300_soil_GLDAS_NOAH025_025_200201_201712.mat',...
    'G:\GRACE_processing\hbpy2002_2017\grace_gldas_gw_720_1440_JPL06_noah025_200201_201712.mat',...
    'G:\GRACE_processing\hbpy_720_1440.mat',[2002 2018 -10 20],'G:\GRACE_processing\TRMM\precipitation_1998_2019__M_025.mat');
%����2002-2021
plot_series('G:\GRACE_processing\hbpy2002_2021\grid_data_720_1440.mat',...
    'G:\result\GLDAS\NOAH025\grid_swenson_300_land__NOAH025_720_1440_200001_202102.mat',...
    'G:\result\GLDAS\NOAH025\grid_swenson_300_soil__NOAH025_720_1440_200001_202102.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grace_gldas_gw_720_1440_JPL06_noah025_200204_202111.mat',...
    'G:\GRACE_processing\hbpy_msk_720_1440.mat',[2002 2022 -10 20],...
    'G:\Data\GPCP_Precip_mat\GCPC_720_1440_025_mm_d_200201_202112.mat');
%����2002-2021
plot_series('G:\GRACE_processing\hbpy2002_2021\grid_data_720_1440.mat',...
    'G:\result\GLDAS\NOAH025\grid_swenson_300_land__NOAH025_720_1440_200001_202102.mat',...
    'G:\result\GLDAS\NOAH025\grid_swenson_300_soil__NOAH025_720_1440_200001_202102.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grace_gldas_gw_720_1440_JPL06_noah025_200204_202111.mat',...
    'G:\GRACE_processing\bj\bj_msk_720_1440.mat',[2002 2022 -10 20],...
    'G:\Data\GPCP_Precip_mat\GCPC_720_1440_025_mm_d_200201_202112.mat');
plot_series('G:\GRACE_processing\hbpy2002_2021\grid_data_721_1440.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grid_721_1440_swenson_300_land_GLDAS_NOAH025_025_200001_202111.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grid_721_1440_swenson_300_soil_GLDAS_NOAH025_025_200001_202111.mat',...
    'G:\GRACE_processing\hbpy2002_2021\grace_gldas_gw_721_1440_JPL06_noah025_200001_202111.mat',...
    'G:\GRACE_processing\bj\bj_msk_721_1440.mat',[2000 2022 -10 20],...
    'G:\Data\GPCP_Precip_mat\GCPC_721_1440_025_mm_d_200201_202112.mat');

%% ����ȫ����Ƶ���ˮ�ռ�ֲ�ͼ
clear;clc;
grid_data_dir='G:\result\GW\grid_gw month_025\grace_gldas_gw_noah025_2002_2015';
colorbar_unit='cm';
title_string='ȫ�����ˮ������Чˮ�߱仯�ֲ�ͼ';
type='month';
save_folder='G:\result\plot\map\GW\month gw\NOAH10\';
plot_spatial_distribution(grid_data_dir,colorbar_unit,title_string,save_folder,type);

%% �������ƻ���ƽԭ��������ˮ�ռ�ֲ�ͼ
clear;clc;
hbpy_c11cmn=[110 128 45 28];
plot_spatial_distribution('G:\Data\hbpy result\grace_gldas_gw_720_1440_csr05_noah025_2002_2020.mat',...
    'cm','������������ˮ������Чˮ�߱仯�ֲ�ͼ','G:\Data\hbpy result\hbpy GW\','month',hbpy_c11cmn,20);
