%��ȡ����ʱ�������ص���ʱ�估���ڸ��Ծ�����к�
function time_row=read_year_month(year_month_1,year_month_2)
%year_month_1,year_month_2��double���ͣ���һ��Ϊ�꣬�ڶ���Ϊ��
%time_row����һ��Ϊ���£��ڶ���Ϊ��year_month_1�е��кţ�������Ϊ��year_month_2�е��к�
[k1,~]=size(year_month_1);
[k2,~]=size(year_month_2);
imin=min(k1,k2);
str1=[num2str(year_month_1(:,1)) num2str(year_month_1(:,2))];
str2=[num2str(year_month_2(:,1)) num2str(year_month_2(:,2))];

for i=1:k1
    str_tmp=str1(i,:);
    row1=i;
    for j=1:k2
    if(strcmp(str_tmp,str2(j,:)))
        strtime(i,:)=str_tmp;
        row2=j;
        row1_2(i,:)=[i j];
    end
    end
end
for i=1:length(strtime)
    strtime(i,:)=strrep(strtime(i,:),char(32),'0');
end
[m,~]=size(row1_2);
for i=1:m
        time_tmp=str2double(strtime(i,:));
        row1=row1_2(i,1);
        row2=row1_2(i,2);
        time_row(i,:)=[time_tmp,row1,row2];
end