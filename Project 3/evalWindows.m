%process window trial results
fprintf('\\setlength{\\tabcolsep}{2pt}\n')
fprintf('\\begin{longtable}{||c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c||}\n')
for i=10:30
    result = load(sprintf('resultW%d.mat', i));
    fprintf('\\hline \\hline\n')
    fprintf(['\\rowcolor{lightgray} \\multicolumn{31}{|c|}{' sprintf('Window Size: %d',i) '}\\\\\n\\hline\n'])
    fprintf(['R:' ' & \\multicolumn{30}{|l|}{Motif:}' '\\\\\n'])
    fprintf('\\hline\n')
    %fprintf('Motif # |             Motif             |             Likelyhood\n')
    for e=1:2
        fprintf('\\hline')
        fprintf(['\\' sprintf('multirow{2}{1em}{%d}',e) ' & ' '\\multicolumn{30}{l|}{' result.result{1}(e,:) '}\\\\\n'])
        fprintf('\\cline{2-31}\n')
        %loop through the top 5 motifs
        %fprintf([sprintf('   %d    | ', e) result.result{1}(e,:) repelem(' ',(30-i)) '| '])
        for printProb = 1:i
            %fprintf([result.result{1}(e,printProb) sprintf('%1.2f',result.result{2}(e,printProb))])
            fprintf([' & ' result.result{1}(e,printProb)])
        end
        %fprintf(result.result{1}(e,printProb))
        fprintf('\\\\\n')
        for printProb = 1:i
            %fprintf([result.result{1}(e,printProb) sprintf('%1.2f',result.result{2}(e,printProb))])
            fprintf([' & ' sprintf('%1.2f',result.result{2}(e,printProb))])
        end
        %fprintf(sprintf('%1.2f',result.result{2}(e,printProb)))
        fprintf('\\\\\n\\hline\n')
    end
end
fprintf('\\hline\\hline\n')
fprintf('\\end{longtable}\n')

% for i=10:30
%     result = load(sprintf('resultW%d.mat', i));
%     fprintf('\n=========================== Window Size: %d ===========================\n', i)
%     fprintf('Motif # |             Motif             |             Likelyhood\n')
%     for e=1:5
%        %loop through the top 5 motifs
%        fprintf([sprintf('   %d    | ', e) result.result{1}(e,:) repelem(' ',(30-i)) '| '])
%        for printProb = 1:i
%            fprintf([result.result{1}(e,printProb) sprintf('(%1.2f) ',result.result{2}(e,printProb))])
%        end
%        fprintf('\n')
%     end
% end