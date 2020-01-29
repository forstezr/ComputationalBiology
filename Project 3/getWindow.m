function [window] = getWindow(sequences, state, windowSize)
    %window = zeros(length(sequences), windowSize);
    window = '';
    for i =1:length(sequences)
        window(i,:) = sequences(i,state(i):state(i)+windowSize-1);
    end

end