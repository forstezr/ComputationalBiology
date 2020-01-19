originalData = readtable('protEnc.dat');
results = {};
n = 1;
taus = 0.1:0.1:0.9;
for tau=0.1:0.1:0.9
    tauScore = load(sprintf('protienScores%d',uint8(tau*100)));
    results{n} = tauScore;
    n = n+1;
end
tauTallies = zeros(9,40);
tallyInd = 1;
for k=100:20:900
    for i=1:9
       %evaluate each tau to find which is best
       tally = 0;
       tauScores = results{i}.scores;
       [minimum, index] = mink(tauScores(:,3),k);
       for numCheck= 1:k
           value = tauScores(index(numCheck),:);
           if(originalData{value(1),1} == originalData{value(2),1})
               tally = tally + 1;
           end
       end
       tauTallies(i,tallyInd) = (tally/k)*100;
    end
    tallyInd = tallyInd + 1
end
plot(tauTallies.')