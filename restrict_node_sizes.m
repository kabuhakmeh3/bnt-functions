function [reduced_dag reduced_data reduced_ns] = restrict_node_sizes(dag,data,node_sizes,max_node_size)
% function [reduced_dag reduced_data reduced_ns] = restrict_node_sizes(dag,data,node_sizes,max_node_size)
% eliminate nodes with large domain counts to improve algorithm performance
% reduce a large network to a smaller network
% this is designed for Causal_Explorer data format
% for bnt, give data = data'
% khaldoon {khaldoon@gatech.edu}- June 15, 2012

% create array of nodes to keep along
nodesToKeep = [];
for k = 1:length(node_sizes)
    if node_sizes(k) <= max_node_size
        nodesToKeep = [nodesToKeep k];
    end
end

% call function to reduce network
[reduced_dag reduced_data reduced_ns] = reduce_network(dag,data,node_sizes,nodesToKeep);