function [score, recall, retrieved_total] = evaluation(Wtrue, Dhat)
%
% Input:
%    Wtrue = true neighbors [Ntest * Ndataset], can be a full matrix NxN
%    Dhat  = estimated distances
%   The next inputs are optional:
%    fig = figure handle
%    options = just like in the plot command
%
% Output:
%
%               exp. # of good pairs inside hamming ball of radius <= (n-1)
%  score(n) = --------------------------------------------------------------
%               exp. # of total pairs inside hamming ball of radius <= (n-1)
%
%               exp. # of good pairs inside hamming ball of radius <= (n-1)
%  recall(n) = --------------------------------------------------------------
%                          exp. # of total good pairs 

[Ntest, Ntrain] = size(Wtrue);
total_good_pairs = sum(Wtrue(:))
query_num = 2000;
display('good_pairs_per_query:');
display(total_good_pairs/query_num);
% find pairs with similar codes
num = 15;
score = zeros(num,1);
recall = zeros(num,1);
retrieved_good = zeros(num,1);
retrieved_total = zeros(num,1);
for n = 1:length(score)
    j = find(Dhat<=((n-1)+0.00001));
    
    %exp. # of good pairs that have exactly the same code per query
    retrieved_good_pairs = sum(Wtrue(j));
    retrieved_good(n) = retrieved_good_pairs/query_num;
    
    % exp. # of total pairs that have exactly the same code per query
    retrieved_pairs = length(j);
    retrieved_total(n) = retrieved_pairs/query_num;

    score(n) = retrieved_good_pairs/retrieved_pairs;
    recall(n)= retrieved_good_pairs/total_good_pairs;
end
display('retrieved good pairs:');
display(retrieved_good);

% The standard measures for IR are recall and precision. Assuming that:
%
%    * RET is the set of all items the system has retrieved for a specific inquiry;
%    * REL is the set of relevant items for a specific inquiry;
%    * RETREL is the set of the retrieved relevant items 
%
% then precision and recall measures are obtained as follows:
%
%    precision = RETREL / RET
%    recall = RETREL / REL 

