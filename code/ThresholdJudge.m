function out=ThresholdJudge(out,T)   
% 对于小于T的数记为0 大于T的记录0
out(abs(out)<T) = 0;
out(abs(out)>T) = 1;
end