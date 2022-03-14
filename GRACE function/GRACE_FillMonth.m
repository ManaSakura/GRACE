function [ cs_insect,cs_sigma_insect,int_year_insect,int_month_insect,time_insect] = GRACE_FillMonth(cs,cs_sigma,int_year,int_month,time,lmax)
%��ȫGRACE��GRACE-FO�м�ȱʧ��11���·ݣ����õķ���Ϊȡ�����������ͬһ�·ݵ�ƽ��ֵ
% input:
%     cs:���ļ�ֱ�Ӷ�ȡ��cs����
%     cs_insect:����ȱʧ��11�·����ݺ��cs����
%     lmax:λϵ��������
%     int_year,int_month:n*1�ľ�����gmt_readgsm_GRACE_RL06�е�int_year,int_monthһ��

% output:
%       cs_insect��cs_sigma_insect:��ֵ���cs���ݡ�cs_sigma����
%       int_year_insect��int_month_insect:��ֵ�����ݺ��·ݣ�N*1�ľ���
missmonth=1:12;%ȱʧ�·�Ϊ2017.7-2018.5
missmonth(6)=[];

% int_year=cell2double(str_year);
% int_month=cell2double(str_month);

% cs_spline=zeros(11,lmax+1,lmax+1);
cs_mean=zeros(11,lmax+1,lmax+1);
cs_sigma_mean=zeros(11,lmax+1,lmax+1);
time_mean=zeros(11,1);
DOY=zeros(11,1);
for month=1:11
    [rowlist,~]=find(int_month==missmonth(month));
    yearlist=int_year(rowlist);
    cs_tmp=cs(rowlist,:,:);%��ȡָ���·ݵ���������
    cs_sigma_tmp=cs_sigma(rowlist,:,:);
    time_tmp=time(rowlist,:);
    
    cs_mean(month,:,:)=mean(cs_tmp,1);%1�µ�12�µ�λϵ��ƽ��ֵ������6�·ݲ��ò�ֵ������2017�������ݣ�7,8,9,10,11,12)
    %   2018�������ݣ�1,2,3,4,5)
    cs_sigma_mean(month,:,:)=mean(cs_sigma_tmp,1);
    
    %ֻ�ö�timeС��λ������գ�DOY��������ƽ������Ҫ��ȥ���
    timeint=fix(time_tmp);
    DOY_tmp=time_tmp-timeint;
    DOY(month,1)=mean(DOY_tmp);
end
%   ��cs_mean���ݰ�����ʱ��˳����������
cs_mean_tmp=cs_mean(6:11,:,:);%2017.07-2017.12
cs_mean_tmpp=cs_mean(1:5,:,:);%2018.01-2018.05
cs_mean1=cat(1,cs_mean_tmp,cs_mean_tmpp);


cs_sigma_mean_tmp=cs_sigma_mean(6:11,:,:);%2017.07-2017.12
cs_sigma_mean_tmpp=cs_sigma_mean(1:5,:,:);%2018.01-2018.05
cs_sigma_mean1=cat(1,cs_sigma_mean_tmp,cs_sigma_mean_tmpp);

DOY_tmp=DOY(6:11,1);%2017.07-2017.12
DOY_tmpp=DOY(1:5,1);%2018.01-2018.05
DOY1=[DOY_tmp;DOY_tmpp];

%   ��ȡ2017.6�µ��к�(row)�����ڲ�ֵ������λϵ��
year=2017;month=6;
[m1,~]=find(int_year==year);
[m2,~]=find(int_month==month);
row=intersect(m1,m2);

cs_tmp=cs(1:row,:,:);
cs_tmpp=cs(row+1:end,:,:);
cs_insect=cat(1,cs_tmp,cs_mean1,cs_tmpp);

cs_sigma_tmp=cs_sigma(1:row,:,:);
cs_sigma_tmpp=cs_sigma(row+1:end,:,:);
cs_sigma_insect=cat(1,cs_sigma_tmp,cs_sigma_mean1,cs_sigma_tmpp);

year1=[2017;2017;2017;2017;2017;2017;2018;2018;2018;2018;2018];%ȱʧ���
month1=[7;8;9;10;11;12;1;2;3;4;5];%ȱʧ�·�
time_mean1=year1+DOY1;

time_tmp=time(1:row,1);
time_tmpp=time(row+1:end,1);
time_insect=[time_tmp;time_mean1;time_tmpp];


int_year_insect=[int_year(1:row);year1;int_year(row+1:end)];
int_month_insect=[int_month(1:row);month1;int_month(row+1:end)];

end



