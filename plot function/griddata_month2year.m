%%% ������griddata_month�仯��������仯��,grid_dataΪ����ˮ������Чˮ����仯��,cm
function grid_data=griddata_month2year(grid_loaddir,save_dir)
%grid_loaddir:����ˮ�±仯��������grid��str_year,str_month,time
% save_dir='G:\Auxiliary function\result\GW\grid_gw_year\grace_gldas_gw_year_mosaic_2002_2015';
%month_data=load('G:\Auxiliary function\result\GW\grid_gw_month\grace_gldas_gw_mosaic_2002_2015.mat');
month_data=load(grid_loaddir);
grid_data1=month_data.grid_data;
[row,col,k]=size(grid_data1);
str_year=month_data.str_year;
st_year=str_year(1,:);
end_year=str_year(end,:);
int_year=str2double(st_year):1:str2double(end_year);
grid_data=zeros(row,col,length(int_year));
for i=1:k
    int_year1(i)=str2double(str_year(i,:));
end
for i=1:length(int_year)
    [~,n]=find(int_year1==int_year(i));
    grid_tmp=grid_data1(:,:,n(1):n(end));
    sum_tmp=sum(grid_tmp,3);
    grid_data(:,:,i)=sum_tmp;
end
save(save_dir,'grid_data','int_year');
clear;clc;
disp('save grid data successfully');

