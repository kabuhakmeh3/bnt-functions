function reduc_stats = characterize_bnet(reduced_dag,reduced_ns)
% function reduc_stats = characterize_bnet(reduced_dag,reduced_ns)
% allows for quick characterization of new bayesian nework after reduction
% note, CPDs will be altered for some nodes
% july 11, 2012 - khaldoon {khaldoon@gatech.edu}

%% figure out CPD dimention

% initialize
% node | size | parents | children | cpd col | cpd row | cpd elements
% cpd rows are the multiple of parent node sizes

%%
% full_stats = zeros(length(domain_counts),7);
reduc_stats = zeros(length(reduced_ns),7);

%%
for j = 1:length(reduced_ns)
   reduc_stats(j,1) = j; 
   reduc_stats(j,2) = reduced_ns(j);
   reduc_stats(j,3) = sum(reduced_dag(:,j)); 
   reduc_stats(j,4) = sum(reduced_dag(j,:)); 
   reduc_stats(j,5) = reduced_ns(j); 
   
   % cpd rows!
   reduc_parents = reduc_stats(j,3);
   if reduc_parents == 0
       reduc_stats(j,6) = 1;
   else
       temp_parents = [];
           for b = 1:length(reduced_ns)
                if reduced_dag(b,j) == 1
                    temp_parents = [temp_parents reduced_ns(b)];
                end
           end
       reduc_stats(j,6) = prod(temp_parents);
   end
   
   reduc_stats(j,7) = reduc_stats(j,5)*reduc_stats(j,6);
end






%% OLD STUFF
%% identify nodes to eliminate
% max_init = max(domain_counts)
% max_rest = max(reduced_ns)
% ns = domain_counts
% thres = max_rest;
% thres = 4;
% ns = bnet.node_sizes;
% 
% for i = 1:length(ns)
%     if ns(i) > thres
%         disp(['node ' num2str(i) ' exceeds the limit!'])
%     end
% end

%% results
% ---- causal explorer -----
% max_init =
%     11
% max_rest =
%      4
% node 26 exceeds the limit!
% node 27 exceeds the limit!
% node 32 exceeds the limit!
% node 37 exceeds the limit!
% node 41 exceeds the limit!
% node 45 exceeds the limit!
% node 51 exceeds the limit!
% node 52 exceeds the limit!
% node 56 exceeds the limit!
% --------- bnt slp --------
% node 26 exceeds the limit!
% node 27 exceeds the limit!
% node 32 exceeds the limit!
% node 37 exceeds the limit!
% node 41 exceeds the limit!
% node 45 exceeds the limit!
% node 51 exceeds the limit!
% node 52 exceeds the limit!
% node 56 exceeds the limit!

%%
% for i = 1:length(domain_counts)
%    full_stats(i,1) = i; 
%    full_stats(i,2) = domain_counts(i);
%    full_stats(i,3) = sum(graph(:,i)); 
%    full_stats(i,4) = sum(graph(i,:)); 
%    full_stats(i,5) = domain_counts(i);
%  
%    % cpd rows!
%    full_parents = sum(graph(:,i));
%    if full_parents == 0
%        full_stats(i,6) = 1;
%    else
%        tmp_parents = [];
%            for a = 1:length(domain_counts)
%                 if graph(i,a) == 1
%                     tmp_parents = [tmp_parents domain_counts(a)];
%                 end
%            end
%        full_stats(i,6) = prod(tmp_parents);
%    end
%    
%    full_stats(i,7) = full_stats(i,5)*full_stats(i,6);
% end