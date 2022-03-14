%% ������Ĥ����(mask)
% % % % % % % %
clear;clc;
shp_China_name='G:\����\ʡ.shp';
% shp=shaperead(shp_China_name);
% %��������򡢺ӱ���ɽ�������ϡ����ա����յı߽��ļ���.mat�ļ�����bln��ʽ��ͬ��
% boundary_bj_dir='G:\Auxiliary function\result\boundary\beijing.mat';
% boundary_tj_dir='G:\Auxiliary function\result\boundary\tianjin.mat';
% boundary_hb_dir='G:\Auxiliary function\result\boundary\hebei.mat';
% boundary_sd_dir='G:\Auxiliary function\result\boundary\shandong.mat';
% boundary_hn_dir='G:\Auxiliary function\result\boundary\henan.mat';
% boundary_ah_dir='G:\Auxiliary function\result\boundary\anhui.mat';
% boundary_js_dir='G:\Auxiliary function\result\boundary\jiangsu.mat';


%����ƽԭһ��ͨ���ǰ�����������򡢺ӱ���ɽ�������ϡ����ա�������7ʡ��
%��shp�ļ�����mat�ļ�,�������Ӧ��mask
shp_beijing=shp(1);
shp_tianjin=shp(2);
shp_hebei=shp(3);
shp_shandong=shp(16);
shp_henan=shp(17);
shp_anhui=shp(13);
shp_jiangsu=shp(11);
%xx_mskΪ��Ĥ���ݣ���shp2mask����ĸ�ʽ��Ϊ������������ʽ
bj_msk=shp2mask(shp_beijing,boundary_bj_dir,720,1440);
tj_msk=shp2mask(shp_tianjin,boundary_tj_dir,720,1440);
hb_msk=shp2mask(shp_hebei,boundary_hb_dir,720,1440);
sd_msk=shp2mask(shp_shandong,boundary_sd_dir,720,1440);
hn_msk=shp2mask(shp_henan,boundary_hn_dir,720,1440);
ah_msk=shp2mask(shp_anhui,boundary_ah_dir,720,1440);
js_msk=shp2mask(shp_jiangsu,boundary_js_dir,720,1440);
%��������������mask
hbpy_msk_720_1440=bj_msk+tj_msk+hb_msk+sd_msk+hn_msk+ah_msk+js_msk;%��������ƽԭ��Ĥ����(mask)������
lg_msk=mask_convert(hbpy_msk_720_1440);%ת��Ϊ0-360��ʽ�����뱣֤��grid_data��ʽ��ͬ
save_dir_hbpymsk='G:\Auxiliary function\result\msk_file\huabei_msk_720_1440.mat';
save(save_dir_hbpymsk,'lg_msk');
disp('save successfully');
clear;clc;

%����������mask
clear;clc;
shp_China_name='G:\����\ʡ.shp';
shp=shaperead(shp_China_name);
shp_beijing=shp(1);
boundary_bj_dir='G:\Data\boundary\beijing.mat';
bj_msk_180_360=shp2mask(shp_beijing,boundary_bj_dir,180,360);
lg_msk=mask_convert(bj_msk_180_360);%ת��Ϊ0-360��ʽ�����뱣֤��grid_data��ʽ��ͬ
savedir_bj_msk='G:\Data\msk_file\bj_msk_180_360.mat';
save(savedir_bj_msk,'lg_msk');
disp('save successfully');