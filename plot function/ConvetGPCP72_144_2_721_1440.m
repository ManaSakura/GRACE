function ConvetGPCP72_144_2_721_1440(filepath,savepath)
%   ��read_GPCP4Precip(datadir,savedir)������ȡ��mat�ļ�ת��Ϊgrid_data���ͣ�721*1440����������������γ����γ�������÷���Ϊ������ֵ��'cubic'��
%   filepath��read_GPCP4Precip������ȡ���Ľ��������������mat�ļ����ļ�·��
%   savepath��ת����721*1440mat�ļ��ı���·����grid_data���ͣ�721*1440����������������γ����γ����
% filepath='G:\Data\GPCP_Precip_mat\GCPC_72_144_2.5_2002.mat';
% savepath='G:\Data\GPCP_Precip_mat\GCPC_721_1440_2.5_2002.mat';
load(filepath);
lon_interp=0:0.25:359.75;
lat_interp=[90:-0.25:-90]';
for i=1:length(time)
lon=longitude(i,:);
lat=latitude(i,:)';
p1=PrecipData(:,:,i);
% p1_col=reshape(p1,[],1);
[LON,LAT]=meshgrid(lon,lat);
[LON_interp,LAT_interp]=meshgrid(lon_interp,lat_interp);
p1_interp=interp2(lon,lat,p1,lon_interp,lat_interp,'cubic');
% f1=figure;
% surf(LON,LAT,p1);
% f2=figure;
% meshz(LON,LAT,p1);
% f3=figure;
% meshz(LON_interp,LAT_interp,p1_interp);
p1_interp(isnan(p1_interp)==1)=0;
precip(:,:,i)=p1_interp;
end
clear lon lat LON LAT PrecipData;
lon=lon_interp;
lat=lat_interp;
LON=LON_interp;
LAT=LAT_interp;
PrecipData=precip;
save(savepath,'PrecipData','time','lon','lat','LON','LAT','int_month','int_year');
display(strcat(savepath,'has saved successfully'));