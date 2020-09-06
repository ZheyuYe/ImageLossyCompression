function YUV = YUV2255(YUV)
%RGB2YUV  

% YUV图分层处理  得到3个分量图
Y = YUV(:,:,1);
U = YUV(:,:,2);
V = YUV(:,:,3);

Y = uint8(Y);
U = uint8(U);
V = uint8(V);
 
YUV =cat(3,Y,U,V);
YUV=im2double(YUV);
end

