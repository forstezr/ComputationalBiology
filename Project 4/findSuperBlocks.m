function [Bp, Bdp] = findSuperBlocks(N, numBlocks)

    %begin finding super blocks
    cond = @(a,b,A,B) ((a<b)||((a==b) && (A<B)));
    %set Initial conditions
    B1 = 1; B2 = 2:numBlocks;
    mxy = min(blockSum(N, B1, 'x'),blockSum(N, B2, 'y'));
    myx = min(blockSum(N, B1, 'y'),blockSum(N, B2, 'x'));
    Mxy = max(blockSum(N, B1, 'x'),blockSum(N, B2, 'y'));
    Myx = max(blockSum(N, B1, 'y'),blockSum(N, B2, 'x'));
    
    if(mxy > myx)
        Bp = B2; Bdp = B1; e = mxy; E = Mxy;
    else
        Bp = B1; Bdp = B2; e = myx; E = Myx;
    end
    
    for i = 3:numBlocks
        B1 = 1:(i-1); B2 = i:numBlocks;
        mxy = min(blockSum(N, B1, 'x'),blockSum(N, B2, 'y'));
        Mxy = max(blockSum(N, B1, 'x'),blockSum(N, B2, 'y'));
        
        if(cond(e, mxy, E, Mxy))
            Bp = B2; Bdp = B1; e = mxy; E = Mxy;
        end
        myx = min(blockSum(N, B1, 'y'),blockSum(N, B2, 'x'));
        Myx = max(blockSum(N, B1, 'y'),blockSum(N, B2, 'x'));
        if(cond(e, myx, E, Myx))
            Bp = B1; Bdp = B2; e = myx; E = Myx;
        end
    end
end