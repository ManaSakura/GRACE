%����GRACE�����grid_data���ݡ�GLDAS�е�land���ݺ�soil���ݡ�gw�е�grid_data���ݡ����������ݡ�����lg_msk�ļ�����ʱ������ͼ
% function plot_series(grid_name_grace,grid_name_gldas_land,grid_name_gldas_soil,grid_gw_name,precipitation_name,lg_msk_name,dir_natidata)
% function plot_series(grid_name_grace,grid_name_gldas_land,grid_name_gldas_soil,grid_gw_name,precipitation_name,lg_msk_name)
function plot_series(grid_name_grace,grid_name_gldas_land,grid_name_gldas_soil,grid_gw_name,lg_msk_name,setAxis,precipitation_name)
%   ���в�����Ϊgrid�ļ�����·��
%   grid_name_grace��GRACE�����grid_data�ļ�·��������grid_data,str_month,str_year,time����������������γ����γ��ʽ
%   grid_name_gldas_land:����GLDAS�������õ�grid_data(land)�����ļ�·��������grid_data,int_month,int_year,time����������������γ����γ
%   grid_gw_name������ˮ���������ļ�·��������grid_data,str_month,str_year,time����������������γ����γ����
%   grid_name_gldas_soil:����GLDAS�������õ�grid_data(soil)�����ļ�·��������grid_data,int_month,int_year,time����������������γ����γ
%   precipitation_name:�������ݣ�����precipitation,str_month,str_year,time����������������γ����γ(720*1440)
%   lg_msk_name:��Ĥ���ݣ���������������γ����γ
%   setAxis :������ķ�Χ����[2002 2018 -10 20]
%   �����ļ���������С��ͬ
%   dir_natidata:����ͳ�ƾֵ���ˮ����

%   ������γ����γ�ͱ�γ����γ���ַ��е����ݶ��У������ʹ�ú�������ʱ������ʱ����Ҫ���벻ͬ��ʽ��lg_msk��
%   �������뱣֤lg_msk��grid_data�ĸ�ʽ��ͬ��Ҫ�����Ǳ�γ����γ��Ҫ��������γ����γ

% region_acreage=16410;   %����ͳ�ƾ����������������赥�����ã���λkm^2
[time_series_gw,~,~,time_gw]=get_time_series_gw(grid_gw_name,lg_msk_name,'mask','month');%cm
[time_series_land,~,~,time_land]=get_time_series_GRACE_GLDAS(grid_name_gldas_land,lg_msk_name,'mask','GLDAS');%mm
[time_series_soil,~,~,time_soil]=get_time_series_GRACE_GLDAS(grid_name_gldas_soil,lg_msk_name,'mask','GLDAS');%mm
[time_series_tws,~,~,time_tws]=get_time_series_GRACE_GLDAS(grid_name_grace,lg_msk_name,'mask','GRACE');%m
% [time_series_prec,~,~,time_prec]=get_time_series_prec_trmm(precipitation_name,lg_msk_name,'mask');%mm
[time_series_prec,~,~,time_prec]=get_time_series_prec_gcpc(precipitation_name,lg_msk_name,'mask');%mm

% [time_series_natigw,time_natigw]=get_time_series_natidata(dir_natidata,region_acreage);%cm

 f=figure;
 title('�����е���ˮ�����뽵������չ����');
 yyaxis right%����������
 bar(time_prec,time_series_prec);%����״ͼ

 xlabel('��');
 ylabel('������(mm)');
 yyaxis left%����������
 hold on;

 plot(time_gw,time_series_gw,'-s','color','r','marker','none');%������ͼ
 plot(time_tws,time_series_tws*100,'-s','color','b','marker','none');
 plot(time_land,time_series_land/10,'-s','color','g','marker','none');
 plot(time_soil,time_series_soil/10,'-s','color','k','marker','none');
%  plot(time_natigw,time_series_natigw,'-s','color','c','marker','none');
%  plot(time_nati,time_series_nati);
%  grid on;
 legend('underground water','land water','surface water','soil water');
 ylabel('��Чˮ��(cm)');
 axis(setAxis);
 set(gca,'XTick',[setAxis(1):1:setAxis(2)]);
end


% �������ˮʱ��time_series,���ص����߽��ļ���.mat����grid_data�ļ�
%����ʱ������(��),��ȡgrid_data,lg_msk,�����ļ�����time_series,str_year,str_month,time(double)
function [time_series,str_year,str_month,time]=get_time_series_gw(grid_data_dir,lg_msk,type,data_type)
%   grid_data_dir, ��grace���ݽ��������grid_data���ݣ�gw��Чˮ�ߣ���ʽΪ��������������γ����γ�����ļ�·��
%   lg_msk,��Ĥ�ļ�·������Ϊbln��mat
%   type : bln�ļ�ѡ��line, mat�ļ�ѡ��mask
%   data_type:year��month
gw=load(grid_data_dir);
if(strcmp(data_type,'month'))
    grid_data=gw.grid_data;
    str_year=gw.str_year;
    str_month=gw.str_month;
    time=gw.time;
	time_series=gmt_grid2series(grid_data,lg_msk,type,89.875);
    for i=1:length(time_series)
        time(i)=str2double(gw.str_year(i,:))+str2double(gw.str_month(i,:))/12;
    end
end
end

% ����GRACE,GLDAS grid��������time_series
function [time_series,int_year,int_month,time]=get_time_series_GRACE_GLDAS(grid_data_dir,lg_msk,type,data_type)

%    grid_data_dir, grid_data���ݣ�GRACE����GLDAS��Чˮ�ߣ����ļ�·��
%    lg_msk,��Ĥ�ļ�·������Ϊbln��mat
%    type : bln�ļ�ѡ��line, mat�ļ�ѡ��mask
%    saveseries_filename,�����ļ�����·��
%    data_type:�������ͣ�GRACE��GLDAS

%    ������ݰ���time_series, int_year,int_month,time
%    lg_msk���ն�������������γ����γ����
%    GRACE ����(��������������γ����γ���У������� grid_data,str_year(cell��),str_month(cell��),time
%    GLDAS ���ݣ���������������γ����γ���У���תΪGRACE �е�grid_data��ʽ��������grid_data,int_month,int_year,radius_filter,time,type,destrip_method
filename=grid_data_dir;
if(strcmp(data_type,'GRACE'))
    data=load(filename);
    grid_data=data.grid_data;
    str_year=data.str_year;
    str_month=data.str_month;
    int_year=cell2double(str_year);
    int_month=cell2double(str_month);
    time_series=gmt_grid2series(grid_data,lg_msk,type,89.875);
    time=data.time;
end
if(strcmp(data_type,'GLDAS'))
    data=load(filename);
    grid_data_SN=data.grid_data;%GLDAS�����ǰ���γ����γ���еģ���Ҫת��Ϊgrid_data��ʽ
    grid_data=mask_convert_NS(grid_data_SN);%���·�ת
    int_month=data.int_month;
    int_year=data.int_year;
    time=data.time;
    time_series=gmt_grid2series(grid_data,lg_msk,type,89.875);
end
end

%   ����ˮ��������time_series
function [time_series,str_month,str_year,time]=get_time_series_prec_trmm(prec_name,lg_msk,type)
%   ��ˮ���ݳʶ�������������γ����γ���У����lg_msk������ͬ����������������γ����γ���У�
precipload=load(prec_name);
str_year=precipload.str_year;
str_month=precipload.str_month;
time=precipload.time;
precipSN=precipload.precipitation;
precipNS=mask_convert_NS(precipSN);   %����γ����γת��Ϊ��γ����γ
time_series=gmt_grid2series(precipNS,lg_msk,type,89.875);

end

function [time_series,str_month,str_year,time]=get_time_series_prec_gcpc(prec_name,lg_msk,type)
precipload=load(prec_name);
time_series=gmt_grid2series(precipload.PrecipData*30,lg_msk,type,90);
str_year=num2str(precipload.int_year);
str_month=num2str(precipload.int_month);
time=precipload.time;
end
%   ��ȡ����ˮ���ݲ������Чˮ�ߣ�����ͳ�ƾ֣�
function [time_series,time]=get_time_series_natidata(data_dir,region_acreage)
%       data_dir,����ͳ�ƾ�����txt�ļ����ڵ��ļ���,��'G:\����ͳ�ƾ�����\����\'

S=region_acreage;
filelist=dir(data_dir);
for i=3:length(filelist)
    filename(i-2,:)=fullfile(data_dir,filelist(i).name);
end
[k,~]=size(filename);
clear i;
for i1=1:k
    fid=fopen(filename(i1,:),'r');
    year_num=fgetl(fid);%��һ�д��������
    region=fgetl(fid);%�ڶ��д����������
    for j1=1:str2num(year_num)
        tline=fgetl(fid);
        data_tmp=strsplit(tline,',');
        year_data(j1,:)=data_tmp;
    end
    yeardata(:,:,i1)=year_data;%��������
    data_region(i1)=cellstr(region);
end

gw_yeardata=zeros(size(yeardata,1),2);%��һ��Ϊ��ݣ��ڶ���Ϊ�ܵ���ˮ����(�������ף�
for i=1:size(yeardata,1)
    str_year=cell2mat(yeardata(i,1,1));
    data_tmp=yeardata(i,2,:);%��ȡͬһ��ݲ�ͬ����������
    data_doub=cell2double(data_tmp);
    data_sum=sum(data_doub);
    gw_yeardata(i,1)=str2double(str_year);
    gw_yeardata(i,2)=data_sum;
end
%�������ˮ��
gwh=zeros(size(yeardata,1),2);%��һ��Ϊ��ݣ��ڶ���Ϊ�ܵ���ˮˮ�ߣ�cm��
gw_tmp=gw_yeardata(:,2);
gwh_tmp=100*gw_tmp*10^8./(S*10^6);%����Ϊcm
gwh(:,1)=gw_yeardata(:,1);
gwh(:,2)=gwh_tmp;

%�������ˮ�߱仯��
Delta_gwh=zeros(size(gwh));
gw_mean=mean(gwh(:,2));%
Delta_gwh(:,1)=gwh(:,1);
Delta_gwh(:,2)=gwh(:,2)-gw_mean;
time=Delta_gwh(:,1)';
time_series=Delta_gwh(:,2)';
end

