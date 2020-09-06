function RGB_rec = DCTDecompress(filename)

load(filename); 
load('mask.mat');
%          dYdc = dpcmDecoder(eYdc,Ydc1);
%          dUdc = dpcmDecoder(eUdc,Udc1);
%          dVdc = dpcmDecoder(eVdc,Vdc1);
         dYac=DeRLC(eYac);
         dUac=DeRLC(eUac);
         dVac=DeRLC(eVac);     
         
k=1;
l=1;        
for i=1:nx
    for j=1:ny
        u=i*8-7;
        v=j*8-7;
        dqY(u:u+7,v:v+7)=ZigZag2Martix(dYac(k:k+62),Ydc(l));
        dqU(u:u+7,v:v+7)=ZigZag2Martix(dUac(k:k+62),Udc(l));
        dqV(u:u+7,v:v+7)=ZigZag2Martix(dVac(k:k+62),Vdc(l));  
        k=k+63;
        l=l+1;
    end
end

%反量化&
mY=blkproc(dqY,[8 8],'x.*P1',m1);
mU=blkproc(dqU,[8 8],'x.*P1',m2);
mV=blkproc(dqV,[8 8],'x.*P1',m2);

%反DCT变化 IDCT
IY =blkproc(mY,[8 8],'P1*x*P2',T',T);
IU =blkproc(mU,[8 8],'P1*x*P2',T',T);
IV =blkproc(mV,[8 8],'P1*x*P2',T',T);

%重构图像
 YUV_rec =cat(3,IY,IU,IV);
 RGB_rec=YUV2RGB(YUV_rec);
 RGB_rec=uint8(RGB_rec);


         
         
         