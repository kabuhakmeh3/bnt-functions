function true_edges = correct_edges(test,true)
% function true_edges = correct_edges(test,true)
% count the number of true positives

[a b]=size(test);
[c d]=size(true);

if a~=b || a~=c || c~=d || b~=d
  error('formats non compatibles: check matrix dimesions');
end
true_edges = 0;
for i = 1:a
    for j = 1:b
        if test(i,j) == 1 && true(i,j) == 1
            true_edges = true_edges + 1;
        end
    end
end