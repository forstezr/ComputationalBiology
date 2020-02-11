function [beginning, ending, sequence] = handleEnds(sequence)
beginning = '';
ending = '';

numChar = length(sequence{1});
oneInd = strfind(sequence, '1');
startInd = oneInd(1);
endInd = oneInd(end);

if(startInd > 1)
    beginning = sequence{1}(1:startInd-1);
    %beginning = [beginning ' '];
end
if(endInd < numChar)
    ending = sequence{1}(endInd+1:end);
    %ending = [' ' ending];
end

sequence{1} = sequence{1}(startInd:endInd);