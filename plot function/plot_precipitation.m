clear;clc;
addpath('G:\Auxiliary function\mask function');
%�����ļ�·��
TRMM_name='G:\Data\TRMM\3B43\';%��ˮ����
msk_720_1440_name='G:\Data\msk_file\bj_msk_720_1440.mat';%lg_msk�ļ�
time_series_gwname='G:\result\time series\GW\time_series_noah025_gw_bj.mat';%����ˮ����
TWS_name='G:\result\time series\GRACE\time_series_TWS_bj_720_1440_leakagefree';%½��ˮ
land_name='G:\result\time series\GLDAS\time_series_land_bj_720_1440';%�ر�ˮ
soil_name='G:\result\time series\GLDAS\time_series_soil_bj_720_1440';%����ˮ
natidata_name='G:\����ͳ�ƾ�����\����ˮ������\natudata_bj.mat';%����ˮʵ�����ݣ��꣩


[precipitation,time_p,str_pyear,str_pmonth]=read_TRMM_3B43(TRMM_name);%��ˮ����mm��
% [precipitation,time,str_year,str_month]=read_TRMM_3B43('G:\Data\TRMM\3B43\');
precipitation=precipitation*24*30;%��������������γ����γ��ʽ
% save(savename_TRMM,'precipitation','str_year','str_month','time','-v7.3');
k=size(precipitation,3);
pr=zeros(size(precipitation));
for i=1:k
    pr_tmp=mask_convert_NS(precipitation(:,:,i));%�����ϱ�γ,hdf�ļ�Ϊ��γ����γ����
    pr(:,:,i)=pr_tmp;
end
precipitation=pr;

 %%
 %ʵ������
% read_naturaldata('G:\����ͳ�ƾ�����\����','G:\����ͳ�ƾ�����\����ˮ������\natudata_bj.mat');
Sbeijing=16410;     %km^2
[time_series_nati,time_nati]=get_natidata_series(Sbeijing,natidata_name);

%% ���ƽ�ˮʱ��ͼ

msk=load(msk_720_1440_name);
lg_msk=msk.lg_msk;%��������������γ����γ����
time_series_prec=gmt_grid2series(precipitation,msk_720_1440_name,'mask',89.5);
ts=load(time_series_gwname);%����ˮ��cm
time_series_gw=ts.time_series;
time_gw=ts.time;
time_p02=time_p';
time_p02=time_p02(49:216,:);%2002~2015�������
time_series_p02=time_series_prec(49:216.);



ts_TWS=load(TWS_name);
ts_land=load(land_name);
ts_soil=load(soil_name);
time_series_TWS=ts_TWS.time_series;
time_series_land=ts_land.time_series;
time_series_soil=ts_soil.time_series;
TWS_time=ts_TWS.time;
land_time=ts_land.time;
soil_time=ts_soil.time;
%

 f=figure;
 yyaxis right%����������
 bar(time_p02,time_series_p02);%����״ͼ
 title('��������ˮ�����뽵������չ����');
 xlabel('��');
 ylabel('������(mm)');
 yyaxis left%����������
 hold on;

 plot(time_gw,time_series_gw,'-s','color','r','marker','none');%������ͼ
 plot(TWS_time,time_series_TWS*100,'-s','color','b','marker','none');
 plot(land_time,time_series_land/10,'-s','color','g','marker','none');
 plot(soil_time,time_series_soil/10,'-s','color','k','marker','none');
 plot(time_nati,time_series_nati);
%  grid on;
 legend('underground water','land water','surface water','soil water','national data');
 ylabel('��Чˮ��(cm)');
 axis([2002 2016 -10 20]);
 set(gca,'XTick',[2002:1:2016]);
 

