%��ȡ�ļ����µ������ļ������ļ�����
function [filenames,file_num] = GetFiles(FolderName)
% filenames, �ļ����µ������ļ���
% file_num, �ļ�����
% FolderName,�ļ�����
files = dir(FolderName);
size0 = size(files);
length = size0(1);
names = files(3:length);
class_num = size(names);
file_num=class_num(1);
filenames=cell(file_num,1);
for i=1:file_num
    filenames(i,1)=cellstr(names(i).name);%��charתΪcell
end
end