function reduce_data(networkName)
% function reduce_data(networkName)
% this function makes smaller networks: from 500, to 250, to 100, to 50
% begins by loading a 'network_data' file, 
% containing: graph(nxn), data{1,10},network.struct

%% load data
load([networkName '_data'])
clear networkName
network.Nodes = length(graph);

%% begin reduction
network.dataSizes = [500 250 100 50];
for a = 1:length(network.dataSizes)
    for i = 1:length(data)
        tmp = data{i}; 
        data{i} = tmp(1:network.dataSizes(a),:);
    end
    clear tmp
    save([network.Name '_data_' num2str(network.dataSizes(a))])
end