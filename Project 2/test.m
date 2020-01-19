protData = readtable('protEnc.dat');

seq1 = split(protData{32,2}, ', ')
seq2 = split(protData{35,2}, ', ')
seq1(end) = [];
seq2(end) = [];
%scores(n,1) = 2;
%scores(n,2) = 3;
[aligned,s] = ProtAlign(seq1, seq2, tau, 0)