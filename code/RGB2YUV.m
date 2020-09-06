function YUV = RGB2YUV(RGB)
%RGB2YUV  


%RGB图分层处理  得到3个分量图
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);
%转换为双精度
 R = double(R);
 G = double(G);
 B = double(B);
%RGB2YUV
Y=0.299*R+0.587*G+0.114*B;
U=-0.1687*R-0.3313*G+0.5*B;
V=0.5*R-0.4187*G-0.0813*B;
% %YUV由[-255,255]转换为[-127,128]
Y=Y/2;
U=U/2;
V=V/2;
 
YUV =cat(3,Y,U,V);
end

