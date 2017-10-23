function data = make_data(bnet,exp,obs)
% function data = make_data(bnet,experiments,observations)
% generates exp many datasets of obs many observations
% NOTE: this script makes data in the format used by Causal_Explorer
% Rows are observations // Columns are variables! 
% BNT format is row = var, col = obs
% july 10, 2012 - khaldoon {khaldoon@gatech.edu}

nodes = length(bnet.node_sizes);
data = cell(1,exp);

for i = 1:exp
    data_tmp = zeros(obs,nodes);
    for j = 1:obs
        data_tmp(j,:) = cell2num(sample_bnet(bnet));
    end
    data{i} = data_tmp-ones(obs,nodes); % correct for Causal_Explorer (min = 0)
end