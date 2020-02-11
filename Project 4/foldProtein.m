function [block1, foldSep, block2, blockTypes, block1IDs, block2IDs] = foldProtein(sequence)

    blockedSeq = parseData(sequence);

    [beginning, ending, blockedSeq] = handleEnds(blockedSeq);
    blocks = split(blockedSeq);

    zeroSep = {};
    YXblocks = {};
    L = {};
    for i=1:length(blocks)
        block = blocks{i};
        if(block == repmat('0', [1,length(block)]))
            zeroSep = [zeroSep block];
        elseif(length(block) > 0)
            YXblocks = [YXblocks block];
        end
    end

    numBlocks = length(YXblocks);
    Z = findZeroSep(beginning, blocks, ending, numBlocks+1);
    N = findNumOnes(YXblocks);

    [Bp, Bdp] = findSuperBlocks(N, numBlocks);
    %proccess result for face folding
    if(Bp(1) == 1)
        leftBlocks = YXblocks(Bp);
        rightBlocks= YXblocks(Bdp);
        blockTypes = ['y' 'x'];
        offset = Bp(end);
    else
        leftBlocks = YXblocks(Bdp);
        rightBlocks= YXblocks(Bp);
        blockTypes = ['x' 'y'];
        offset = Bdp(end);
    end
    block1 = {};
    block2 = {};
    block1IDs = [];
    block2IDs = [];
    currentID = 1;
    %insert Zsep for blocks 1 and 2
    for k = 1:length(leftBlocks)
        if(Z(k) > 0)
            block1 = [block1 repmat('0', [1,Z(k)]) leftBlocks{k}];
            block1IDs = [block1IDs 2 currentID];
        else
            block1 = [block1 leftBlocks{k}];
            block1IDs = [block1IDs currentID];
        end
        currentID = ~currentID;
    end

    foldSep = Z(k+1);

    for k = 1:length(rightBlocks)
        if(Z(k+offset+1) > 0)
            block2 = [block2 rightBlocks{k} repmat('0', [1,Z(k+offset+1)])];
            block2IDs = [block2IDs currentID 2];
        else
            block2 = [block2 rightBlocks{k}];
            block2IDs = [block2IDs currentID];
        end
        currentID = ~currentID;
    end
end



