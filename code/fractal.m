clear;

for i=1:3
imagename=strcat('Koadk/kodim10',num2str(i),'.png');
image=imread(imagename);%读入彩色图像
% image=imread('lenna.png');%读入彩色图像
image=double(image);
size1=size(image);

R=image(1:size1(1),1:size1(2),1);%取出彩色三维数据其中的第一维，即为灰度图像
G=image(1:size1(1),1:size1(2),2);
B=image(1:size1(1),1:size1(2),3);

% 编码
t1=clock;  
RRR=fractalEncode(R,size1);  
GGG=fractalEncode(G,size1);
BBB=fractalEncode(B,size1);
t2=clock;
time = etime(clock,t1);
display(num2str(time));

save('fracEncodeFile.mat','RRR');
save('fracEncodeFile.mat','BBB','-append');
save('fracEncodeFile.mat','GGG','-append');

%解码
load('fracEncodeFile.mat');
time=zeros(1,10);
PSNR=zeros(1,10);
SSIM=zeros(1,10);

t1=clock;
frac_R=fractalDecode(RRR,size1,10);
frac_G=fractalDecode(GGG,size1,10);
frac_B=fractalDecode(BBB,size1,10);
t2=clock;
time(1,i) = etime(clock,t1);
%图片性能分析

frac_rec =cat(3,frac_R,frac_G,frac_B);
frac_rec = uint8(frac_rec);
image=uint8(image);
[PSNR(1,i),SSIM(1,i)]=ImageAnalysis(image,frac_rec,i);
end



% fclose(outfp);
