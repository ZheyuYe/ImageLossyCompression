function SSIM = ssim(X, Y)

w = fspecial('gaussian', 11, 1.5);  %window 加窗  
K1 = 0.01;                      
K2 = 0.03;                      
L = 255;       

ima = double(X);  
imb = double(Y);  
  
C1 = (K1*L)^2;  
C2 = (K2*L)^2;  
w = w/sum(sum(w));  
  
ua   = filter2(w, ima, 'valid');%对窗口内并没有进行平均处理，而是与高斯卷积，  
ub   = filter2(w, imb, 'valid'); % 类似加权平均  
ua_sq = ua.*ua;  
ub_sq = ub.*ub;  
ua_ub = ua.*ub;  
siga_sq = filter2(w, ima.*ima, 'valid') - ua_sq;  
sigb_sq = filter2(w, imb.*imb, 'valid') - ub_sq;  
sigab = filter2(w, ima.*imb, 'valid') - ua_ub;  
  
ssim_map = ((2*ua_ub + C1).*(2*sigab + C2))./((ua_sq + ub_sq + C1).*(siga_sq + sigb_sq + C2));  
  
  
SSIM = mean2(ssim_map);
end