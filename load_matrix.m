function mat=load_matrix(sp_mat, dim)
% sp_mat: sparse matrix file, each row is a point, and the elements is the positions of the points
%         where has 1
% dim: dimension of normal matrix
% mat: output the normal matrix.

% e.g. input file * contains: 2 3
%                             1 3 
%      output matrix: [0 1 1;1 0 1]

[fid1,message] = fopen(sp_mat,'r');
if fid1 == -1
    display(message)
    return
end
sz=0;
tic;
disp('counting dataset size...');
while ~feof(fid1)
    fgetl(fid1);
    sz = sz+1;
end
display(['Count size time:',num2str(toc)])
fclose(fid1);
tic;
[fid2,msg] = fopen(sp_mat,'r');
if fid2 == -1
    display(message)
    return
end
display(sz)
mat = zeros([sz,dim],'int8');
idx = 0;
while ~feof(fid2)
    aline = fgetl(fid2);
    idx = idx+1;
    if mod(idx, 50000) == 0
        display(['Used time:',num2str(toc)])
        tic;
        display(idx)
    end
    %mat(sz,:)=zeros(1, dim);
    aline = regexp(aline, ' ', 'split');
    loc_num = size(aline,2)-1; % there is a space in the end of each row of the input file
    aline = aline(:, 1:loc_num);
    aline_l = zeros(1, loc_num);
    for i = 1:loc_num
         aline_l(i) = str2num(aline{1,i});
    end
    for loc = aline_l
        mat(idx,loc)=1;
    end
end
display(['Used time:',num2str(toc)])
fclose(fid2);
