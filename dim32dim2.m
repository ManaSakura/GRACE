%��1*(lmax+1)*(lmax+1)����ά����ת��Ϊ(lmax+1)*(lmax+1)�Ķ�ά����
function dim2=dim32dim2(dim3)
[~,y,z]=size(dim3);
for i=1:y
    for j=1:z
        dim2(i,j)=dim3(1,i,j);
    end
end