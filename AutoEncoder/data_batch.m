% Version 1.000
%
% Code provided by gyn
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with
% a note saying that the original programs are available from our
% web page.
% The programs and documents are distributed without any warranty, express or
% implied.  As the programs were written for research purposes only, they have
% not been tested to the degree that would be advisable in any important
% application.  All use of these programs is entirely at the user's own risk.

dim = 6198;
corpusdata = load_matrix('matFiles/1_matrix_of_zhidao.txt', dim); 

totnum = size(corpusdata,1);
fprintf(1, 'Size of the training dataset= %5d \n', totnum);
disp('batching training data...')
numbatches = totnum/9901;
numdims = dim; %size(corpusdata,2);
batchsize = 9901;
batchdata = zeros(batchsize, numdims, numbatches);

for b=1:numbatches
  batchdata(:,:,b) = corpusdata((b-1)*batchsize+1:b*batchsize,:);
end;
clear corpusdata

querydata = load_matrix('matFiles/1_matrix_of_zhidao.que',dim);
totnum=size(querydata,1);
fprintf(1, 'Size of the query dataset= %5d \n', totnum);

querysize = 2045;
numbatches = totnum/querysize;
numdims = dim; %size(querydata,2);
batchsize = querysize;
testbatchdata = zeros(batchsize, numdims, numbatches);

disp('batching query data...')
for b=1:numbatches
  testbatchdata(:,:,b) = querydata((b-1)*batchsize+1:b*batchsize,:);
end;
clear querydata querysize


%%% Reset random seeds 
rand('state',sum(100*clock)); 
randn('state',sum(100*clock)); 
