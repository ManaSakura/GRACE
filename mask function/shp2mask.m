%����shp�ļ�����lg_msk(mask�ļ�)�����ȷ�Χ-180-180��0-180��Ϊ������181-360��Ϊ������,����ʱ��ת��Ϊ0-360��1-180��Ϊ������181-360��Ϊ������
function lg_msk=shp2mask(shp,boundary_savename,row,col)
%shp:shapefile
%boundary_savename:�߽��������ļ�����bln��ʽ��ͬ
%row,col����������Ĥ���ݵ�������
%XΪ����(��Ϊ��������Ϊ����)��YΪγ��(��Ϊ��γ����Ϊ��γ��
lon_lat=[shp.X',shp.Y'];
[m,n]=find(isnan(lon_lat));
lon_lat(m,:)=[];
a=length(lon_lat);
mat_tmp=zeros(a+1,2);
mat_tmp(1,1)=a;
mat_tmp(1,2)=nan;
Boundary=[mat_tmp(1,:); lon_lat];%��������ΪBoundary��������ļ����Ե�������
% save('G:\Auxiliary function\result\boundary\beijing.mat','Boundary');
save(boundary_savename,'Boundary');
disp('save boundary point successfully');
%��ȡ�߽羭γ����Ϣ(.mat�ļ�)����һ��Ϊ��������һ��Ϊ���ȣ��ڶ���Ϊγ�ȣ�bln�ļ���ʱδ������
[lg_msk] = make_mask(boundary_savename,'mat',row,col);
