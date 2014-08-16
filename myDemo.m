%trainAutoEncoder;
%backprop;
learnAutoEncoder;
disp('AutoEncoder learned...');

[batchsize, dims, numbatches] = size(batchposhidstates_withGauss);
[testbatchsize, dims, testnumbatches] = size(testbatchposhidstates_withGauss);
trainposhidstates_withGauss = zeros(batchsize*numbatches, dims);
%trainposhidprobs_withGauss = zeros(batchsize*numbatches,dims);
testposhidstates_withGauss = zeros(testbatchsize*testnumbatches, dims);
%testposhidprobs_withGauss = zeros(testbatchsize*testnumbatches, dims);

disp('combining poshidstates...');
for batch = 1:numbatches
  trainposhidstates_withGauss((batch-1)*batchsize+1:batch*batchsize,:) = batchposhidstates_withGauss(:,:,batch);
%  trainposhidprobs_withGauss((batch-1)*batchsize+1:batch*batchsize,:) = batchposhidprobs(:,:,batch);
end
for batch = 1:testnumbatches
  testposhidstates_withGauss((batch-1)*testbatchsize+1:batch*testbatchsize,:) = testbatchposhidstates_withGauss(:,:,batch);
%  testposhidprobs_withGauss((batch-1)*testbatchsize+1:batch*testbatchsize,:) = testbatchposhidprobs(:,:,batch);
end
disp('combined..')

disp('compacting bits...')
traincompactstates_withGauss = compactbit(trainposhidstates_withGauss);
testcompactstates_withGauss = compactbit(testposhidstates_withGauss);
disp('compacted..')

disp('computing hamming distance...')
Dhamm_withGauss = hammingDist(testcompactstates_withGauss, traincompactstates_withGauss);
disp('computed..')

disp('loading ground truth neighbors...')
WTrueNeighbor = load_golden('corpus/zhidao_golden_81.txt');
disp('loaded..')

[score_withGauss,recall_withGauss,retrieved_total_withGauss] = evaluation(WTrueNeighbor,Dhamm_withGauss);
