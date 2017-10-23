function [A_sca A_param A_thres] = opt_sca(data,domain_counts)
% [A_sca A_param A_thres] = opt_sca(data,domain_counts)
% returns set of DAGs containing the most average edges
% DAG structure is inferred by Sparse Candidate Algorithm (Friedman et al., 2000)

% results will be used in a voting method to learn DAGs

% khaldoon - may 14, 2012
% kabuhakmeh@gmail.com

%% set environment variables
experiments = length(data);
[observations nodes] = size(data{1});
k_range = [5 10 20];
param_cases = fieldnames(struct('unif_ms',1,...
                                'unif_mi',2,...
                                'BDeu_ms',3,...
                                'BDeu_mi',4));
%% determine k range ... only if necessary...shouldn't be!
% if length(domain_counts) == 441
%     k_range = [5 10 20 40]; % a special case for "pigs" network...may take long
% else
%     k_range = [5 10 20];
% end
%% initialize values
A_sca = cell(1,experiments);
tmp_sca = cell(1,experiments);
A_edges = zeros(1,experiments);
tmp_edges = zeros(1,experiments);

%% determine inital (default) values
for j = 1:experiments
    try
        A_sca{j} = Causal_Explorer('SCA',data{j},domain_counts,5,10,'BDeu','ms');
        A_sca{j} = A_sca{j} + zeros(nodes);   
        A_edges(j) = sum(sum(A_sca{j}));
    catch
        disp('error in default case...moving along')
        A_sca{j} = zeros(nodes);
        if j == 1
            A_edges(j) = 0;
        else
            A_edges(j) = mean(A_edges(1:j-1));
        end
    end
end
A_mean = nanmean(A_edges);
A_param = 'BDeu_ms';
A_thres = 0.05;
% trial for better stats
A_std = nanstd(A_edges);

%% infer structure, changing threshold and prior

% THIS IS SLOW 
% and a bad idea when things get bigger
for a = 1:length(param_cases)
    if a == 1
        param = 'unif_ms';
    elseif a == 2
        param = 'unif_mi';
    elseif a == 3
        param = 'BDeu_ms';
    elseif a == 4
        param = 'BDeu_mi';
    end
%     prior = prior_types(a);
    for b = 1:length(k_range)
        switch param
            case 'unif_ms'
                for i = 1:experiments
                    try
                    tmp_sca{i} = Causal_Explorer('SCA',data{i},domain_counts,k_range(b),10,'unif','ms');
                    tmp_sca{i} = tmp_sca{i} + zeros(nodes);
                    tmp_edges(i) = sum(sum(tmp_sca{i}));
                    catch
                        disp(['error in ' param ' at threshold ' num2str(k_range(b))])
                        tmp_sca{i} = zeros(nodes);
                        if i == 1
                            tmp_edges(i) = 0;
                        else
                            tmp_edges(i) = mean(tmp_edges(1:i-1));
                        end   
                    end
                end
            case 'unif_mi'
                for i = 1:experiments
                    try
                    tmp_sca{i} = Causal_Explorer('SCA',data{i},domain_counts,k_range(b),10,'unif','mi');
                    tmp_sca{i} = tmp_sca{i} + zeros(nodes);
                    tmp_edges(i) = sum(sum(tmp_sca{i}));
                    catch
                        disp(['error in ' param ' at threshold ' num2str(k_range(b))])
                        tmp_sca{i} = zeros(nodes);
                        if i == 1
                            tmp_edges(i) = 0;
                        else
                            tmp_edges(i) = mean(tmp_edges(1:i-1));
                        end 
                    end
                end
            case 'BDeu_ms'
                for i = 1:experiments
                    try
                    tmp_sca{i} = Causal_Explorer('SCA',data{i},domain_counts,k_range(b),10,'BDeu','ms');
                    tmp_sca{i} = tmp_sca{i} + zeros(nodes);
                    tmp_edges(i) = sum(sum(tmp_sca{i}));
                    catch
                        disp(['error in ' param ' at threshold ' num2str(k_range(b))])
                        tmp_sca{i} = zeros(nodes);
                        if i == 1
                            tmp_edges(i) = 0;
                        else
                            tmp_edges(i) = mean(tmp_edges(1:i-1));
                        end 
                    end
                end
            case 'BDeu_mi'
                for i = 1:experiments
                    try
                    tmp_sca{i} = Causal_Explorer('SCA',data{i},domain_counts,k_range(b),10,'BDeu','mi');
                    tmp_sca{i} = tmp_sca{i} + zeros(nodes);
                    tmp_edges(i) = sum(sum(tmp_sca{i}));
                    catch
                        disp(['error in ' param ' at threshold ' num2str(k_range(b))])
                        tmp_sca{i} = zeros(nodes);
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
            A_sca = tmp_sca;
            A_param = param_cases(a);
            A_thres = k_range(b);
            A_mean = tmp_mean;
            A_std = tmp_std;
        end
    end
end

