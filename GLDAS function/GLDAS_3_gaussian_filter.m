%%���и�˹�˲�����Do Gaussian_filter
function GLDAS_3_gaussian_filter(cs_readname,cs_savename)
%cs_readname:gldas��������תΪcs�����ݴ洢·��������cs_soil,cs_land
%cs_savename:��˹�˲�������cs�������������·��
radius_filter=300;
cs=load(cs_readname);
save_dir=cs_savename;
land_swenson=cs.cs_land;
soil_swenson=cs.cs_soil;

% [num_file,n]=size(file_name(:,1));
cs_land=gmt_gaussian_filter(land_swenson,radius_filter);
cs_soil=gmt_gaussian_filter(soil_swenson,radius_filter);


int_year=cs.int_year;
int_month=cs.int_month;
time=cs.time;

save(save_dir,'cs_land');
save(save_dir,'cs_soil','-append');
save(save_dir,'int_year','-append');
save(save_dir,'int_month','-append');
save(save_dir,'time','-append');
save(save_dir,'radius_filter','-append');

clear
clc
disp(['Save cs_gaussian_filter.mat successfully.']);


