function [state, scores, states] = itrMotifs(initialState, scores, numIterations, windowSize, states)
    sequences = DPalign();
    numSeq = length(sequences);
    %numIterations = 100;
    %windowSize = 10;
    state = initialState;
    %states = [];
    %scores = [];
    
    for iterations=1:numIterations
       %Run for k iterations
       count = zeros(4,windowSize);
       randDNA = randi([1,numSeq], 1,1);
       window = getWindow(sequences, state, windowSize);
       %populate count matrix
       for col = 1:windowSize
           for row = 1: numSeq
              % iterate through entire window
              if row ~= randDNA
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
           end
       end %end populate count
       count = count/(numSeq-1);
       
       %do slidey window thingy
       slide = sequences(randDNA,:);
       numSlide = length(slide) - windowSize;
       slideProb = ones(1,numSlide);
       cumulativeProb = zeros(1,numSlide);
       for s = 1:(numSlide)
           slideWindow = slide(s:s+windowSize-1);
           for k = 1: windowSize
               switch(slideWindow(k))
                       case 'a'
                           slideProb(s) = slideProb(s) * count(1,k);
                       case 't'
                           slideProb(s) = slideProb(s) * count(2,k);
                       case 'g'
                           slideProb(s) = slideProb(s) * count(3,k);
                       case 'c'
                           slideProb(s) = slideProb(s) * count(4,k);
               end
           end
       end %end slidedy thing
       slideProb = slideProb / sum(slideProb);
       total = 0;
       for y = 1:numSlide
           cumulativeProb(y) = total + slideProb(y);
           total = cumulativeProb(y);
       end
       
       randStatePicker = rand(1);
       for b = 1:numSlide
           if randStatePicker <= cumulativeProb(b)
               state(randDNA) = b;
               break;
           end
       end
       %Record State
       states = [states; state];
       [C, IA, IC] = unique(states, 'rows', 'stable');
       if (length(IA) ~= length(IC)) 
           repeatInd = IC(end);
           scores(repeatInd) = scores(repeatInd) + 1;
       else
           scores = [scores; 1];
       end 
       states = C;
    end
end