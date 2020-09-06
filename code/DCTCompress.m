function [filename]= DCTCompress(RGB,n)
%进行彩色图像的DCT变换
%  返回重构的图像
%亮度量化表
m0 = ones(8);
mask0 = ones(8);
m1=[ 16	11	10	16	24	40	51	61;
    12	12	14	19	26	58	60	55;
    14	13	16	24	40	57	69	56;
    14	17	22	29	51	87	80	62;
    18	22	37	56	68	109	103	77;
    24	35	55	64	81	104	113	92;
    49	64	78	87	103	121	120	101;
    72	92	95	98	112	100	103	99];

m2=[ 17	18	24	47	99	99	99	99;
    18	21	26	66	99	99	99	99;
    24	26	56	99	99	99	99	99;
    47	66	99	99	99	99	99	99;
    99	99	99	99	99	99	99	99;
    99	99	99	99	99	99	99	99;
    99	99	99	99	99	99	99	99;
    99	99	99	99	99	99	99	99];
 mask1=[1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0]; 
 mask2=[1 1 1 0 0 0 0 0
        1 1 0 0 0 0 0 0
        1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0]; 
          
 mask3=[1 1 1 1 0 0 0 0
              1 1 1 0 0 0 0 0
              1 1 0 0 0 0 0 0
              1 0 0 0 0 0 0 0
              0 0 0 0 0 0 0 0
              0 0 0 0 0 0 0 0
              0 0 0 0 0 0 0 0
              0 0 0 0 0 0 0 0];
save('mask.mat','mask0');
save('mask.mat','mask1','-append');
save('mask.mat','mask2','-append');
save('mask.mat','mask3','-append');
save('mask.mat','m0','-append');
save('mask.mat','m1','-append');
save('mask.mat','m2','-append');

YUV=RGB2YUV(RGB);
% YUV=RGB;
%YUV图分层处理  得到3个分量图
 Y = double(YUV(:,:,1));
 U = double(YUV(:,:,2));
 V = double(YUV(:,:,3));
%获取YUV大小
[x,y,~] = size(YUV);
nx=x/8;
ny=y/8;
Ydc=zeros(1,ny*nx);
Udc=zeros(1,ny*nx);
Vdc=zeros(1,ny*nx);
Yac=zeros(1,x*y-nx*ny);
Uac=zeros(1,x*y-nx*ny);
Vac=zeros(1,x*y-nx*ny);
%建立8*8的DCT变换矩阵
T=dctmtx(8); %YUV'=T×YUV×T’
%进行DCT变换
save('mask.mat','T','-append');
k=1;
l=1;
for i=1:nx   
        for j=1:ny
            u=i*8-7;
            v=j*8-7;
            %DCT变换
            dY(u:u+7,v:v+7)=T*Y(u:u+7,v:v+7)*T';
            dU(u:u+7,v:v+7)=T*U(u:u+7,v:v+7)*T';          
            dV(u:u+7,v:v+7)=T*V(u:u+7,v:v+7)*T';
            %对DCT系数进行遮罩处理量化取整
            qY(u:u+7,v:v+7) = blkproc(dY(u:u+7,v:v+7),[8 8], 'round(x./P1.*P2)',m1,mask3);
            qU(u:u+7,v:v+7) = blkproc(dU(u:u+7,v:v+7),[8 8], 'round(x./P1.*P2)',m2,mask3);
            qV(u:u+7,v:v+7) = blkproc(dV(u:u+7,v:v+7),[8 8], 'round(x./P1.*P2)',m2,mask3);
            %阈值处理
%             [qY(u:u+7,v:v+7),T1] =GlobalThreshold(dY(u:u+7,v:v+7),4);
%             [qU(u:u+7,v:v+7),T2] =GlobalThreshold(dU(u:u+7,v:v+7),4);
%             [qV(u:u+7,v:v+7),T3] =GlobalThreshold(dV(u:u+7,v:v+7),4);
            %%存储DC并对AC进行ZigZag扫描
            [Yac(k:k+62),Ydc(l)]=ZigZagscan(qY(u:u+7,v:v+7));
            [Uac(k:k+62),Udc(l)]=ZigZagscan(qU(u:u+7,v:v+7));
            [Vac(k:k+62),Vdc(l)]=ZigZagscan(qV(u:u+7,v:v+7));  
            k=k+63;
            l=l+1;
        end
end
 %对DC进行DMCP
%  [eYdc,Ydc1]=dpcmEncoder(Ydc);
%  [eUdc,Udc1]=dpcmEncoder(Udc);
%  [eVdc,Vdc1]=dpcmEncoder(Vdc);
 %对AC进行游程编码
 eYac=RLC(Yac);
 eUac=RLC(Uac);
 eVac=RLC(Vac);
 
 filename = strcat('bpp',num2str(n),'.mat');
 save(filename,'nx');
 save(filename,'ny','-append');
 save(filename,'eYac','-append');
 save(filename,'eUac','-append');
 save(filename,'eVac','-append');
 save(filename,'Ydc','-append');
 save(filename,'Udc','-append');
 save(filename,'Vdc','-append');

 %是否使用dpcm
%  save(filename,'Ydc1','-append');
%  save(filename,'Udc1','-append');
%  save(filename,'Vdc1','-append');
%  save(filename,'eYdc','-append');
%  save(filename,'eUdc','-append');
%  save(filename,'eVdc','-append');
% 
% 反量化&
% mY=blkproc(dqY,[8 8],'x.*P1',m1);
% mU=blkproc(dqU,[8 8],'x.*P1',m2);
% mV=blkproc(dqV,[8 8],'x.*P1',m2);
% 
% 反DCT变化 IDCT
% IY =blkproc(mY,[8 8],'P1*x*P2',T',T);
% IU =blkproc(mU,[8 8],'P1*x*P2',T',T);
% IV =blkproc(mV,[8 8],'P1*x*P2',T',T);
% 
% 重构图像
%  YUV_rec =cat(3,IY,IU,IV);
%  RGB_rec=YUV2RGB(YUV_rec);
