function [R,PSNR,SSIM]=ImageAnalysis(I1,I2)
%图像压缩比MSE、PSNR、SSIM计算
% I1=mat2gray(I1);
% I2=mat2gray(I2);

% restorefilename=strcat('kodimfrac10',num2str(n),'.png');
restorefilename='restore.png';
miss=I1-I2;
imwrite(I1, 'original.png');
imwrite(I2, restorefilename);

f0 =  imfinfo('original.png');
f1 =  imfinfo(restorefilename);


R = f0.FileSize/f1.FileSize;

[PSNR, MSE] = psnr(I1, I2);
SSIM = ssim(I1, I2);

display(R);

display(MSE);
display(PSNR);
display(SSIM);

figure();
subplot(1,3,1);
imshow(I1);title('原始图像');
subplot(1,3,2);
imshow(I2);title('重建图像');
subplot(1,3,3);imshow(miss);title('差值');

end
 
