function Vert=dct10(R,T,n)

dct_R=T*R*T';
k=1;
nn=round((n*n+n)/2); %右上角选取多少个;
Vert=zeros(1,nn);
for i=1:n
    for j=1:n-i+1
        Vert(k)=dct_R(i,j);
        k=k+1;
    end
end


