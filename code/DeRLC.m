function I=DeRLC(S)

[M,~]=size(S);
num=1;
for i=1:M
    for j=1:S(i,2)
        I(1,num)=S(i,1);
        num=num+1;
    end
end
