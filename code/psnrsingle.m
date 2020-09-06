function PSNR = psnrsingle(im1)
% 计算峰值信噪比PSNR、均方根误差MSE
% im1 : the original image matrix
% im2 : the modified image matrix   



    [m,n] = size(im1);
    A = double(im1);
    A0= A(1,1);
    D = sum(sum( sum( (A-A0).^2 ) ));%||A-B||^2
    MSE = D / (m * n );
if  D == 0
    PSNR = 200;
else
    PSNR = 10*log10( (255^2) / MSE );                                                        
end
