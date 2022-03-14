%%��ȡGLDAS���ݴ洢Ϊmat��ʽ��������ĵ�Чˮ�ߵ�λΪmm
% �������ݸ�ʽΪ��������������γ����γ��ʽ
% ���ݱ���Ϊgrid_land,grid_soil
clc;
clear;
datadir='G:\Data\GLDAS\GLDAS_CLM_10_M_200204_201608\';%ָ�������������ڵ��ļ���
save_dir='G:\result\GLDAS\CLM\grid_GLDAS_CLM_10_200204_201608.mat';
filelist=dir([datadir,'*.nc4']);%ָ���������ݵ�����
k=length(filelist);
for s=1:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    file_name{s,1}=filelist(s).name;%%�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
    info=ncinfo(filename);
    time(s,1)=str2double(filename(59:64));  %��ȡnc�ļ�ʱ��
    SoilData= ncread(filename,'SoilMoist'); %�������SoilMoi0_10cm_inst-kg m-2
    SoilData(isnan(SoilData))=0;
          
    SWEData= ncread(filename,'SWE');%�������ѩˮ����SWE_inst-kg m-2
    SWEData(isnan(SWEData))=0;
     
    CanopIntData= ncread(filename,'Canopint');%��������ڲ�ˮCanopInt_inst-kg m-2
    CanopIntData(isnan(CanopIntData))=0;
     
    soil_aa=sum(SoilData,3);    % soilwater
    land_aa=soil_aa+SWEData+CanopIntData;
    soil_bb(:,:,s)=soil_aa';
    land_bb(:,:,s)=land_aa';     
    netcdf.close(ncid);
end

soil_mean=mean(soil_bb,3);
land_mean=mean(land_bb,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%�۳�������
for j =1:k
    soil_cc(:,:,j)=(soil_bb(:,:,j)-soil_mean); %��λΪmm
    land_cc(:,:,j)=(land_bb(:,:,j)-land_mean);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%�۳�������
% temp_soil=(soil_mean~=0);
% temp_land=(land_mean~=0);
% num_soil=sum(temp_soil(:));
% num_land=sum(temp_land(:));
% sum_soil=sum(soil_mean(:))/num_soil;
% sum_land=sum(land_mean(:))/num_land;
% 
% for j =1:k
%     soil_cc(:,:,j)=(soil_bb(:,:,j)-sum_soil); %��λΪmm
%     land_cc(:,:,j)=(land_bb(:,:,j)-sum_land);
%     
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
