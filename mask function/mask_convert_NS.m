%ת�����ݵ����±ߣ��ϱ�γ������GLDAS���ݶ�ȡ����Ϊ��Ϊ��γ����Ϊ��γ,��ת��Ϊgrid_data��ʽ��,ͬ������grid_data���ݺ�lg_msk������
%���ڳ������Գ�
function new_msk=mask_convert_NS(lg_msk)
if ndims(lg_msk)==2
new_msk=flipud(lg_msk);
end
if ndims(lg_msk)==3
    [~,~,kk]=size(lg_msk);
    new_msk=zeros(size(lg_msk));
    for i=1:kk
        msk_tmp=lg_msk(:,:,i);
        new_msk_tmp=flipud(msk_tmp);
        new_msk(:,:,i)=new_msk_tmp;
    end
end

