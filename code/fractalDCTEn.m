function frac_R=fractalDCTEn(R,size1,Tp)


xx=size1(2);%图像横轴像素列数
yy=size1(1);%图像纵轴像素行数
nrx=xx/8;%R块划分
nry=yy/8;%R块划分
ndx=xx/16;%D块划分
ndy=yy/16;%D块划分
fp=zeros(nrx,nry);
% 建立8*8的DCT变换矩阵
T=dctmtx(8); %YUV'=T×YUV×T’
t1=clock;

R=R-128;
for i=1:nrx   
        for j=1:nry
            u=i*8-7;
            v=j*8-7;
%             DCT变换
            fp(i,j)=psnrsingle(R(u:u+7,v:v+7));
            dRR(u:u+7,v:v+7)=T*R(u:u+7,v:v+7)*T';
        end;
end;
outp=ThresholdJudge(fp,Tp);
out=1-outp;

for i=1:ndx
    for j=1:ndy
            %取定义域图像（原始图像）中16*16的像素矩阵
            cund1=R(1+16*(i-1):16+16*(i-1),1+16*(j-1):16+16*(j-1));
           %四领域平均采样
            for l=1:8
                for m=1:8
                    cund2(l,m)=(cund1(1+2*(l-1),1+2*(m-1))+cund1(2+2*(l-1),2+2*(m-1))+cund1(2+2*(l-1),1+2*(m-1))+cund1(1+2*(l-1),2+2*(m-1)))/4;
                end;
            end;
%         end;

        %对cund2做0度旋转
        DD(i,j,1,1:64)=reshape(cund2,[1,64]);%将cund2按列重新排列成一行
        cund4=fliplr(cund2);%将cund2矩阵左右翻转，相当于矩阵水平中线反射
        DD(i,j,2,1:64)=reshape(cund4,[1,64]);
        cund4=flipud(cund2);%将cund2矩阵上下翻转，相当于矩阵垂直中线反射
        DD(i,j,3,1:64)=reshape(cund4,[1,64]);
        cund4=flipud(fliplr(cund2));%将矩阵左右翻转后上下翻转，相当于180度旋转
        DD(i,j,4,1:64)=reshape(cund4,[1,64]);
        cund4=rot90(flipud(cund2));%矩阵相对135度反射
        DD(i,j,5,1:64)=reshape(cund4,[1,64]);
        cund4=rot90(cund2);%矩阵90度旋转
        DD(i,j,6,1:64)=reshape(cund4,[1,64]);
        cund4=rot90(rot90(rot90(cund2)));%矩阵270度旋转
        DD(i,j,7,1:64)=reshape(cund4,[1,64]);
        cund4=cund2';%矩阵相对45度反射
        DD(i,j,8,1:64)=reshape(cund4,[1,64]);
    end;
end;

for i=1:nrx%这两个循环（i和j）保证了对于每个值域块都找到了相应的定义域块，并且求出了该定义域块
    for j=1:nry%得一系列变换过程
        %将值域块8*8的像素值重新排列成一列，放到cunr
        if out(i,j)~= 0
        cunr=reshape(R(1+8*(i-1):8+8*(i-1),1+8*(j-1):8+8*(j-1)),[1,64]);
        sumalpha=sum(cunr);   %cunr  is ri（值域块的值）
        sumalpha2=norm(cunr)^2;%cunr中各个数值的平方（即向量2范数的平方），相当于求值域块矩阵每个元素的平方再求和
        dx=1;%这几个变量就是分形编码的数据量，他们的初值可以随意定。记录l的值
        dy=1;%记录k的值
        ut=1;%记录m的值
        minH=10^20;%记录最小的均方根误差R值
        minot=0;%参数minot记录下与当前值域块能够最佳匹配的定义域块下变换所需的亮度调节
        minst=0;%参数minst记录下与当前值域块能够最佳匹配的定义域块下变换所需的对比度调节
        for k=1:ndx%参数k与l记录下与当前值域块能够最佳匹配的定义域块的序号
            for l=1:ndy%
                for m=1:8%参数m记录下与当前值域块能够最佳匹配的定义域块得8种基本变形的序号
                    cund3(1:64)=DD(k,l,m,1:64);
                    sumbeta=sum(cund3);  % cund3 is di（定义域块的值）
                    sumbeta2=norm(cund3)^2;%求出向量的2范数，相当于定义域块矩阵的每个元素的平方再求和
                    alphabeta=cunr*cund3';%相当于。。。
                    if (64*sumbeta2-sumbeta^2)~=0
                    st=(64*alphabeta-sumalpha*sumbeta)/(64*sumbeta2-sumbeta^2);%st即是对比度调节系数s
                    elseif (64*alphabeta-sumalpha*sumbeta)==0||st > 1 || st < -1
                        st=0;
                    else
                        st=10^20;
                    end;
                    ot=(sumalpha-st*sumbeta)/64;%ot即使亮度调节系数
                    H=(sumalpha2+st*(st*sumbeta2-2*alphabeta+2*ot*sumbeta)+ot*(64*ot-2*sumalpha))/64;%在当前s与o的条件下的R             
                    if H<minH%寻求定义域块与值域块的最佳匹配，并记录下最佳匹配的参数值
                        dx=l;
                        dy=k;
                        ut=m;
                        minot=ot;
                        minst=st;
                        minH=H;
                    end;
                end;
            end;
        end;
        RRR(i,j,1)=minst;
        RRR(i,j,2)=minot;
        RRR(i,j,3)=dy;
        RRR(i,j,4)=dx;
        RRR(i,j,5)=ut;
        RRR(i,j,6)=minH;
        else
            RRR(i,j,7)=dRR(i*8-7,j*8-7);
%             RRR(i,j,8)=dRR(i*8-7+1,j*8-7);
%             RRR(i,j,9)=dRR(i*8-7+1,j*8-7+1);
        end;        
    end;
end;

frac_R=zeros(xx,yy);
for i=1:nry
    for j=1:nrx 
        if RRR(i,j,7)~=0
            frac_R(i*8-7,j*8-7)=RRR(i,j,7);
%             frac_R(i*8-7+1,j*8-7)=RRR(i,j,8);
%             frac_R(i*8-7,j*8-7+1)=RRR(i,j,8);
        end;
    end;
end;
frac_R =blkproc(frac_R,[8 8],'P1*x*P2',T',T);


for iter=1:10
    for i=1:nry
        for j=1:nrx
            if  out(i,j)~=0
            st=RRR(i,j,1);
            ot=RRR(i,j,2);
            dy=RRR(i,j,3); %
            dx=RRR(i,j,4); %
            ut=RRR(i,j,5); %等距变换
            cund1=frac_R(1+16*(dy-1):16+16*(dy-1),1+16*(dx-1):16+16*(dx-1));
            for l=1:8
                for m=1:8
                    cund2(l,m)=(cund1(1+2*(l-1),1+2*(m-1))+cund1(2+2*(l-1),2+2*(m-1))+cund1(2+2*(l-1),1+2*(m-1))+cund1(1+2*(l-1),2+2*(m-1)))/4;
                end;
            end;
            switch ut
                case 1 
                    cund4=cund2;
                case 2 
                    cund4=fliplr(cund2);
                case 3 
                    cund4=flipud(cund2);
                case 4 
                    cund4=flipud(fliplr(cund2));             
                case 5 
                    cund4=rot90(flipud(cund2));               
                case 6 
                    cund4=rot90(cund2);            
                case 7 
                    cund4=rot90(rot90(rot90(cund2)));
                case 8 
                    cund4=cund2';
            end;
            frac_R(1+8*(i-1):8+8*(i-1),1+8*(j-1):8+8*(j-1))=st*cund4+ot;
            end;
        end;
    end;
end;
frac_R = uint8(frac_R+128);

end
