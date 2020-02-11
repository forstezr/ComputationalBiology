function [cords] = loopFold(numZeros)

    if(numZeros == 0)
        cords = [];
    else
        cords = {};
        down = numZeros/2;
        for i = 1:down
            cords = [cords [-1 1-i]];
        end
        for e = 1:down
            cords = [cords [0 -down+e]];
        end
    end
end