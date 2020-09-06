function [out,T]=GlobalThreshold(RGB_R,n)   
[x,y] = size(RGB_R);                                     
T = 0;      % T赋初值，为最大值和最小值的平均值    
count = double(0);                     % 迭代次数   
while 1                    % 阈值迭代   
    sum1 = 0;               % 初始化灰度大于阈值的元素的灰度总值  
    num1 = 0;              % 初始化灰度大于阈值的元素的灰度个数  
    sum2 = 0;               % 初始化灰度小于阈值的元素的灰度总值  
    num2 = 0;              % 初始化灰度小于阈值的元素的灰度个数    
    for i=1:x   
        for j=y-n+1:y   
            if double(RGB_R(i,j))~=0
                if abs(double(RGB_R(i,j)))>=T
                    sum2 = sum2 + abs(double(RGB_R(i,j)));%大于阈域值图像点灰度值累加   
                    num2 = num2 + 1;                %大于阈域值图像点个数累加   
                else    
                    sum1 = sum1 + abs(double(RGB_R(i,j)));  %小于阈域值图像点灰度值累加   
                    num1 = num1 + 1;                %小于阀域值图像点个数累加   
                end
            end
        end    
    end
    
    T0 = sum1/num1;                        %求小于阀域的灰度值均值   
    T1 = sum2/num2;                        %求大于阀域的灰度值均值   
    if sum1==0 && num1==0
        T0=0; 
    end
    if sum2==0 && num2==0
        T1=0; 
    end   
    if abs(T-((T0+T1)/2)) < 0.03     %迭代至前后两次阀域值相差小于0.01时停止迭代。
        break;   
    else
        count=count+1;
        T = (T0+T1)/2;                 % 更新阈值T
   end    
end      
out=RGB_R;

out=ThresholdJudge(out,T);
% 保留左上角10个数
for i=1:n
    for j=1:n-i+1
        out(i,j)=1;
    end
end
out=RGB_R.*out;
end