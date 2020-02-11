
data = load('data.mat');

for k = 1:length(data.sequences)
    sequence = data.sequences{k};

    [block1, foldSep, block2, blockTypes, block1IDs, block2IDs] = foldProtein(sequence);
    %block1 = cell array of string blocks
    %block2 = ^
    %foldSep = number of 0's in zero separator being folded around
    %blockTypes = x and y block order (which is B prime and B d prime)
    %block1IDs = y, x, z block labels 1 = y, 0 = x, 2 = z
    %block2IDs = ^

    %insert Carlyn's code here
    block1f = flip(block1);
    for i = 1:length(block1)
        block1f{i} = flip(block1f{i});
    end
    cordsleft = findFace(block1f, blockTypes(1), flip(block1IDs)); %block is reversed
    cords1 = flip(cordsleft);

    for e = 1:length(cords1)
        cords1{e} = [-cords1{e}(1)-1 cords1{e}(2)];
    end

    cordsFold = loopFold(foldSep);

    cords2 = findFace(block2, blockTypes(2), block2IDs); %this can be input as is.

    %insert Nick's code here
    DispProt([cords1 cordsFold cords2], sequence)
    %do topological pairs here
    pause
end
