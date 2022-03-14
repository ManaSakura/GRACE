% %��ȡGPCP�����еĽ�ˮ���ݱ���Ϊmat����������������γ����γ��,�ռ�ֱ���Ϊ2.5��,72*144����λmm/day��ת��Ϊ�½�ˮ������ϵ�������
% clear;clc;
% datadir='G:\Data\GPCP_data\2021\';
% savedir='G:\Data\GPCP_Precip_mat\GCPC_72_144_2.5_2021.mat';
function read_GPCP4Precip(datadir,savedir)
%   datadir:GPCPһ���ܵĽ������ݴ�ŵ��ļ���
%   savedir:��������·������GPCP�ļ��ж�ȡ�Ľ������ݣ�����Ϊmat����������������γ����γ��,�ռ�ֱ���Ϊ2.5��,72*144����λmm/day��ת��Ϊ�½�ˮ������ϵ�������
filelist=dir([datadir,'*.nc']);%ָ���������ݵ�����
k=length(filelist);
for i=1:k
    name=filelist(i).name;
    filename=[datadir,name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    info=ncinfo(filename);
    int_year(i,:)=str2double(name(22:25));
    int_month(i,:)=str2double(name(26:27));
    PrecipDataSN= ncread(filename,'precip')';%ת�ú�Ϊ��������������γ����γ����
    lon(i,:)=ncread(filename,'longitude')';
    lat(i,:)=fliplr(ncread(filename,'latitude')');
    days=gmt_get_days(int_year(i,:),int_month(i,:),15);
    if(mod(int_year,4)==0)%����
        time_tmp=days/366+int_year(i,:);
    end
    if(mod(int_year,4)~=0)%������
        time_tmp=days/365+int_year(i,:);
    end
    time(i,:)=time_tmp;
    netcdf.close(ncid);
    PrecipData_conv=mask_convert_NS(PrecipDataSN);%��ת�ú���������·�ת����ת��Ϊ��������������γ����γ��ʽ��grid_data��ʽ��
    PrecipData(:,:,i)=double(PrecipData_conv);
end
longitude=double(lon);
latitude=double(lat);
save(savedir,'PrecipData','longitude','latitude','time','int_year','int_month');
display('save GPCP data successfully');