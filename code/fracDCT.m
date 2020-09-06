clear;
for i=6:6
imagename=strcat('Koadk/kodim',num2str(i),'.png');
image=imread(imagename);%读入彩色图像
size1=size(image);

R=double(image(1:size1(1),1:size1(2),1));%取出彩色三维数据其中的第一维，即为灰度图像
G=double(image(1:size1(1),1:size1(2),2));
B=double(image(1:size1(1),1:size1(2),3));

% 编码
Tp=2;
[R_rec,entime(i),detime(i)]=fractalDCT16En(R,size1,Tp);  
[G_rec,entime(i),detime(i)]=fractalDCT16En(G,size1,Tp);
[B_rec,entime(i),detime(i)]=fractalDCT16En(B,size1,Tp);

%解码

%图片性能分析
frac_rec =cat(3,R_rec,G_rec,B_rec);
[CR(i),PSNR(i),SSIM(i)]=ImageAnalysis(image,frac_rec,i);
end


