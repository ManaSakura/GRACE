%��ȡ��python������graceԤ��ʱ������
clear;clc;
%filepath1����python�б����Ԥ��ֵ��excel��
%filepath2����grid_data���������ԭʼʱ������
%savepath���������ļ�������ɵ�����ݺ��ʱ��
% filepath1='G:\GRACE_processing\hbpy2002_2017\grace_2002_2017_predict.xls';
% filepath2='G:\GRACE_processing\hbpy2002_2021\time_series_grace.mat';
% savepath='G:\GRACE_processing\hbpy2002_2021\time_series_grace_ARIMA_2002_2021.mat';
filepath1='G:\GRACE_processing\bj\grace_2002_2017_bj_predict.xls';
filepath2='G:\GRACE_processing\bj\bj_grace_time_series_200204_202112.mat';
savepath='G:\GRACE_processing\bj\time_series_grace_bj_ARIMA_2002_2021.mat';
[data1,head1]=xlsread(filepath1);
data2=load(filepath2);
time1=data1(:,2);
time_series1=data1(:,3);%��λcm
time2=data2.time;
time_series2=data2.time_series*100;%����Ϊcm
insert_loc=163;
insert_time=time1(end-10:end);
insert_time_series=time_series1(end-10:end);
time=[time2(1:insert_loc);insert_time;time2(insert_loc+1:end)];
time_series=[time_series2(1:insert_loc);insert_time_series;time_series2(insert_loc+1:end)];
% save(savepath,'time_series','time');
figure;
plot(time2,time_series2,'-s');
title('2002-2021������½��ˮ������original��');
figure;
plot(time,time_series,'-s');
title('2002-2021������½��ˮ������ARIMA��');

