function [A_tdpa A_stat A_thres] = opt_tdpa(data,domain_counts)
% [A_sca A_param A_thres] = opt_sca(data,domain_counts)
% returns set of PDAGs containing the most average edges
% PDAG structure is inferred by BNPC/TDPA Algorithm (Cheng)

% results will be used in a voting method to learn DAGs

% khaldoon - may 23, 2012
% kabuhakmeh@gmail.com

%% set environment variables
experiments = length(data);
% [observations nodes] = size(data{1});

%% initialize values
A_tdpa = cell(1,experiments);
% tmp_sca = cell(1,experiments);
% A_edges = zeros(1,experiments);
% tmp_edges = zeros(1,experiments);

%% determine inital (default) values
for j = 1:experiments
    % default TDPC: g2, thres = 0.05, no flag, not monotone faithful (Chickering, 2003)
    try
        A_tdpa{j} = Causal_Explorer('TPDA', data{j}, domain_counts, 'g2', 0.05, 0, 0);
    catch
        disp(['error in TDPA learning dataset ' num2str(j) ' moving right along...'])
        A_tdpa{j} = zeros(length(domain_counts));
    end
%     A_edges(j) = sum(sum(A_tdpa{j}));
end

% A_mean = nanmean(A_edges);
% trial for better stats
% A_std = nanstd(A_edges);
A_stat = 'g2';
A_thres = 0.05;