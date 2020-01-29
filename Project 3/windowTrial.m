function [motif, probs] = windowTrial(numIterations, windowSize)    
    sequences = DPalign();
    numSeq = length(sequences);
    %windowSize = 10;
    %numIterations = 10000;
    index2char = 'atgc';

    probs = zeros(5,windowSize);
    %h = waitbar(0, 'Processing Computations...');
    %Train the model
    [state, scores, states] = motifs(ones(1,132), numIterations, windowSize);
    %waitbar(1/7, h,'Training Finished...')
    %Run for solution
    [finalState, finalScores, finalStates] = motifs(state, numIterations*2, windowSize);
    %waitbar(2/7, h,'Search Finished...')

    %process solution
    [sortedScores, scoresIndex] = sort(finalScores, 'descend');
    sortedStates = finalStates(scoresIndex,:);
    %fprintf('\n=============== Most Likely Motifs ===============\n')
    motif = '';
    for i=1:5
       
       ithState = sortedStates(i,:);
       window = getWindow(sequences, ithState, windowSize);
       count = zeros(4,windowSize);
       for col = 1:windowSize
           for row = 1: numSeq
               % iterate through entire window
               switch(window(row, col))
                   case 'a'
                       count(1,col) = count(1,col) + 1;
                   case 't'
                       count(2,col) = count(2,col) + 1;
                   case 'g'
                       count(3,col) = count(3,col) + 1;
                   case 'c'
                       count(4,col) = count(4,col) + 1;
               end
           end
       end %end populate count
       count = count/(numSeq);

       for column = 1:windowSize
           [countMax,cmi] = max(count(:,column));
           %index vector atgc and get likely hood of most likely char
           motif(i,column) = index2char(cmi);
           probs(i, column) = countMax;
       end

       %fprintf('Number %d most likely motif\n', i)
       %fprintf(motif(i,:))
       %fprintf('\n')
%        for printProb = 1:windowSize
%           fprintf([motif(i,printProb) sprintf('(%1.2f) ',probs(i,printProb))])
%        end
       %fprintf('\n\n')
       %waitbar((i+2)/7, h,'Processing Results...')
    end
    %close(h);
    result = {motif, probs};
    save(sprintf('resultW%d',windowSize),'result');
end