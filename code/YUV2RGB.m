function RGB = YUV2RGB(YUV)
% YUV2RGB
% YUV图分层处理  得到3个分量图
Y = double(YUV(:,:,1));
U = double(YUV(:,:,2));
V = double(YUV(:,:,3));
% %YUV由[-127,128]转换为[0,2]
 Y = Y*2;
 U = U*2;
 V = V*2;
%  YUV2RGB
 R=Y+1.42*V;
 G=Y-0.34414*U-0.71414*V;
 B=Y+1.1772*U;
   R = uint8(R);
   G = uint8(G);
   B = uint8(B);
RGB=cat(3,R,G,B);

end

