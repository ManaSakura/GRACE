%��(lmax+1)*(lmax+1)�Ķ�ά����ת��Ϊ1*(lmax+1)*(lmax+1)����ά����
function dim3=dim22dim3(dim2)
[y,z]=size(dim2);
for i=1:y
    for j=1:z
        dim3(1,i,j)=dim2(i,j);
    end
end