protData = readtable('protEnc.dat');
[sortedProt, indMap] = sortrows(protData);
results = {};
n = 1;
taus = 0.1:0.1:0.9;
numProtiens = height(protData(:,1));
numComb = nchoosek(numProtiens,2);
ind2heat = zeros(numProtiens,1);
tauTallies = zeros(9,1);

for e=1:numProtiens
    ind2heat(e) = find(indMap == e);
end

for tau=0.1:0.1:0.9
    tauScore = load(sprintf('protienScores%d',uint8(tau*100)));
    results{n} = tauScore;
    n = n+1;
end

for e=1:9
   tally = 0;
   tauScores = results{e}.scores;
   heatscores = zeros(numProtiens, numProtiens);
   minscores = zeros(numProtiens, numProtiens);
   for i=1:numComb
       index1 = round(tauScore.scores(i,1)); %index from
       index2 = round(tauScore.scores(i,2)); %index to
       indHeat1 = ind2heat(index1);
       indHeat2 = ind2heat(index2);
       score  = tauScore.scores(i,3);

       %id1 = protData{index1,1};    %family id of first protien
       %id2 = protData{index2,1};    %family id of second protien

       heatscores(indHeat1,indHeat2) = score;
       heatscores(indHeat2,indHeat1) = score;
       if(sortedProt{indHeat1,1} ~= sortedProt{indHeat2,1})
           minscores(indHeat1,indHeat2) = 10;
           minscores(indHeat2,indHeat1) = 10;
       end
   end
   for k=1:numProtiens
       [rowMin, minIndex] = mink(heatscores(k,:), 4);
       for low = 2:4
           minscores(k,minIndex(low)) = 1;
           minscores(minIndex(low),k) = 1;
           if(sortedProt{minIndex(low),1} == sortedProt{k,1})
               tally = tally + 1;
               minscores(k,minIndex(low)) = 3;
               minscores(minIndex(low),k) = 3;
           end
       end
   end
   tauTallies(e) = tally;
   
end
heatmap(minscores, 'Colormap', parula, 'Title', 'Map of minimum 3 scores when tau = 0.9')
tauTallies