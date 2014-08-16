clear all;

maxepoch=1; 
numhid=1024; numpen=512; numpen2=256; numopen=32;
%numhid = 500; numpen = 250; numpen2 = 128; numopen = 64;

fprintf(1,'Learning a deep autoencoder. \n');
%fprintf(1,'The Science paper used 50 epochs. This uses %3i \n', maxepoch);

%makebatches;
data_batch;
[numcases numdims numbatches]=size(batchdata);
[testnumcases numdims testnumbatches]=size(testbatchdata);

weights = load('zhidao_weights.mat');

fprintf(1,'Learning Layer 1 with RBM: %d-%d \n',numdims,numhid);
restart=1;
rows = size(weights.w1,1)
vishid = weights.w1(1:rows-1,:);
hidbiases = weights.w1(rows,:);
disp('train dataset part:')
[batchposhidprobs, batchposhidstates]=learnrbm(batchdata, numhid, vishid, hidbiases, maxepoch, restart);
disp('test dataset part:');
[testbatchposhidprobs, testbatchposhidstates]=learnrbm(testbatchdata, numhid, vishid, hidbiases, maxepoch, restart);

fprintf(1,'\nLearning Layer 2 with RBM: %d-%d \n',numhid,numpen);
batchdata=batchposhidprobs;
testbatchdata=testbatchposhidprobs;
rows = size(weights.w2,1)
vishid = weights.w2(1:rows-1,:);
hidbiases = weights.w2(rows,:);
numhid=numpen;
restart=1;
disp('train dataset part:')
[batchposhidprobs, batchposhidstates]=learnrbm(batchdata, numhid, vishid, hidbiases, maxepoch, restart);
disp('test dataset part:')
[testbatchposhidprobs, testbatchposhidstates]=learnrbm(testbatchdata, numhid, vishid, hidbiases, maxepoch, restart);

fprintf(1,'\nLearning Layer 3 with RBM: %d-%d \n',numpen,numpen2);
batchdata=batchposhidprobs;
testbatchdata=testbatchposhidprobs;
rows = size(weights.w3,1)
vishid = weights.w3(1:rows-1,:);
hidbiases = weights.w3(rows,:);
numhid=numpen2;
restart=1;
disp('train dataset part:')
[batchposhidprobs, batchposhidstates]=learnrbm(batchdata, numhid, vishid, hidbiases, maxepoch, restart);
disp('test dataset part:')
[testbatchposhidprobs, testbatchposhidstates]=learnrbm(testbatchdata, numhid, vishid, hidbiases, maxepoch, restart);

fprintf(1,'\nLearning Layer 4 with RBM: %d-%d \n',numpen2,numopen);
batchdata=batchposhidprobs;
testbatchdata=testbatchposhidprobs;
rows = size(weights.w4,1)
vishid = weights.w4(1:rows-1,:);
hidbiases = weights.w4(rows,:);
numhid=numopen; 
restart=1;
disp('train dataset part:')
[batchposhidprobs, batchposhidstates]=learnrbmhidlinear(batchdata, numhid, vishid, hidbiases, maxepoch, restart);
disp('test dataset part:')
[testbatchposhidprobs, testbatchposhidstates]=learnrbmhidlinear(testbatchdata, numhid, vishid, hidbiases, maxepoch, restart);

batchposhidstates_withGauss = batchposhidprobs > 0;
testbatchposhidstates_withGauss = testbatchposhidprobs > 0;

