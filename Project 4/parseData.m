function [strseq] = parseData(sequence)

%use regular expresion to parse data regexp
strseq = join(string(sequence)); %make string
strseq = strrep(strseq,' ',''); %remove white space

[front, back, strseq] = handleEnds(strseq);

expression = '(?<=1)([0][0])*(?=1)'; %find even number of zeros
[match,split] = regexp(strseq, expression, 'match','split');
match = cellfun(@(c)[' ' c ' '], match, 'uni',false);
strseq = strjoin(split, match); %uses spaces as even zero breaks

expression = '((?<=1)(1)(?=1))|((?<=1)(1)(?= ))|((?<= )(1)(?=1))'; %find repeating ones
[match,split] = regexp(strseq, expression, 'match','split');
match = cellfun(@(c)[' ' c ' '], match, 'uni',false);
strseq = strjoin(split, match); %uses spaces as even repeating ones breaks
strseq = regexprep(strseq, '1{2,2}', '1 1'); %remove any remaining ones pairs

strseq = regexprep(strseq, '\s{2,}', ' '); %remove extra spaces
strseq = join([front strseq back]);

end

