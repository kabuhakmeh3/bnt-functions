function [A_mmhc A_prior A_thres] = opt_mmhc(data,domain_counts)
% [A_mmhc A_prior A_thres] = opt_mmhc(data,domain_counts)
% returns set of DAGs containing the most average edges
% DAG structure is inferred by Max-Min Hill Climbing (Brown et al., 2004)

% results will be used in a voting method to learn DAGs

% khaldoon - may 14, 2012
% kabuhakmeh@gmail.com

%% set environment variables
experiments = length(data);
[observations nodes] = size(data{1});
thres_range = [0.05 0.5 1 2];
prior_types = fieldnames(struct('unif',1,...
                                'BDeu',2));
%% initialize values
A_mmhc = cell(1,experiments);
tmp_mmhc = cell(1,experiments);
A_edges = zeros(1,experiments);
tmp_edges = zeros(1,experiments);
% t_ind = 1;
% p_ind = 1;

%% determine inital (default) values
for j = 1:experiments
%     options.threshold = thres_range(t_ind);
%     options.epc = 5; 
%     options.maxK = 10; 
%     options.use_card_lim = 0; 
%     options.max_card = 0;
    try
    A_mmhc{j} = Causal_Explorer('MMHC',data{j},domain_counts,...
                                'MMHC',[],10,'unif');
    A_mmhc{j} = A_mmhc{j} + zeros(nodes);   
    A_edges(j) = sum(sum(A_mmhc{j}));
    % mmhc does not converge for certain cases...must replace missing
    % values: here, we use the mean number of edges from all others in the
    % set to replace the missing value. for the first case, if it does not
    % converge, the value is assigned a 'zero'.
    catch
        disp('error in default case...moving along')
        A_mmhc{j} = zeros(nodes);
        if j == 1
            A_edges(j) = 0;
        else
            A_edges(j) = mean(A_edges(1:j-1));
        end
    end
end
A_mean = nanmean(A_edges);
A_prior = 'unif';
A_thres = 0.05;
% trial for better stats
A_std = nanstd(A_edges);
%% infer structure, changing threshold and prior

% THIS IS SLOW 
% and a bad idea when things get bigger
for a = 1:length(prior_types)
    if a == 1
        prior = 'unif';
    elseif a == 2
        prior = 'BDeu';
    end
%     prior = prior_types(a);
    for b = 1:length(thres_range)
        options.threshold = thres_range(b); options.epc = 5;
        options.maxK = 10; options.use_card_lim = 0; options.max_card = 0;
        switch prior
            case 'unif'
                for i = 1:experiments
                    try
                    tmp_mmhc{i} = Causal_Explorer('MMHC',data{i},domain_counts,...
                                                  'MMHC',options,10,'unif');
                    tmp_mmhc{i} = tmp_mmhc{i} + zeros(nodes);
                    tmp_edges(i) = sum(sum(tmp_mmhc{i}));
                    % see explanation above for the routine below
                    catch
                        disp(['error in ' prior ' at threshold ' num2str(thres_range(b))])
                        tmp_mmhc{i} = zeros(nodes);
                        if i == 1
                            tmp_edges(i) = 0;
                        else
                            tmp_edges(i) = mean(tmp_edges(1:i-1));
                        end
                    end
                end
            case 'BDeu'
                for i = 1:experiments
                    try
                    tmp_mmhc{i} = Causal_Explorer('MMHC',data{i},domain_counts,...
                                                  'MMHC',options,10,'BDeu');
                    tmp_mmhc{i} = tmp_mmhc{i} + zeros(nodes);
                    tmp_edges(i) = sum(sum(tmp_mmhc{i}));
                    % see explanation above for the routine below
                    catch
                        disp(['error in ' prior ' at threshold ' num2str(thres_range(b))])
                        tmp_mmhc{i} = zeros(nodes);
                        if i == 1
                            tmp_edges(i) = 0;
                        else
                            tmp_edges(i) = mean(tmp_edges(1:i-1));
                        end
                    end
                end
        end
        tmp_mean = nanmean(tmp_edges);
        tmp_std = nanstd(tmp_edges);
        % use standard deviations 
        % helps reduce computations
        if tmp_mean > A_mean + A_std
            % should consider doing better statistics!!!
            % this is not a fool-proof metric
            A_mmhc = tmp_mmhc;
            A_prior = prior_types(a);
            A_thres = thres_range(b);
            A_mean = tmp_mean;
            A_std = tmp_std;
        end
    end
end

