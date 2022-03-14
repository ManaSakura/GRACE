%��ȡtxt�ļ���ʽ�Ĺ���ͳ�ƾ����ݣ��꣩��ת��Ϊmat�ļ�
function read_naturaldata(data_dir,save_filename)
%         data_dir,txt�ļ����ڵ��ļ���
%         save_filename:����mat�ļ�������·�������ļ�����yeardata,data_region��������,��Ϊcell���ʹ���
% data_dir='G:\����ͳ�ƾ�����\����ˮ��Դ��\';
%save_filename='G:\����ͳ�ƾ�����\����ˮ������\gw_yeardata.mat';
filelist=dir(data_dir);
for i=3:length(filelist)
    filename(i-2,:)=fullfile(data_dir,filelist(i).name);
end
[k,~]=size(filename);
clear i;
for i1=1:k
    fid=fopen(filename(i1,:),'r');
    year_num=fgetl(fid);%��һ�д��������
    region=fgetl(fid);%�ڶ��д����������
    for j1=1:str2num(year_num)
        tline=fgetl(fid);
        data_tmp=strsplit(tline,',');
        year_data(j1,:)=data_tmp;
    end
    yeardata(:,:,i1)=year_data;
    data_region(i1)=cellstr(region);
end

save(save_filename,'yeardata','data_region');
disp('save natural data successfully');