%ת��lg_msk�����ұߣ�-180-180����������������0-360����������������ʽ��ת��,ͬ������grid_data���ݺ�gldas������
function newlg_msk=mask_convert(lg_msk)
[~,col]=size(lg_msk);
res=mod(col,2);
if(res==1)
    halfcol=(col-1)/2;
    msk_tmp=lg_msk(:,1:halfcol);
    newlg_msk=[lg_msk(:,halfcol+2:end) lg_msk(:,halfcol+1) msk_tmp];
end
if(res==0)
    halfcol=col/2;
    msk_tmp=lg_msk(:,1:halfcol);
    newlg_msk=[lg_msk(:,halfcol+1:end) msk_tmp];
end