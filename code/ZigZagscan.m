function [Vect,DC]=ZigZagscan(X)
% ZigZagscan Transform an matrix to a vector using Zig Zag Scan.
%    
% VECT = ZIGZAGSCAN(MATRIX) reorganize the input Matrix and output it as a vector.
%    
%    Example:
%          X=[1 2 3
%             4 5 6
%             7 8 9]
%
%     X =
%        1  2  3
%        4  5  6
%        7  8  9

%     ZigZagscan(X)=
%                   1  2  4  7  5  3  6  8  9
%
%**************************************************************************
[~, N]=size(X);
Vect=zeros(1,N*N-1);
DC=X(1,1);
v=1;
for k=2:2*N-1
    if k<=N
        if mod(k,2)==0
        j=k;
        for i=1:k
        Vect(v)=X(i,j);
        v=v+1;j=j-1;    
        end
        else
        i=k;
        for j=1:k   
        Vect(v)=X(i,j);
        v=v+1;i=i-1; 
        end
        end
    else
        if mod(k,2)==0
        p=mod(k,N); j=N;
        for i=p+1:N
        Vect(v)=X(i,j);
        v=v+1;j=j-1;    
        end
        else
        p=mod(k,N);i=N;
        for j=p+1:N   
        Vect(v)=X(i,j);
        v=v+1;i=i-1; 
        end
        end
    end
end
 
        
        