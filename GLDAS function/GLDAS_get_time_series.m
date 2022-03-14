function GLDAS_get_time_series(grid_data_dir,lg_msk,type,saveseries_filename,data_type)
% ����GRACE,GLDAS grid���ݳ�Ϊtime_series����λm��

%    grid_data_dir, grid_data���ݣ�gw��Чˮ�ߣ����ļ�·����������Զ����ɵĸ�ʽ
%    lg_msk,��Ĥ�ļ�·������Ϊbln��mat
%    type : bln�ļ�ѡ��line, mat�ļ�ѡ��mask
%    saveseries_filename,�����ļ�����·��
%    data_type:�������ͣ�GRACE��GLDAS

%    ������ݰ���time_series, int_year,int_month,time
%    lg_msk���ն�������������γ����γ����
%GRACE ����(��������������γ����γ���У������� grid_data,str_year(cell��),str_month(cell��),time
%GLDAS ���ݣ���������������γ����γ���У���תΪGRACE �е�grid_data��ʽ��������grid_data,int_month,int_year,radius_filter,time,type,destrip_method
filename=grid_data_dir;
if(strcmp(data_type,'GRACE'))
    data=load(filename);
    grid_data=data.grid_data;
    str_year=data.str_year;
    str_month=data.str_month;
    int_year=cell2double(str_year);
    int_month=cell2double(str_month);
    time_series=gmt_grid2series(grid_data,lg_msk,type,89.5);
    time=data.time;
    save(saveseries_filename,'time_series','int_year','int_month','time');
end
if(strcmp(data_type,'GLDAS'))
    data=load(filename);
    grid_data_SN=data.grid_data;%GLDAS�����ǰ���γ����γ���еģ���Ҫת��Ϊgrid_data��ʽ
    grid_data=mask_convert_NS(grid_data_SN);
    int_month=data.int_month;
    int_year=data.int_year;
    time=data.time;
    time_series=gmt_grid2series(grid_data,lg_msk,type,89.5);
    save(saveseries_filename,'time_series','int_year','int_month','time');
end

disp('save time series successfully');