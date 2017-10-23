function domain_counts = get_domain_counts(networkName)
% get the domain counts of a network from its data

%% load data
load([networkName '_data'])
clear networkName

%% find maximum value of node observations
for i = 1:length(data)
%     data_to_parse = data{i};
    maxVecs(i,:) = max(data{i});
end
maxVec = max(maxVecs);
domain_counts = maxVec + ones(1,length(maxVec));

%% cleanup and save result
clear i data maxVecs maxVec graph
save([network.Name '_dc'])