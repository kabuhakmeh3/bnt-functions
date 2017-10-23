% create an 'undirected' graph for comparison
% where parent > child

[a b] = size(graph);
ud_graph=zeros(a,b);
changed_edges = 0;
for i = 1:a
    for j = 1:b
        if graph(i,j) == 1 && i>j
            ud_graph(i,j) = 1;
        elseif graph(i,j) == 1 && j>i
            disp([num2str(i) ' and ' num2str(j) ' are in reverse order!'])
            ud_graph(j,i) = 1;
            changed_edges = changed_edges + 1;
        end
    end
end
disp('total reversed edges:')
disp(changed_edges)
clear a b 