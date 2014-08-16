%[testnumber trainnumber]=size(Dhamm);
%trueHamm=zeros(10,trainnumber);
%for i=1:10
%  for j=1:trainnumber
%    trueHamm(i,j)=size(find(testposhidstates(i,:)~=trainposhidstates(j,:)),2);
%  end
%end
diff=zeros([10 trainnumber],'uint8');
DhammR = Dhamm(1:10,:);
R = find(DhammR < 20);
for r=R
  diff = (DhammR(r)~=trueHamm(r));
end
