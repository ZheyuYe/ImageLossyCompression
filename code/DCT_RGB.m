close all;
clear all;
clc;
%读入图像
time_encode=zeros(1,24);
time_decode = zeros(1,24);
PSNR=zeros(1,24);
SSIM=zeros(1,24);
CR=zeros(1,24);

for i=15:15
imagename=strcat('Koadk/kodim',num2str(i),'.png');
RGB = imread(imagename);
% RGB = imread('lenna.png');

%记时&压缩
 t1=clock;   
 [filename]=DCTCompress(RGB,i);
 t2=clock;
 time_encode(i)= etime(clock,t1);
%  filename = 'EncodeFile.mat';
 t1=clock;
 RGB_rec=DCTDecompress(filename); 
 time_decode(i) = etime(clock,t1);
 t2=clock;
 %图片性能分析
[R(i),PSNR(i),SSIM(i)]= ImageAnalysis(RGB,RGB_rec,i);

R_average = mean(R);
% display(time_encode(i));
% display(time_decode(i));
timeEn_average = mean(time_encode);
timeDe_average = mean(time_decode);
PSNR_average = mean(PSNR);
SSIM_average = mean(SSIM);
end


 
 


