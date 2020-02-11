function [cords] = findFace(blocks, blockType, blockIDs)
    
    cords = {}; %cords stored as cell array of [x y] arrays
    startCord = [0 0];
    cords{1} = startCord;
    if(blockType == 'y')
        ID = 1; %y block on face
    else
        ID = 0; %x block on face
    end

    faceBlocks = find(blockIDs == ID);
    numBlocks = length(faceBlocks);

    for i = 1:numBlocks-1 %loop through face blocks
        %draw face block
        cords = [cords drawFaceBlock(blocks{faceBlocks(i)} ,cords{end})];

        %draw intermediate blocks
        nonFaceBlocks = (faceBlocks(i)+1):(faceBlocks(i+1)-1); %indecies for intermediate blocks
        total = 0;
        for e = 1:length(nonFaceBlocks)
            total = total + length(blocks{nonFaceBlocks(e)});
        end
        cords = [cords drawLoop(total, cords{end})];

    end

    %draw last face block
    cords = [cords drawFaceBlock(blocks{faceBlocks(numBlocks)} ,cords{end})];

    cords = cords(2:end); %remove initial point

end
