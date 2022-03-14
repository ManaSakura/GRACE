%%��ȡGLDAS���ݴ洢Ϊmat��ʽ��������ĵ�Чˮ�ߵ�λΪmm
clc;
clear;
datadir='G:\Data\GLDAS\GLDAS_NOAH025_M.2.1__200001_202111\';%ָ�������������ڵ��ļ���
save_dir='G:\GRACE_processing\hbpy2002_2021\grid_GLDAS_NOAH025_025_200001_202111.mat';
filelist=dir([datadir,'*.nc4']);%ָ���������ݵ�����
%a=filelist(1).name;%%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
%b=filelist(2).name;%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(2).name��window��Ϊ�ڶ����������
k=length(filelist);
for s=1:k
     filename=[datadir,filelist(s).name];
     ncid=netcdf.open(filename,'NC_NOWRITE');
     file_name{s,1}=filelist(s).name;%%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
     %ncdisp('D:\MATLAB\toolbox\nctoolbox\data\GLDAS_NOAH025_3H.A20170801.0000.021.nc4');%���п���
     %ncid=netcdf.open('D:\MATLAB\toolbox\nctoolbox\data\GLDAS_NOAH025_3H.A20170801.0000.021.nc4','NOWRITE');%���п���
     info=ncinfo(filename);
     time(s,1)=str2double(filename(67:72));  %��ȡnc�ļ�ʱ��
     %ncdisp('D:\MATLAB\toolbox\nctoolbox\data\GLDAS_NOAH025_3H.A20170801.0000.021.nc4'); %���п���
     %LonData{s}     = ncread(filename,'lon'); %�������lon����
     %LatData{s}     = ncread(filename,'lat'); %�������latγ��
     %lon = ncread(filename,'lon'); %�������lon����
     %lat = ncread(filename,'lat'); %�������latγ��
     %Lon=LonData{1,length(LonData)};
     %Lat=LatData{1,length(LatData)};
     %    [lat,lon] = meshgrid(LatData,LonData);
     %    lat=lat';
     %    lon=lon';
     Soil1Data= ncread(filename,'SoilMoi0_10cm_inst'); %�������SoilMoi0_10cm_inst-kg m-2
     Soil1Data(isnan(Soil1Data))=0;
     %Soil1q{s}=interp2(X,Y,Soil1Data,39.4256,-112.8449,'cubic'); %��ֵָ����λ����ˮ��ֵ
     
     Soil2Data= ncread(filename,'SoilMoi10_40cm_inst'); %�������SoilMoi10_40cm_inst-kg m-2
     Soil2Data(isnan(Soil2Data))=0;

     %Soil2q{s}=interp2(X,Y,Soil2Data,39.4256,-112.8449,'cubic'); %��ֵָ����λ����ˮ��ֵ
     
     Soil3Data= ncread(filename,'SoilMoi40_100cm_inst'); %�������SoilMoi40_100cm_inst-kg m-2
     Soil3Data(isnan(Soil3Data))=0;

    % Soil3q{s}=interp2(X,Y,Soil3Data,39.4256,-112.8449,'cubic'); %��ֵָ����λ����ˮ��ֵ
     
     Soil4Data= ncread(filename,'SoilMoi100_200cm_inst'); %�������SoilMoi100_200cm_inst-kg m-2
     Soil4Data(isnan(Soil4Data))=0;
     %Soil4q{s}=interp2(X,Y,Soil4Data,39.4256,-112.8449,'cubic'); %��ֵָ����λ����ˮ��ֵ
     
     SWEData= ncread(filename,'SWE_inst');%�������ѩˮ����SWE_inst-kg m-2
     SWEData(isnan(SWEData))=0;
    % SWEq{s}=interp2(X,Y,SWEData,39.4256,-112.8449,'cubic'); %��ֵָ����λѩˮ����ֵ
     
     CanopIntData= ncread(filename,'CanopInt_inst');%��������ڲ�ˮCanopInt_inst-kg m-2
     CanopIntData(isnan(CanopIntData))=0;
    % CanopIntq{s}=interp2(X,Y,CanopIntData,39.4256,-112.8449,'cubic'); %��ֵָ����λ�ڲ�ˮֵ
     
     QsData= ncread(filename,'Qs_acc');%��������ر���Qs_acc-kg m-2
     QsData(isnan(QsData))=0;
    % Qsq{s}=interp2(X,Y,QsData,39.4256,-112.8449,'cubic'); %��ֵָ����λ�ر���ֵ
     
    soil_aa=Soil1Data+Soil2Data+Soil3Data+Soil4Data;    % soilwater
    land_aa=soil_aa+SWEData+CanopIntData+QsData;
    soil_bb(:,:,s)=soil_aa';
    land_bb(:,:,s)=land_aa';     
    netcdf.close(ncid);
    pause(3);
end

soil_mean=mean(soil_bb,3);
land_mean=mean(land_bb,3);

%%�۳�������

for j =1:k
    soil_cc(:,:,j)=(soil_bb(:,:,j)-soil_mean); %��λΪmm
    land_cc(:,:,j)=(land_bb(:,:,j)-land_mean);
    
end

%��ȫ��γ60-90��
lat=(-89.875:0.25:89.875)';
lon=(0.125:0.25:359.875)';
a=zeros(120,1440);

for i=1:k
    soil_dd(:,:,i)=[a;soil_cc(:,:,i)];
    land_dd(:,:,i)=[a;land_cc(:,:,i)];
        
end

clear soil_aa soil_bb soil_cc land_aa land_bb land_cc soil_mean land_mean;

%%��GLDASԭʼ����-180-180��������������תΪ0-360��������������
for i=1:k
    grid_soil(:,:,i)=mask_convert(soil_dd(:,:,i));
    grid_land(:,:,i)=mask_convert(land_dd(:,:,i));
end

%%��time�л�ȡint_year��int_month
int_year=floor(time/100);
int_month=time-int_year*100;

%%�洢����ˮsoil��½��ˮland��ʱ��time���ļ���file_name������lon��γ��lat
save(save_dir,'grid_soil','-v7.3');
save(save_dir,'grid_land','-append');
save(save_dir,'int_year','-append');
save(save_dir,'int_month','-append');
save(save_dir,'file_name','-append');
save(save_dir,'lat','-append');
save(save_dir,'lon','-append');
save(save_dir,'time','-append');

% clear
% clc
disp(['Save successfully.']);
