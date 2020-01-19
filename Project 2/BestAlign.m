
function [alignment,scoretot] = BestAlign(seq1,seq2)

n = length(seq1);
m = length(seq2);

score = zeros(n+1, m+1);
w = -2;
back = cell(n+1, m+1);

% fill the score matrix
for i=2:n+1
    for j=2:m+1
        sij = -1;
        if seq1(i-1) == seq2(j-1)
            sij = 2;
        end
        a = [score(i-1,j-1)+sij, score(i,j-1)+w, score(i-1,j)+w];
        [smax, imax] = max(a);
        score(i,j) = smax;
        switch imax
            case 1
                back{i,j} = [i-1, j-1];
            case 2
                back{i,j} = [i, j-1];
            case 3
                back{i,j} = [i-1, j];
        end
    end
end

scoretot = score(i,j);

i = n+1;
j = m+1;
align = cell(1,max([n, m])-1);
align{1} = [i, j];
k = 2;
while i > 2 && j > 2
    ij = back{i,j};
    align{k} = ij;
    k = k + 1;
    i = ij(1);
    j = ij(2);
end

iold = 0;
jold = 0;
l = 1;
for k=length(align):-1:1
    ij = align{k};
    i = ij(1);
    j = ij(2);
    if i ~= iold
        c1 = seq1(i-1);
    else
        c1 = '-';
    end
    if j ~= jold
        c2 = seq2(j-1);
    else
        c2 = '-';
    end
    iold = i;
    jold = j;
    aseq1(l) = c1;
    aseq2(l) = c2;
    l = l + 1;
end

alignment = {aseq1; aseq2};
