A = DPalign();
numSeq = length(A);
numComb = nchoosek(numSeq,2);
scores = zeros(numComb,3);
n=1;
for i = 1:numSeq
    for e = i+1:numSeq
        scores(n,1) = i;
        scores(n,2) = e;
        [aligned,scores(n,3)] = BestAlignment(A(i,:),A(e,:), 0);
        n = n+1;
    end
end

[minScore, minIndex] = min(scores(:,3));
[maxScore, maxIndex] = max(scores(:,3));

[minAlignment, minimumScore] = BestAlignment(A(scores(minIndex,1),:),A(scores(scores(minIndex, 2)),:), 1)
[maxAlignment, maximumScore] = BestAlignment(A(scores(maxIndex,1),:),A(scores(scores(maxIndex, 2)),:), 1)