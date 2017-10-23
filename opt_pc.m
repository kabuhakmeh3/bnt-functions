function [A_pc A_stat A_thres] = opt_pc(data,domain_counts)
% [A_sca A_param A_thres] = opt_sca(data,domain_counts)
% returns set of PDAGs containing the most average edges
% PDAG structure is inferred by PC Algorithm (Spirtes et al., 1993)

% results will be used in a voting method to learn DAGs

% khaldoon - may 23, 2012
% kabuhakmeh@gmail.com

%% set environment variables
experiments = length(data);
% [observations nodes] = size(data{1});

%% initialize values
A_pc = cell(1,experiments);
% tmp_sca = cell(1,experiments);
% A_edges = zeros(1,experiments);
% tmp_edges = zeros(1,experiments);

%% determine inital (default) values
for j = 1:experiments
    % default PC: g2, thres = 0.05, no cardinality limit
    try
        A_pc{j} = Causal_Explorer('PC', data{j}, domain_counts, 'g2', 0.05, -1);
    catch
        disp(['error in PC learning dataset ' num2str(j) ' moving right along...'])
        A_pc{j} = zeros(length(domain_counts));
    end
%     A_edges(j) = sum(sum(A_pc{j}));
end

% A_mean = nanmean(A_edges);
% trial for better stats
% A_std = nanstd(A_edges);
A_stat = 'g2';
A_thres = 0.05;