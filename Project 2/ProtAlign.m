function [aligned,score] = ProtAlign(sequence1,sequence2, tau, traceBack)
% 
% function [aligned,score] = ProtAlign(sequence1,sequence2)
% 
% Aligns two sequences to have the lowest possible score
% 
% INPUTS: 
% sequence1 - the first sequence to align
% sequence2 - the second sequence to align
% 
% OUTPUTS:
% aligned - the aligned sequences
% score - the final score of the aligned sequences
% 
N = length(sequence1)+1;
M = length(sequence2)+1;
aligned = 0;

%marix setup
mat = zeros(N, M, 2);
mat(1,:,1) = 0:tau:((M-1)*tau);
mat(:,1,1) = [0:tau:((N-1)*tau)]';
mat(:,1,2) = 3;
mat(1,:,2) = 2;
mat(1,1,2) = 0;
%second layer of matrix used to do traceback of shortest path

%calculate score
format long
for row = 2:N
    %loop through mat to fill in costs (1st row and col filled already)
    for col = 2:M
        value1 = str2double(sequence1(row-1)); %sequence 1 in y axis
        value2 = str2double(sequence2(col-1)); %sequence 2 in x axis
        pred = [mat(row-1,col-1)+(abs(value1-value2)/abs(value1+value2)), mat(row,col-1,1)+tau, mat(row-1,col)+tau]; %add penalty
        [mat(row,col,1),mat(row,col,2)] = min(pred);
    end
end
score = mat(N,M,1);
%trace = mat(:,:,1)

if(traceBack == 1)
    stop = false;
    tbRow = N; %start in bottom corner
    tbCol = M;
    seq1 = '';
    seq2 = '';
    while stop ~= true
        switch mat(tbRow,tbCol,2)
            case 0
                %break
                stop = true;
            case 1
                %diagonal, so pair
                seq1 = [sequence1(tbRow - 1) seq1];
                seq2 = [sequence2(tbCol - 1) seq2];
                tbRow = tbRow - 1;
                tbCol = tbCol - 1;
            case 2
                %left so gap
                seq1 = ['_' seq1];
                seq2 = [sequence2(tbCol - 1) seq2];
                tbCol = tbCol - 1;
            case 3
                %above so gap
                seq1 = [sequence1(tbRow - 1) seq1];
                seq2 = ['_' seq2];
                tbRow = tbRow - 1;
        end
    end
    aligned = {seq1 ; seq2};
end
