%���ļ����е�ͼƬ��������gif
clear;clc;
filename='demo.gif';
foldername='hbpy GW';
[filenames,file_num] = GetFiles(foldername);

for i=1:length(filenames)  %ͼ�����и���
    fname=cell2mat(fullfile(foldername,filenames(i)));
    im = imread(fname);
    [imind,cm]=rgb2ind(im,256);
    if i==1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end
