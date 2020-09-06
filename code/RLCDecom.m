
function  Image= RLCDecom( m,n,data,run)
%RLCDecom 解压缩
l=1;
runLen=size(run,2);
Image=zeros(m,n);
for m=1:runLen
    for n=1:run(m)
        Image(l)=data(m);
        l=l+1;
    end
end
% u=1:1:length(Image);
% figure(4),plot(u,Image(u));
% xlabel('图片长度');
% ylabel('图片数据值');

%   len=m*n;
%   bilen=m*n*64;
%   %还原成二进制数据流
%   data=zeros(1,bilen);
%   for i=1:pairNum
%       for j=image.position(i):image.position(i)+image.runlen(i)-1
%           data(j)=1;
%       end
%   end
%  
%   %以8位为一个单元分割，转换成整数存储到结果矩阵中
%   result=zeros([m,n],'uint8');
% for i=1:len
%     temp=data(1:8);
%     data=data(9:end);
%     result(i)=bin2dec(int2str(temp));
% end
% Image=mat2gray(result);

end