function frac_R=fractalDecode(RRR,size1,n)

xx=size1(2);%图像横轴像素列数
yy=size1(1);%图像纵轴像素行数
nrx=xx/8;%将原始图像划分成8*8的像素矩阵
nry=yy/8;%将原始图像划分成8*8的像素矩阵
ndx=xx/16;%将定义域划分成16*16的像素矩阵
ndy=yy/16;%将定义域划分成16*16的像素矩阵

frac_R=ones(yy,xx);    %回复原图像
for iter=1:n
    for i=1:nry
        for j=1:nrx
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