% %��GRACE,GLDAS���ݼ���GW,��λcm,�����ļ�����grid_data,str_month,str_year,time
% �����grid_data�ǰ���������������γ����γ����
%GRACE ����(��������������γ����γ���У������� grid_data,str_year(cell��),str_month(cell��),time
%GLDAS ���ݣ���������������γ����γ���У���תΪGRACE �е�grid_data��ʽ��������grid_data,int_month,int_year,radius_filter,time,type,destrip_method
%GRACE��GLDAS��0.25�����ݶ�Ϊ721*1440��ʽ������������������ݼ��������gwҲΪ721*1440��ʽ��
function grace_gldas_gw(grace_dir,gldas_dir,gw_savedir)
%   grace_dir: GRACE���ݴ����ĵ�Чˮ�ߣ�½��ˮ
%   gldas_dir: GLDAS���ݴ����ĵ�Чˮ�ߣ��ر�ˮ
% clc;clear;
% save_dir= 'G:\result\GW\grid_gw month_025\grace_gldas_gw_noah025_2002_2015.mat';
% gldas_id=load('G:\result\GLDAS\NOAH025\grid_swenson_300_land_GLDAS_NOAH025_025_200001_202102');%clm dat
% grace_id=load('G:\result\GRACE\GRACE025\grid_data_025_leakagefree');%m

save_dir=gw_savedir;
gldas_id=load(gldas_dir);
grace_id=load(grace_dir);

% %�������ˮ
grid_gldas=getfield(gldas_id,'grid_data');%gldas,mm
grid_gldas=mask_convert_NS(grid_gldas);%������γ��γ
gldas_year_month=[getfield(gldas_id,'int_year') getfield(gldas_id,'int_month')];
grid_grace=getfield(grace_id,'grid_data');%grace,m
grace_year_month=[ str2num(cell2mat(getfield(grace_id,'str_year')')) str2num(cell2mat(getfield(grace_id,'str_month')')) ];

%��ȡ����grid�����е���ͬ���·ݲ���ȡ���������е��������ڶ���Ϊgrace�е��кţ�������Ϊgldas�е��к�
time_row=read_year_month(grace_year_month,gldas_year_month);
[k,~]=size(time_row);
for i=1:k
    row1=time_row(i,2);
    row2=time_row(i,3);
    grid_data(:,:,i)=grid_grace(:,:,row1)*100-grid_gldas(:,:,row2)/10;%units,cm
end
strtime=num2str(time_row(:,1));
str_year=strtime(:,1:4);
str_month=strtime(:,5:6);
for i=1:length(str_year)
    time(i)=str2double(str_year(i,:))+str2double(str_month(i,:))/12;
end
save(save_dir,'grid_data','str_year','str_month','time');

clear;clc;
disp(['Save grid_gw successfully.']);