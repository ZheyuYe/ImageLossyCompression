function [a]=trunc(b)
%trunc
% È¡Õûº¯Êý

if(b>0)
    a=floor(b);
elseif (b<0)
    a=ceil(b);
else a=0;
end

end