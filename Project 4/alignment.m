function [coordinates] = alignment(superblock1, superblock2)
coordinates = '';
xy = 1; %x or y block?
j=1; %position along center axis
for k = (1:length(superblock1)) %aligning block 1
    if skip > 0
        skip = 0;
        continue
    end
    if ~rem(superblock1(k),2)
        if ~rem(xy,2)
            if ~rem(superblock1(k+2),2)
                for i = (length(superblock1(k))+length(superblock1(k+1))+...
                        length(superblock1(k+2)))/2
                    coordinates = coordinates + '1-i,j';
                    j = j+1;
                end
                for i = (length(superblock1(k))+lenghth(superblock1(k+1))+...
                        length(superblock1(k+2)))/2
                    coordinates = coordinates + '1-i,j';
                end
                xy = xy+1;
                skip = 1;
                continue
            else
                for i = (length(superblock1(k))+length(superblock1(k+1)))/2
                    coordinates = coordinates + '1-i,j';
                    j=j+1;
                end
                for i = (length(superblock1(k))+lenghth(superblock1(k+1)))/2
                    coordinates = coordinates + '1-i,j';
                end
                xy = xy+1;
                continue
            end
        else
            for i = length(superblock1(k))/2
                coordinates = coordinates + '1-i,j';
                j = j+1;
            end
            for i = length(superblock1(k))/2
                coordinates = coordinates + '1-i,j';
            end
        end
    else
        coordinates = blockalign1(superblock1(k),coordinates);
        xy = xy + 1;
    end
end
xy = 1; %starting on y this time
for k = (1:length(superblock2))
    if skip > 0
        skip = 0;
        continue
    end
    if ~rem(superblock2(k),2)
        if ~rem(xy,2)
            if ~rem(superblock2(k+2),2)
                for i = (length(superblock2(k))+length(superblock2(k+1))+...
                        length(superblock2(k+2)))/2
                    coordinates = coordinates + '1+i,j';
                    j = j-1;
                end
                for i = (length(superblock2(k))+lenghth(superblock2(k+1))+...
                        length(superblock2(k+2)))/2
                    coordinates = coordinates + '1+i,j';
                end
                xy = xy+1;
                skip = 1;
                continue
            else
                for i = (length(superblock2(k))+length(superblock2(k+1)))/2
                    coordinates = coordinates + '1+i,j';
                    j=j-1;
                end
                for i = (length(superblock1(k))+lenghth(superblock1(k+1)))/2
                    coordinates = coordinates + '1+i,j';
                end
                xy = xy+1;
                continue
            end
        else
            for i = length(superblock2(k))/2
                coordinates = coordinates + '1+i,j';
                j = j-1;
            end
            for i = length(superblock2(k))/2
                coordinates = coordinates + '1+i,j';
            end
        end
    else
        coordinates = blockalign2(superblock2(k),coordinates);
        xy = xy + 1;
    end
end
end

function[subco] = blockalign1(block, startco)
if length(block) == 1
    subco = startco;
    return
else
    if strcom(startco(length(startco)-1),'0,j')
        j = j+1;
    end
    for i = length(block)/2
        coordinates = coordinates + '1-i,j';
        j = j+1;
    end
    for i = length(superblock1(k))/2
        coordinates = coordinates + '1-i,j';
    end
end
end

function[subco] = blockalign2(block, startco)
if length(block) == 1
    subco = startco;
    return
else
    if strcom(startco(length(startco)-1),'0,j')
        j = j-1;
    end
    for i = length(block)/2
        coordinates = coordinates + '1+i,j';
        j = j-1;
    end
    for i = length(superblock1(k))/2
        coordinates = coordinates + '1+i,j';
    end
end
end