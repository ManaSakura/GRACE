clear;clc;
% slCharacterEncoding('UTF-8');%��ʾ����
% city_shp_path='G:\����\��.shp';
city_shp_path='G:\����\��.shp';
% shp_savepath='G:\GRACE_processing\bj\beijing.shp';
shp_savepath='G:\GRACE_processing\bj\beijing_xian.shp';
city_shp=shaperead(city_shp_path);
bj_shp=city_shp(1:16);
shapewrite(bj_shp,shp_savepath);