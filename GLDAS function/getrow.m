function row=getrow(int_month,int_year,year,month)
%   ����int_month,int_year�������year��month��������кţ�������
[m1,~]=find(int_year==year);
[m2,~]=find(int_month==month);
row=intersect(m1,m2);
end