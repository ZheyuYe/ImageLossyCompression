function restore_img=graytest(lena_ori)
    quantization_mat = [16,11,10,16,24,40,51,61;
    12,12,14,19,26,58,60,55;
    14,13,16,24,40,57,69,56;
    14,17,22,29,51,87,80,62;
    18,22,37,56,68,109,103,77;
    24,35,55,64,81,104,113,92;
    49,64,78,87,103,121,120,101;
    72,92,95,98,112,100,103,99;];
 % 作8*8 DCT
 T=dctmtx(8); %YUV'=T×YUV×T’
 lean_dct = blkproc(lena_ori,[8 8],'P1*x*P2',T,T');
 % 量化
%  lena_quantization = blkproc(lean_dct,[8 8],'x./P1',quantization_mat);
 lena_jpeg = int16(lena_quantization);  %取整
 
 %还原图像
%  restore_dct = blkproc(lena_jpeg,[8 8],'x.*P1',quantization_mat);
 restore_img = blkproc(lena_quantization,[8 8],'P1*x*P2',T',T);
end
