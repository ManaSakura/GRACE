%��ʱ�����б���Ϊexcel�ļ�
clear;clc;
filepath='G:\GRACE_processing\bj\time_series_grace_2002_2017_bj_original.mat';
savepath='G:\GRACE_processing\bj\time_series_grace_2002_2017_bj_original.xls';
load(filepath);
time_series_save=cat(2,time,time_series*100);
title={'ʱ��','��Чˮ��(cm)'};
xlswrite(savepath,title,1,'A1');
xlswrite(savepath,time_series_save,1,'A2');
display('xls has saved successfully');
