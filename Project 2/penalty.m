function [penalty] = penalty(value1, value2)
    %This function calculates the penalty for pairing based upon what
    %combination of atgc you give it
    lookupMat = [[0 1 4 4]; [1 0 4 4]; [4 4 0 1]; [4 4 1 0]];
    lookupInd = ['a'; 't'; 'g'; 'c'];
    
    index1 = find(lookupInd==value1);
    index2 = find(lookupInd==value2);
    
    penalty = lookupMat(index1,index2);
end