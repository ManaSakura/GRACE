%�������������Ϊ0.25ʱ��GRACE���ݴ������õ�grid_dataΪ721*1440�ľ���,GLDAS���ݵ�gridҲΪ721*1440�ľ��󣬸ú���Ҳ����0.25���GLDAS��grid
%��GLDAS����ľ���������ͬ��GLDAS�ľ���Ϊ720*1440��
%���ǿ������øú���ͨ����ֵ����GRACE�������õ�721*1440������0-359.75��γ��90- -90���ľ���ת��Ϊ720*1440������0-359.75��γ�� 89.875- -89.875���ĸ�ʽ�ľ���
%�����ɵõ�720*1440�ľ��󣨶�������������γ����γ��

function new_grid_data=grid_data_721_2_720(grid_data)
%   grid_data:721*1440�ľ���ΪGRACE_Matlab_Toolbox_preprocessing_core.m��������õľ���
%   new_grid_data:720*1440�ľ������ò�ֵת����ʽ��������GLDAS���ݣ�720*1440�����м���
%   ��ֵ�պ�Ϊ���ݵ��е㴦���ʿ�ȡƽ������Ҫ�õ�new_grid_data��0.125��N�����ݣ�ֻ�轫grid_data�е�0���0.25��N������ȡƽ�����ɣ���Ϊ�����߾������
w=ndims(grid_data);
if(w==2)
    for i=1:720
        grid_row1=grid_data(i,:);
        grid_row2=gird_data(i+1,:);
        grid_row_tmp=(grid_row1+grid_row2)/2;
        new_grid_data(i,:)=grid_row_tmp;
    end
end

if(w==3)
    for k=1:size(grid_data,3)
        for i=1:720
            grid_row1=grid_data(i,:,k);
            grid_row2=grid_data(i+1,:,k);
            grid_row_tmp=(grid_row1+grid_row2)/2;
            new_grid_data(i,:,k)=grid_row_tmp;
        end
    end
end