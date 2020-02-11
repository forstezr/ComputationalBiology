function [N] = findNumOnes(blocks)
    numBlocks = length(blocks);
    N = zeros(1,numBlocks);
    
    for i = 1:numBlocks
        block = blocks{i};
        N(i) = length(find(block == '1'));
    end
end