function [cords] = drawLoop(numPoints, startCord)
    %draw a loop using numPoints number of cords
    
    cords = {};
    if(numPoints > 1)
        back = round(numPoints/2);
        out = back-1;

        for i = 1:out %go out
            cords = [cords [startCord(1)+i startCord(2)]];
        end

        for e = 1:back
            cords = [cords [startCord(1)+(back-e) startCord(2)+1]];
        end
    else
        cords = {[startCord(1) startCord(2)+1]};
    end
end