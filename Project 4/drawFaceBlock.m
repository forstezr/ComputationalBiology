function [cords] = drawFaceBlock(block, startCord)
    cords = {};
    
    oneInd = find(block == '1');
    offset = 1;
    numOnes = length(oneInd);
    for i = 1:numOnes
        cords = [cords [startCord(1) startCord(2)+offset]]; %add ones coords
        if(numOnes == 1) break; end
        offset = offset + 2;
        %this only runs if theres multiple 1's
        if(i < numOnes)
            %run for all but last iteration
            numPoints = length((oneInd(i)+1):(oneInd(i+1)-1));
            cords = [cords drawLoop(numPoints, cords{end})];
        end
    end
end