function [total] = blockSum(N, B, blockID)
    %count num ones... if blockID = 'x' count even else count odd
    %N = ones total for each block in order
    %B = indecies attributing blocks to a super block
    if(blockID == 'x')
        %sum even indecies only
        even = find(mod(B,2) == 0);
        total = sum(N(even));
    else
        %sum odd indecies only
        odd = find(mod(B,2) == 1);
        total = sum(N(odd));
    end
end