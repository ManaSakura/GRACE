function [ cs_insect,cs_sgi_insect,int_year_insect,int_month_insect,time_insect] = GRACE_Spineinterp(cs,cs_sgi,int_year,int_month,time,lmax)
%��ȫGRACE��GRACE-FO�м�ȱʧ��11���·ݣ����õķ���Ϊ������������
% input:
%     cs:���ļ�ֱ�Ӷ�ȡ��cs����
%     cs_insect:����ȱʧ��11�·����ݺ��cs����
%     lmax:λϵ��������
%     int_year,int_month:n*1�ľ�����gmt_readgsm_GRACE_RL06�е�int_year,int_monthһ��

% output:
%       cs_insect��cs_sigma_insect:��ֵ���cs���ݡ�cs_sigma����
%       int_year_insect��int_month_insect:��ֵ�����ݺ��·ݣ�N*1�ľ���
% clear;clc;
% load('tmp.mat');
% lmax=60;
year_in=[2017;2017;2017;2017;2017;2017;2018;2018;2018;2018;2018];%ȱʧ���
month_in=[7;8;9;10;11;12;1;2;3;4;5];%ȱʧ�·�

%������������������ȱʧ�·ݵ�cs_in��cs_sigma_in
cs_in=zeros(11,lmax+1,lmax+1);
cs_sigma_in=zeros(11,lmax+1,lmax+1);
timef_in=zeros(11,1);%�����������������������ȱʧʱ�䣨time����С������
time_in=zeros(11,1);%�����������������������ȱʧʱ�䣨time��


for i=1:11
    [rowlist,~]=find(int_month==month_in(i));
%��ȡָ���·ݵ���������
    yearlist=int_year(rowlist);
    cs_tmp=cs(rowlist,:,:);
    cs_sigma_tmp=cs_sgi(rowlist,:,:);
    time_tmp=time(rowlist,:);
%�ж�time_tmp���Ƿ����ظ���ݲ�ȥ��
    year_tmp=num2str(fix(time_tmp));
    [year_ttmp,year_order]=unique(year_tmp,'rows','stable');%year_ttmpΪȥ�ظ�����year��year_orderΪȥ���ظ����year��year_tmp����λ��
    time_tmp=time_tmp(year_order);
    cs_tmp=cs_tmp(year_order,:,:);
    cs_sigma_tmp=cs_sigma_tmp(year_order,:,:);
%ֻ�ö�timeС��λ��������������������Ҫ��ȥ���
    timeint=fix(time_tmp);
    timefloat=time_tmp-timeint;
    timef_in(i)=spline(timeint,timefloat,year_in(i));
    time_in(i)=year_in(i)+timef_in(i);% ����ֵ��time
    cs_in_tmp=insect_cs(cs_tmp,lmax,time_tmp,time_in(i));
    cs_in(i,:,:)=cs_in_tmp;
    cs_sigma_in_tmp=insect_cs(cs_sigma_tmp,lmax,time_tmp,time_in(i));
    cs_sigma_in(i,:,:)=cs_sigma_in_tmp;
end


%   ��ȡ2017.6�µ��к�(row)�����ڲ�ֵ������λϵ��
iyear=2017;imonth=6;itime=2017.44109589041;
[m1,~]=find(int_year==iyear);
[m2,~]=find(int_month==imonth);
row=intersect(m1,m2);

cs_tmp=cs(1:row,:,:);
cs_tmpp=cs(row+1:end,:,:);
cs_insect=cat(1,cs_tmp,cs_in,cs_tmpp);

cs_sigma_tmp=cs_sgi(1:row,:,:);
cs_sigma_tmpp=cs_sgi(row+1:end,:,:);
cs_sgi_insect=cat(1,cs_sigma_tmp,cs_sigma_in,cs_sigma_tmpp);


time_tmp=time(1:row,1);
time_tmpp=time(row+1:end,1);
time_insect=[time_tmp;time_in;time_tmpp];


int_year_insect=[int_year(1:row);year_in;int_year(row+1:end)];
int_month_insect=[int_month(1:row);month_in;int_month(row+1:end)];

end

