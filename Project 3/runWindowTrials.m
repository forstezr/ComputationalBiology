%Run tests for multiple window sizes

numIterations = 10000;
%window sizes 10 through 30 split across 4 workers
parfor (k = 10:30, 4)
    windowTrial(numIterations, k);
end