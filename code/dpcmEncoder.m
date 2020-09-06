function [en,f1] = dpcmEncoder(f)
%   差分编码的编码主要过程

[m,n]=size(f);
num=m*n;%总的像素数量

f_pre=zeros(1,num);%预测信号
f_rec=zeros(1,num);%量化后重构的信号
e=zeros(1,num);%原始信号与预测信号的差值
en=zeros(1,num);%量化后的误差值

f_pre(1)=f(1);
f_pre(2)=f(1);
e(1)=0;
en(1)=0;
f_rec(1)=f(1);
f1=f(1);
for i=2:num
    if(i~=2)
        f_pre(i)=(f_rec(i-1)+f_rec(i-2))/2;
    end
    e(i)=f(i)-f_pre(i);
    en(i)=16*trunc((255+e(i))/16)-256+8;
    f_rec(i)=f_pre(i)+en(i);

end
%subplot(234);%预测信号值产生的图像
%result=reshape(f_pre,m,n);
%imshow(result,[]);
%title('预测信号构成的图像');
end