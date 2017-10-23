%% voting method
% this routine performes several tasks
% 1. makes directed graphs from pdags [tdpa and pc]
% 2. makes undirected graphs for all algorithms
% 3. gets performance metrics for both directed and undirected graphs
%    [edit distance, true positives, selectivity, sensitivity, specificity]

% run_hybrid.m script used to load alarm_hybrid_x.mat files
% execute alarm_voting.m
% save alarm_voting_x.mat

%% environment variables
reps = length(data);
nodes = length(domain_counts);

%% tasks to complete

% orient PC and TDPA                   {{ ONLY EXECUTE THIS ROUTINE ONCE }}
pd_pc = A_pc;               % define pdags of PC and TDPA
pd_tdpa = A_tdpa;

% directed (pc and tdpa only)
% this will be A_pc and A_tdpa

%% undirect the dag (also available in 'undirect_dag)
[c d] = size(graph);
ud_graph=zeros(c,d);

for k = 1:c
    for l = 1:d
        if graph(k,l) == 1 && k>l
            ud_graph(k,l) = 1;
        elseif graph(k,l) == 1 && l>k
%             disp([num2str(k) ' and ' num2str(l) ' are in reverse order!'])
            ud_graph(l,k) = 1;
        end
    end
end

%% undirected (all algorithms)
ud_mmhc = cell(1,10); ud_sca = cell(1,10);     % undirected graphs
ud_pc = cell(1,10); ud_tdpa = cell(1,10);      % simply all nodes i > j

%% make directed and equivalence structures for ALL algorithm results
for i = 1:reps
    dir_pc = zeros(nodes); dir_tdpa = zeros(nodes);
    mmhc_post = zeros(nodes); sca_post = zeros(nodes);
    pc_post = zeros(nodes); tdpa_post = zeros(nodes);
    mmhc_pre = A_mmhc{i}; sca_pre = A_sca{i};
    pc_pre = A_pc{i}; tdpa_pre = A_tdpa{i};
    for a = 1:nodes
        for b= 1:nodes
            %% mmhc [A_mmhc is a directed structure]
            % make undirected graphs
            if mmhc_pre(a,b)== 1 && a>b
                mmhc_post(a,b) = 1;
            elseif mmhc_pre(a,b) == 1 && a<b
                mmhc_post(b,a) = 1;
            end            
            %% sca
            % make undirected graphs
            if sca_pre(a,b)== 1 && a>b
                sca_post(a,b) = 1;
            elseif sca_pre(a,b) == 1 && a<b
                sca_post(b,a) = 1;
            end
            
            %% pc [partially directed]
            % make undirected graphs
            if pc_pre(a,b)== 1 && a>b
                pc_post(a,b) = 1;
            elseif pc_pre(a,b) == 1 && a<b
                pc_post(b,a) = 1;
            elseif pc_pre(a,b) == 2 && a>b
                pc_post(a,b) = 1;
            end
            % for directed graph
            if pc_pre(a,b) == 1
                dir_pc(a,b) = 1;
            elseif pc_pre(a,b) == 2 && a>b
                dir_pc(a,b) = 1;
            end
            
            %% tdpa
            % make undirected graphs
            if tdpa_pre(a,b)== 1 && a>b
                tdpa_post(a,b) = 1;
            elseif tdpa_pre(a,b) == 1 && a<b
                tdpa_post(b,a) = 1;
            elseif tdpa_pre(a,b) == 2 && a>b
                tdpa_post(a,b) = 1;
            end
%             elseif pc_pre(a,b) == 2 && a>b
%                 pc_post(a,b) = 1;
%             end
            % for directed graph
%             if pc_pre(a,b) == 1
%                 dir_pc(a,b) = 1;
%             elseif pc_pre(a,b) == 2 && a>b
%                 dir_pc(a,b) = 1;
%             end
            if tdpa_pre(a,b) == 1
                dir_tdpa(a,b) = 1;
            elseif tdpa_pre(a,b) == 2 && a>b
                dir_tdpa(a,b) = 1;
            end
        end
    end
    
    %% assign temporary values to cell
    A_pc{i} = dir_pc; A_tdpa{i} = dir_tdpa;
    ud_mmhc{i} = mmhc_post; ud_sca{i} = sca_post;
    ud_pc{i} = pc_post; ud_tdpa{i} = tdpa_post;
    
    %% compute metrics for original DAGS
    % editing distance
    D_mmhc(i) = editing_dist(graph,A_mmhc{i});
    D_sca(i) = editing_dist(graph,A_sca{i});
    D_pc(i) = editing_dist(graph,A_pc{i});
    D_tdpa(i) = editing_dist(graph,A_tdpa{i});
%     sensitivity, selectivity, specificity
    [sens_mmhc(i) sel_mmhc(i) spec_mmhc(i)] = algperf(A_mmhc{i},graph);
    [sens_sca(i) sel_sca(i) spec_sca(i)] = algperf(A_sca{i},graph);
    [sens_pc(i) sel_pc(i) spec_pc(i)] = algperf(A_pc{i},graph);
    [sens_tdpa(i) sel_tdpa(i) spec_tdpa(i)] = algperf(A_tdpa{i},graph);
    
    %% compute metrics for undirected graphs
    % editing distance
    D_ud_mmhc(i) = editing_dist(ud_graph,ud_mmhc{i});
    D_ud_sca(i) = editing_dist(ud_graph,ud_sca{i});
    D_ud_pc(i) = editing_dist(ud_graph,ud_pc{i});
    D_ud_tdpa(i) = editing_dist(ud_graph,ud_tdpa{i});
%     sensitivity, selectivity, specificity
    [sens_ud_mmhc(i) sel_ud_mmhc(i) spec_ud_mmhc(i)] = algperf(ud_mmhc{i},ud_graph);
    [sens_ud_sca(i) sel_ud_sca(i) spec_ud_sca(i)] = algperf(ud_sca{i},ud_graph);
    [sens_ud_pc(i) sel_ud_pc(i) spec_ud_pc(i)] = algperf(ud_pc{i},ud_graph);
    [sens_ud_tdpa(i) sel_ud_tdpa(i) spec_ud_tdpa(i)] = algperf(ud_tdpa{i},ud_graph);
    
end


%% cleanup
clear reps nodes i k l a b c d mmhc_pre sca_pre pc_pre tdpa_pre mmhc_post sca_post pc_post tdpa_post dir_pc dir_tdpa
% clear reps nodes i a b mmhc_pre sca_pre mmhc_post sca_post