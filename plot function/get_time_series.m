% �������ˮʱ��time_series,���ص����߽��ļ���.mat����grid_data�ļ�
%����ʱ������,��ȡgrid_data,lg_msk,�����ļ�����time_series,str_year,str_month,time(double)
function [time_series]=get_time_series(grid_data_dir,lg_msk,type,saveseries_filename,data_type)
%   grid_data_dir, ��grace���ݽ��������grid_data���ݣ�gw��Чˮ�ߣ���ʽΪ��������������γ����γ�����ļ�·��
%   lg_msk,��Ĥ�ļ�·������Ϊbln��mat
%   type : bln�ļ�ѡ��line, mat�ļ�ѡ��mask
%   saveseries_filename,�����ļ�����·��
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
    save(saveseries_filename,'time_series','str_year','str_month','time');
end

if(strcmp(data_type,'year'))
    grid_data=gw.grid_data;
    int_year=gw.int_year;
    time_series=gmt_grid2series(grid_data,lg_msk,type,89.5);
    save(saveseries_filename,'time_series','int_year');
end
disp('save time series successfully');

%%example
%%%%
% clear;clc;
% saveseries_filename='G:\Auxiliary function\result\time_series\year series\time_series_year_clm_hbpy';%cm
% lg_msk='G:\Auxiliary function\result\msk_file\huabei_msk.mat';
% grid_data_dir='G:\Auxiliary function\result\GW\grid_gw_year\grace_gldas_gw_year_clm_2002_2015';
% type='mask';
% data_type='year';
% [time_series]=get_time_series(grid_data_dir,lg_msk,type,saveseries_filename,data_type);