%% bootstrap aggregating (bagging)
% each of four algorithms receives an equal vote in determining structure
% performed for both directed and undirected cases
% ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---
% 1. union - any edge appearing in any ONE of inference results
% 2. half - edges conserved in TWO inference results
% 3. majority - edges conserved in THREE inference results
% 4. intersection - edges conserved in FOUR (all) inference results
% ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---
% also return metrics [D_edit, tp, sel, sens, spec] of bagged graphs
% ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---   ---

% clean up and vote - mean of metrics

% union of all
% intersection of all

% union of three
% intersection of three

% union of two
% intersection of two

%% add all nodes
reps = length(data); nodes = length(domain_counts);

dir_sum = cell(1,10); ud_sum = cell(1,10);          % all edges        
A_union = cell(1,10); ud_union = cell(1,10);        % at least one dag          (1,4)
A_half = cell(1,10); ud_half = cell(1,10);          % half of dags              (2/4)
A_maj = cell(1,10); ud_maj = cell(1,10);            % majority of dags          (3/4)
A_int = cell(1,10); ud_int = cell(1,10);            % intersection of edges     (4/4)
% for correction
ud_sum = cell(1,10); ud_union = cell(1,10); ud_half = cell(1,10); ud_maj = cell(1,10); ud_int = cell(1,10); 
for i = 1:reps
    % compute union of directed and undirected graphs
    dir_sum{i} = A_mmhc{i} + A_sca{i} + A_pc{i} + A_tdpa{i};       % sum directed
    ud_sum{i} = ud_mmhc{i} + ud_sca{i} + ud_pc{i} + ud_tdpa{i};  % sum undirected
    
    % temporary values
    dir_tmp = dir_sum{i}; und_tmp = ud_sum{i};
    ud_tmp = zeros(nodes); uu_tmp = zeros(nodes);
    hd_tmp = zeros(nodes); hu_tmp = zeros(nodes);
    md_tmp = zeros(nodes); mu_tmp = zeros(nodes);
    id_tmp = zeros(nodes); iu_tmp = zeros(nodes);
    und_tmp = ud_sum{i};
    uu_tmp = zeros(nodes);
    hu_tmp = zeros(nodes);
    mu_tmp = zeros(nodes);
    iu_tmp = zeros(nodes);
    % make dags
    for a = 1:nodes
        for b = 1:nodes 
            %% union
            % directed
            if dir_tmp(a,b) >= 1
                ud_tmp(a,b) = 1;
            end
            % undirected
            if und_tmp(a,b) >= 1
                uu_tmp(a,b) = 1;
            end
            %% half
            % directed
            if dir_tmp(a,b) >= 2
                hd_tmp(a,b) = 1;
            end
            % undirected
            if und_tmp(a,b) >= 2
                hu_tmp(a,b) = 1;
            end
            %% majority
            % directed
            if dir_tmp(a,b) >= 3
                md_tmp(a,b) = 1;
            end
            % undirected
            if und_tmp(a,b) >= 3
                mu_tmp(a,b) = 1;
            end
            %% intersection (unanimous)
            % directed
            if dir_tmp(a,b) >= 4
                id_tmp(a,b) = 1;
            end
            % undirected
            if und_tmp(a,b) >= 4
                iu_tmp(a,b) = 1;
            end
        end
    end
    A_union{i} = ud_tmp; ud_union{i} = uu_tmp;
    A_half{i} = hd_tmp; ud_half{i} = hu_tmp;
    A_maj{i} = md_tmp; ud_maj{i} = mu_tmp;
    A_int{i} = id_tmp; ud_int{i} = iu_tmp;
    ud_union{i} = uu_tmp;
    ud_half{i} = hu_tmp;
    ud_maj{i} = mu_tmp;
    ud_int{i} = iu_tmp;
end

%% more metrics
for h = 1:10
    % directed
    [sens_A_union(h) sel_A_union(h) spec_A_union(h)] = algperf(A_union{h},graph);
    [sens_A_half(h) sel_A_half(h) spec_A_half(h)] = algperf(A_half{h},graph);
    [sens_A_maj(h) sel_A_maj(h) spec_A_maj(h)] = algperf(A_maj{h},graph);
    [sens_A_int(h) sel_A_int(h) spec_A_int(h)] = algperf(A_int{h},graph);
    
    D_A_union(h) = editing_dist(graph,A_union{h}); tp_A_union(h) = correct_edges(A_union{h},graph);
    D_A_half(h) = editing_dist(graph,A_half{h}); tp_A_half(h) = correct_edges(A_half{h},graph);
    D_A_maj(h) = editing_dist(graph,A_maj{h}); tp_A_maj(h) = correct_edges(A_maj{h},graph);
    D_A_int(h) = editing_dist(graph,A_int{h}); tp_A_int(h) = correct_edges(A_int{h},graph);
    % undirected
    [sens_ud_union(h) sel_ud_union(h) spec_ud_union(h)] = algperf(ud_union{h},ud_graph);
    [sens_ud_half(h) sel_ud_half(h) spec_ud_half(h)] = algperf(ud_half{h},ud_graph);
    [sens_ud_maj(h) sel_ud_maj(h) spec_ud_maj(h)] = algperf(ud_maj{h},ud_graph);
    [sens_ud_int(h) sel_ud_int(h) spec_ud_int(h)] = algperf(ud_int{h},ud_graph);
    
    D_ud_union(h) = editing_dist(ud_graph,ud_union{h}); tp_ud_union(h) = correct_edges(ud_union{h},ud_graph);
    D_ud_half(h) = editing_dist(ud_graph,ud_half{h}); tp_ud_half(h) = correct_edges(ud_half{h},ud_graph);
    D_ud_maj(h) = editing_dist(ud_graph,ud_maj{h}); tp_ud_maj(h) = correct_edges(ud_maj{h},ud_graph);
    D_ud_int(h) = editing_dist(ud_graph,ud_int{h}); tp_ud_int(h) = correct_edges(ud_int{h},ud_graph);
    
    %% additional stuff - true positives for directed and undirected
     
    tp_A_mmhc(h) = correct_edges(A_mmhc{h},graph);
    tp_A_sca(h) = correct_edges(A_sca{h},graph);
    tp_A_pc(h) = correct_edges(A_pc{h},graph);
    tp_A_tdpa(h) = correct_edges(A_tdpa{h},graph);
    
    tp_ud_mmhc(h) = correct_edges(ud_mmhc{h},ud_graph);
    tp_ud_sca(h) = correct_edges(ud_sca{h},ud_graph);
    tp_ud_pc(h) = correct_edges(ud_pc{h},ud_graph);
    tp_ud_tdpa(h) = correct_edges(ud_tdpa{h},ud_graph);
end
   

clear i h a b reps nodes ud_tmp uu_tmp hd_tmp hu_tmp md_tmp mu_tmp id_tmp iu_tmp
% clear i h a b reps nodes uu_tmp hu_tmp mu_tmp iu_tmp
