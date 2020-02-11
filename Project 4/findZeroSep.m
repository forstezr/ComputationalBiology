function [Z] = findZeroSep(front, center, back, len)
    Z = zeros(1,len);
    Z(1)   = length(front)-1;
    Z(end) = length(back) -1;
    inc = 1;
    for i = 1:length(center)
        block = center{i};
        if(block == repmat('0', [1,length(block)]))
            Z(inc) = length(block);
        else
            inc = inc+1;
        end
    end
end