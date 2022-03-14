%%��ȡGLDAS���ݴ洢Ϊmat��ʽ��������ĵ�Чˮ�ߵ�λΪmm
% �������ݸ�ʽΪ��������������γ����γ��ʽ
% ���ݱ���Ϊgrid_land,grid_soil
clc;
clear;
datadir='G:\Data\GLDAS\GLDAS_NOAH10_M.2.1__200001_202102\';%ָ�������������ڵ��ļ���
save_dir='G:\result\GLDAS\NOAH10\grid_GLDAS_NOAH10_10_200001_202102.mat'; %GLDAS_NOAH_10_200201_201812_grid
filelist=dir([datadir,'*.nc4']);%ָ���������ݵ�����
k=length(filelist);
for s=1:k
     filename=[datadir,filelist(s).name];
     ncid=netcdf.open(filename,'NC_NOWRITE');
     file_name{s,1}=filelist(s).name;%%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
     info=ncinfo(filename);
     time(s,1)=str2double(filename(65:70));  %��ȡnc�ļ�ʱ��
     
     Soil1Data= ncread(filename,'SoilMoi0_10cm_inst'); %�������SoilMoi0_10cm_inst-kg m-2
     Soil1Data(isnan(Soil1Data))=0;
     
     Soil2Data= ncread(filename,'SoilMoi10_40cm_inst'); %�������SoilMoi10_40cm_inst-kg m-2
     Soil2Data(isnan(Soil2Data))=0;
     
     Soil3Data= ncread(filename,'SoilMoi40_100cm_inst'); %�������SoilMoi40_100cm_inst-kg m-2
     Soil3Data(isnan(Soil3Data))=0;

     Soil4Data= ncread(filename,'SoilMoi100_200cm_inst'); %�������SoilMoi100_200cm_inst-kg m-2
     Soil4Data(isnan(Soil4Data))=0;
     
     SWEData= ncread(filename,'SWE_inst');%�������ѩˮ����SWE_inst-kg m-2
     SWEData(isnan(SWEData))=0;
     
     CanopIntData= ncread(filename,'CanopInt_inst');%��������ڲ�ˮCanopInt_inst-kg m-2
     CanopIntData(isnan(CanopIntData))=0;
     
     QsData= ncread(filename,'Qs_acc');%��������ر���Qs_acc-kg m-2
     QsData(isnan(QsData))=0;
     
    soil_aa=Soil1Data+Soil2Data+Soil3Data+Soil4Data;    % soilwater
    land_aa=soil_aa+SWEData+CanopIntData+QsData;
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
%%��ȫ��γ60-90�ȣ�ֵ��Ϊ0
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

%%��time�л�ȡint_year��int_month
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

