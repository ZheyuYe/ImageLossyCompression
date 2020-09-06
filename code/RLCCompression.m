function [ data,run ] = RLCCompression(f)
%RLC压缩
[m,n]=size(f);
length=m*n;

%转化为一维矩阵，数据流的形式
%dataStr=f( : );
dataStr=reshape(f,1,length);
%dataLen=length(dataStr);
x=1:1:length;
figure;
plot(x,dataStr(x));
xlabel('数据流长度');
ylabel('数据流值');

j=1;
%result=zeros(1,length);
%data=zeros(1,length);
run(1)=1;
for i=1:(length-1)
    %字符变化，更新序号j
    if dataStr(i)~=dataStr(i+1)
        data(j)=dataStr(i);
         j=j+1;
        run(j)=1;
    else%连续字符，游程+1
         run(j)=run(j)+1;
    end
end
%给最后一个字符赋值
data(j)=dataStr(length);
runLen=size(run,2);
y=1:1:runLen;
figure;
plot(y,run(y));
xlabel('压缩数据流长度');
ylabel('压缩数据流值');

CR=length/runLen;%压缩比
disp('CR=');disp(CR);

% bilength=m*n*64;
%
% %将图像转化为一维数据流
% %dataStr=reshape(f,1,length);
% dataStr=zeros(1,bilength);
% for i=1:length
%     a=char(f(i));
%     for j=1:8
%         temp=(i-1)*8+j;
%         dataStr(temp)=a(j);
%     end
% end

%
% record.position=zeros(1,length);
% record.runlen=zeros(1,length);
% if dataStr(1)>0
%     record.position(1)=dataStr(1);
%     record.runlen(1)=1;
% end
%
% j=1;
% for i=2:length-1
%     if dataStr(i)==1
%         record.runlen(j)=record.runlen(j)+1;
%     end
%     if dataStr(i)==1&&dataStr(i-1)==0
%         record.position(j)=i;
%     end
%     if dataStr(i+1)==0&&dataStr(i)==1
%         j=j+1;
%     end
% end
%
% pairNum0=0;
% for k=1:length
%     if record.position(k)~=0&&record.position(k+1)==0;
%         pairNum0=k;
%     end
% end
% pairNum=pairNum0;
% image.position=zeros(1,pairNum);
% image.runlen=zeros(1,pairNum);
% for i=1:pairNum
%     image.position(i)=record.positon(i);
%     image.runlen(i)=record.runlen(i);
 end
