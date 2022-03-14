%�������������Ϊ0.25ʱ��GRACE���ݴ������õ�grid_dataΪ721*1440�ľ���,GLDAS���ݵ�gridҲΪ721*1440�ľ��󣬸ú���Ҳ����0.25���GLDAS��grid
%��lg_msk����ľ���������ͬ��lg_msk�ľ���Ϊ720*1440
%���ǿ������øú���ͨ����ֵ����GRACE�������õ�721*1440������0-359.75��γ��90- -90���ľ���ת��Ϊ720*1440������0-359.75��γ�� 89.875- -89.875���ĸ�ʽ�ľ���
%�����ɵõ�720*1440�ľ��󣨶�������������γ����γ��
% grid_data_filepath='G:\GRACE_processing\hbpy2018_2021\grid_data_721_1440.mat';
% savepath='G:\GRACE_processing\hbpy2018_2021\grid_data_720_1440.mat';
% datatype='GRACE';
function new_grid_data=grid_data_721_2_720_vary(grid_data_filepath,savepath,datatype)
%   grid_data_filepath:grid_data���ļ�·��������grid_data,str_month,str_year,time
%%%   grid_data:721*1440�ľ���ΪGRACE_Matlab_Toolbox_preprocessing_core.m��������õľ���
%   new_grid_data:720*1440�ľ������ò�ֵת����ʽ��������GLDAS���ݣ�720*1440�����м���
%   ��ֵ�պ�Ϊ���ݵ��е㴦���ʿ�ȡƽ������Ҫ�õ�new_grid_data��0.125��N�����ݣ�ֻ�轫grid_data�е�0���0.25��N������ȡƽ�����ɣ���Ϊ�����߾������
%   savepath�����ɵ��µ�new_grid_data����·����������new_grid_data,str_month,str_year,time,��Ҫע�����new_grid_data�����Ѿ�������Ϊgrid_data
%   type:'GRACE','GLDAS','GW','GCPC'
if strcmp(datatype,'GRACE')||strcmp(datatype,'GW')
    load(grid_data_filepath);
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
    clear grid_data
    grid_data=new_grid_data;
    save(savepath,'grid_data','str_month','str_year','time');
    display('GRACE or GW grid_data has converted successfully');
end
if strcmp(datatype,'GLDAS')
    load(grid_data_filepath);
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
    clear grid_data
    grid_data=new_grid_data;
    save(savepath,'grid_data','int_month','int_year','time','radius_filter','type','destrip_method','-v7.3');
    display('GLDAS grid_data has converted successfully');
end
if strcmp(datatype,'GCPC')
    load(grid_data_filepath);
    grid_data=PrecipData;
    clear PrecipData;
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
    clear grid_data
    PrecipData=new_grid_data;
    save(savepath,'PrecipData','int_month','int_year','time','lon','lat','LON','LAT');
    display('GCPC grid_data has converted successfully');
end