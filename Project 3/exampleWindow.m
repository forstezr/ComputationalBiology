%make an example state window for report

sequences = DPalign();
numSeq = 20; %length(sequences);
width = length(sequences(1,:));
numIterations = 10;
windowSize = 10;
initialState = ones(1,132);
initialScores = [];
state = ones(1,132);
index2char = 'atgc';

%set identical local pattern
%pattern = sequences(1,1:windowSize); %set this is repeating pattern
for i = 1:numSeq
    offset = randi([1,(width - (windowSize-1))],1,1) - 1;
    state(i) = offset;
end
maxOffset = max(state);
for e = 1:numSeq
    offset = state(e);
    spacing = repelem(' ', maxOffset - offset);
    fprintf([spacing sequences(e,1:offset) ' | ' sequences(e,(offset+1):(offset+windowSize-1)) ' | ' sequences(e,(offset+windowSize):end) '\n'])
end

