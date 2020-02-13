function [pairs] = findPairs(cords, vals)
    numPoints = length(cords);
    pairs = {};
    for i=1:numPoints-2
        if(vals(i) == 1)
            for e=i+2:numPoints
                if(vals(e) == 1)
                    point1 = cords{i}; point2 = cords{e};
                    x1 = point1(1); y1 = point1(2);
                    x2 = point2(1); y2 = point2(2);
                    if(xor((abs(x1-x2) == 1) && (x1 == x2 || y1 == y2),(abs(y1-y2) == 1)) && (x1 == x2 || y1 == y2))
                        pairs = [pairs {[x1 y1] [x2 y2]}];
                    end
                end
            end
        end
    end
    
%     for k = 1:2:length(pairs)
%         fprintf('[%d,%d]<-->[%d,%d]\n',pairs{k}(1),pairs{k}(2),pairs{k+1}(1),pairs{k+1}(2))
%     end

end