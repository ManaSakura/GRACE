%���Ƶ�������ˮ�仯ʱ��ͼ(һ�����ݣ������ݻ�������)
%��ȡ�ļ�Ϊget_time_series�������time_series�ļ�
function plot_time_series(time_series_dir,str_xlabel,str_ylabel,str_title,str_legend,data_type)
%    time_series_dir: ʱ�������ļ�·��,cm
%    ���������ƣ����������ƣ����⣬ͼ������
%    data_type:month��year

%time_series���ļ�����:time_series,str_month,str_year,time
if(strcmp(data_type,'month'))
    ts=load(time_series_dir);
    time_series=ts.time_series;
    time=ts.time;
    plot(time,time_series,'-s','marker','.','markersize',12);
    xlabel(str_xlabel);
    ylabel(str_ylabel);
    title(str_title);
    legend(str_legend);
    box on;
end
if(strcmp(data_type,'year'))
    ts=load(time_series_dir);
    time_series=ts.time_series;
    year=ts.int_year;
    plot(year,time_series,'-s','marker','.','markersize',12);
    xlabel(str_xlabel);
    ylabel(str_ylabel);
    title(str_title);    
    legend(str_legend);
    box on;
end