% characterize a network

%% identify nodes to eliminate
% max_init = max(domain_counts)
% max_rest = max(reduced_ns)
% ns = domain_counts
% thres = max_rest;
% thres = 4;


% ns = bnet.node_sizes;
% kept_nodes = length(ns);
% for i = 1:length(ns)
%     if ns(i) > thres
% %         disp(['node ' num2str(i) ' exceeds the limit!'])
%         kept_nodes = kept_nodes - 1;
%     end
% end
% disp('kept nodes')
% disp(kept_nodes)

%%

% initialize
% node | size | parents | children | cpd col | cpd row | cpd elements
% cpd rows are the multiple of parent node sizes

reduc_stats = zeros(length(reduced_ns),7);
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