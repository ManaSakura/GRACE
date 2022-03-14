% hdf�ļ��е������ǰ��������������У���ȡhdf�ļ������еĽ�ˮ���ݣ�mm/hr��
% ���Ϊmat�ļ�������������������γ����γ����,720*1440�ľ���
% ���precipitation ��mm/hr����ת��Ϊ��ˮ��ʱ�����24h*���µ�����
function [precipitation,time,str_year,str_month]=read_TRMM_3B43(file_folder)
%   file_foilder:  �������ڵ��ļ�����

% ��ȡ3B43�������ݣ�1440*400����50��S~50��N, 180��W~180��E, 0.25*0.25
% file_folder='G:\Data\TRMM\3B43\';
% save_dir='G:\Auxiliary function\result\TRMM\';
[filelists,file_num] = GetFiles(file_folder);
for k=1:file_num
    filename=[file_folder cell2mat(filelists(k))];
    tmp=cell2mat(filelists(k));
    str_year(k,:)=tmp(6:9);
    str_month(k,:)=tmp(10:11);
    str_day(k,:)=tmp(12:13);
    days=gmt_get_days(str2double(tmp(6:9)),str2double(tmp(10:11)),str2double(tmp(12:13)));
    if(mod(str2double(tmp(6:9)),4)==0)%����
        time_tmp=days/366+str2double(tmp(6:9));
    end
    if(mod(str2double(tmp(6:9)),4)~=0)%������
        time_tmp=days/365+str2double(tmp(6:9));
    end
    time(k)=time_tmp;
    precip = permute(hdfread(filename,'precipitation'),[2 1]);%�൱��ת�ã�תΪ��ͼ��γ������������
    precip(precip < 0) = 0;
    precipitation(:,:,k)=precip;
end

% % ��ȫγ����Ϣ����ת��Ϊ������������ʽ,0.25*0.25

nan_data=zeros(160,1440,file_num);%γ�ȴ���50û������
precipitation=[nan_data;precipitation;nan_data];
%������:������ʽ��Ϊ������������ʽ��grid_data��ʽ��
precip_tmpp=zeros(size(precipitation));
for i=1:file_num
    precip_tmp=mask_convert(precipitation(:,:,i));
    precip_tmpp(:,:,i)=precip_tmp;
end
precipitation=precip_tmpp;