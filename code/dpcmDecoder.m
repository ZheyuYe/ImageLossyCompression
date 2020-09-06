function [ f_rec] = dpcmDecoder(en,f1)
%my_dpcmDecoder
% 差分编码的解码过程
[m,n]=size(en);
num=m*n;
f_pre=zeros(1,num);%预测信号
f_rec=zeros(1,num);%量化后重构的信号

f_rec(1)=f1;%f1为编码器端得到的f_rec(1)
f_pre(1)=f1;
f_pre(2)=f1;

for i=2:num
    if(i~=2)
        f_pre(i)=(f_rec(i-1)+f_rec(i-2))/2;
    end
    f_rec(i)=f_pre(i)+en(i);
end

end