load protienScores90;
protData = readtable('protEnc.dat');
[sortedProt, indMap] = sortrows(protData);

numProtiens = height(protData(:,1));
numComb = nchoosek(numProtiens,2);
heatscores = zeros(numProtiens, numProtiens);
ind2heat = zeros(numProtiens,1);

for e=1:numProtiens
    ind2heat(e) = find(indMap == e);
end

for i=1:numComb
    index1 = round(scores(i,1)); %index from
    index2 = round(scores(i,2)); %index to
    indHeat1 = ind2heat(index1);
    indHeat2 = ind2heat(index2);
    score  = scores(i,3);
    
    id1 = protData{index1,1};    %family id of first protien
    id2 = protData{index2,1};    %family id of second protien
    
    heatscores(indHeat1,indHeat2) = score;
    heatscores(indHeat2,indHeat1) = score;
end
figure
heatmap(heatscores, 'Colormap',parula, 'Title', sprintf('Heat-map of scores when tau = 0.9'))
