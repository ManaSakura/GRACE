%���ݹ���ͳ�ƾ����ݻ��Ƶ���ˮ������Чˮ��(cm)�仯ʱ������
function [time_series,time]=get_natidata_series(acreage,natidata_name)
%   acreage:��������������λ��km^2
%   natidata_name������ͳ�ƾ����ݣ�����read_naturaldata�����������ã�����·�����������У���һ��Ϊ��ݣ��ڶ���Ϊ����ˮ����
%
% gw_nationdata=load('G:\����ͳ�ƾ�����\����ˮ������\natudata_bj.mat');
S=acreage;
gw_nationdata=load(natidata_name);

yeardata=gw_nationdata.yeardata;
data_region=gw_nationdata.data_region;
%���㻪��ƽԭ�ܵ���ˮ������ͬ��ݣ�������ͳ�ƾ�����
gw_yeardata_hbpy=zeros(size(yeardata,1),2);%��һ��Ϊ��ݣ��ڶ���Ϊ�ܵ���ˮ����(�������ף�
for i=1:size(yeardata,1)
    str_year=cell2mat(yeardata(i,1,1));
    data_tmp=yeardata(i,2,:);%��ȡͬһ��ݲ�ͬ����������
    data_doub=cell2double(data_tmp);
    data_sum=sum(data_doub);
    gw_yeardata_hbpy(i,1)=str2double(str_year);
    gw_yeardata_hbpy(i,2)=data_sum;
end
%�������ˮ��
gwh=zeros(size(yeardata,1),2);%��һ��Ϊ��ݣ��ڶ���Ϊ�ܵ���ˮˮ�ߣ�cm��
gw_tmp=gw_yeardata_hbpy(:,2);
gwh_tmp=100*gw_tmp*10^8./(S*10^6);%����Ϊcm
gwh(:,1)=gw_yeardata_hbpy(:,1);
gwh(:,2)=gwh_tmp;

%�������ˮ�߱仯��
Delta_gwh=zeros(size(gwh));
gw_mean=mean(gwh(:,2));%
Delta_gwh(:,1)=gwh(:,1);
Delta_gwh(:,2)=gwh(:,2)-gw_mean;
time=Delta_gwh(:,1)';
time_series=Delta_gwh(:,2)';
% plot(time,time_series,'-s','marker','.','markersize',12);

