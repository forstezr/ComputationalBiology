%Test number of iterations required to identify alignment

sequences = DPalign();
numSeq = length(sequences);
width = length(sequences(1,:));
numIterations = 10;
windowSize = 10;
initialState = ones(1,132);
initialScores = [];
states = [];
index2char = 'atgc';

%set identical local pattern
pattern = sequences(1,1:windowSize); %set this is repeating pattern
for i = 2:numSeq
    offset = randi([1,(width - (windowSize))],1,1);
    %sequences(i,:) = [sequences(i:(offset-1)) pattern sequences(i,(offset+windowSize:end))];
    sequences(i,offset:(offset+windowSize-1)) = pattern;
    initialState(i) = offset+1;
end
%begin test to see how many iterations it takes to identify repeating
%pattern
[w] = getWindow(sequences, initialState, windowSize)
%initialState(1) = 20;
motifIdentified = 0;
probIdentified  = 0;
iteration = 0;

while(1)
    probs = zeros(5,windowSize);
    [state, finalScores, finalStates] = itrMotifs(initialState, initialScores, numIterations, windowSize, states);
    
    %process solution
    [sortedScores, scoresIndex] = sort(finalScores, 'descend');
    sortedStates = finalStates(scoresIndex,:);
    for i=1:1
       motif = '';
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
    end
    
    
    if(motif(1,:) == pattern)
        if(motifIdentified == 0)
            motifIdentified = iteration %store ieration motif is identified
        end
        break;
%         if(prod(probs(1,:)) >= 0.9)
%             probIdentified = iteration; %store iteration prob is identified
%             break;
%         end
    end
    initialState = state; %continue Search
    initialScores = finalScores;
    states = finalStates;
    iteration = iteration + 10;
end
