%%��ȡGLDAS���ݴ洢Ϊmat��ʽ��������ĵ�Чˮ�ߵ�λΪmm
% �������ݸ�ʽΪ��������������γ����γ��ʽ
% ���ݱ���Ϊgrid_land,grid_soil
clc;
clear;
datadir='G:\Data\GLDAS\GLDAS_VIC10_M.2.1_200001_202102\';%ָ�������������ڵ��ļ���
save_dir='G:\result\GLDAS\VIC\grid_GLDAS_VIC_10_200001_202102.mat';
filelist=dir([datadir,'*.nc4']);%ָ���������ݵ�����
%a=filelist(1).name;%%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
%b=filelist(2).name;%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(2).name��window��Ϊ�ڶ����������
k=length(filelist);
for s=1:k
     %b=s+201802;
     filename=[datadir,filelist(s).name];
     ncid=netcdf.open(filename,'NC_NOWRITE');
     file_name{s,1}=filelist(s).name;%%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
     %ncdisp('D:\MATLAB\toolbox\nctoolbox\data\GLDAS_NOAH025_3H.A20170801.0000.021.nc4');%���п���
     %ncid=netcdf.open('D:\MATLAB\toolbox\nctoolbox\data\GLDAS_NOAH025_3H.A20170801.0000.021.nc4','NOWRITE');%���п���
     info=ncinfo(filename);
     time(s,1)=str2double(filename(62:67));  %��ȡnc�ļ�ʱ��
     
     SoilData1=ncread(filename,'SoilMoi0_30cm_inst');
     SoilData1(isnan(SoilData1))=0;
     SoilData2=ncread(filename,'SoilMoi_depth2_inst');
     SoilData2(isnan(SoilData2))=0;
     SoilData3=ncread(filename,'SoilMoi_depth3_inst');
     SoilData3(isnan(SoilData3))=0;
     
     SoilData= SoilData1+SoilData2+SoilData3;
     %Soil1q{s}=interp2(X,Y,Soil1Data,39.4256,-112.8449,'cubic'); %��ֵָ����λ����ˮ��ֵ
          
     SWEData= ncread(filename,'SWE_inst');%�������ѩˮ����SWE_inst-kg m-2
     SWEData(isnan(SWEData))=0;
    % SWEq{s}=interp2(X,Y,SWEData,39.4256,-112.8449,'cubic'); %��ֵָ����λѩˮ����ֵ
     
     CanopIntData= ncread(filename,'CanopInt_inst');%��������ڲ�ˮCanopInt_inst-kg m-2
     CanopIntData(isnan(CanopIntData))=0;
    % CanopIntq{s}=interp2(X,Y,CanopIntData,39.4256,-112.8449,'cubic'); %��ֵָ����λ�ڲ�ˮֵ
     
    soil_aa=SoilData;    % soilwater
    land_aa=soil_aa+SWEData+CanopIntData;
    soil_bb(:,:,s)=soil_aa';
    land_bb(:,:,s)=land_aa';     
    netcdf.close(ncid);
end

soil_mean=mean(soil_bb,3);
land_mean=mean(land_bb,3);

%%�۳�������

for j =1:k
    soil_cc(:,:,j)=(soil_bb(:,:,j)-soil_mean); %��λΪmm
    land_cc(:,:,j)=(land_bb(:,:,j)-land_mean);
    
end
%% ��ȫ��γ60-90�ȣ�ֵ��Ϊ0
lat=-89.5:1:89.5;
lat=lat';
lon=(0.5:1:359.5)';
a=zeros(30,360);
for i=1:k
    soil_dd(:,:,i)=[a;soil_cc(:,:,i)];
    land_dd(:,:,i)=[a;land_cc(:,:,i)];
        
end

%%��GLDASԭʼ����-180-180תΪ0-360
for i=1:k
    soil_ee=soil_dd(:,1:180,i);
    grid_soil(:,:,i)=[soil_dd(:,181:360,i) soil_ee];
    land_ee=land_dd(:,1:180,i);
    grid_land(:,:,i)=[land_dd(:,181:360,i) land_ee];
end

%% ��time�л�ȡint_year��int_month
int_year=floor(time/100);
int_month=time-int_year*100;

%%�洢����ˮsoil��½��ˮland��ʱ��time���ļ���file_name������lon��γ��lat
save(save_dir,'grid_soil');
save(save_dir,'grid_land','-append');
save(save_dir,'int_year','-append');
save(save_dir,'int_month','-append');
save(save_dir,'file_name','-append');
save(save_dir,'lat','-append');
save(save_dir,'lon','-append');
save(save_dir,'time','-append');

clear
clc
disp(['Save successfully.']);
