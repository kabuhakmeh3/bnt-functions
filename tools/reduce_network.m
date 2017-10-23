function [reduced_dag reduced_data reduced_ns] = reduce_network(dag,data,node_sizes,nodesToKeep)
% function [reduced_dag reduced_data reduced_ns] = reduce_network(dag,data,node_sizes,nodesToKeep)
% reduce a large network to a smaller network
% this is designed for Causal_Explorer data format
% for bnt, give data = data'
% khaldoon {khaldoon@gatech.edu}- June 15, 2012

%% initialize values of written variables
if iscell(data) == 1
    [obs pre_nodes] = size(data{1});
else
    [obs pre_nodes] = size(data);
end
post_nodes = length(nodesToKeep);
reduced_ns = zeros(1,post_nodes);
temp_dag = zeros(post_nodes,pre_nodes);
reduced_dag = zeros(post_nodes);


%% routine to reduce data and node sizes
for i = 1:post_nodes
    reduced_ns(i) = node_sizes(nodesToKeep(i));
%     reduced_data(:,i) = data(:,nodesToKeep(i));   
    temp_dag(i,:) = dag(nodesToKeep(i),:);
    for j = 1:post_nodes
        reduced_dag(:,j) = temp_dag(:,nodesToKeep(j));
    end
end


%% depending on datatype, returns a matrix or a cell of datasets
if iscell(data) == 0
    
    reduced_data = zeros(obs,post_nodes);
    for k = 1:post_nodes
        reduced_data(:,k) = data(:,nodesToKeep(k));
    end
    
elseif iscell(data) == 1
    
    reduced_data = cell(1,length(data));
    for m = 1:length(data)
        tmp = zeros(obs,post_nodes);
        tmp_data = data{m};
        for n = 1:post_nodes
            tmp(:,n) = tmp_data(:,nodesToKeep(n));
        end
        reduced_data{m} = tmp;
    end
    
end

% this is functional.
    
    