%% test learning of structures
% compare algorithms
% data size, different datasets
% use: editing_dist, algperf

% khaldoon - march 4, 2012

%% define function
function analyze_structure(nodes,algorithm) 
% nodes = 4; algorithm = 'gs';

%% load data 
if nodes == 4
    network = 'sprinkler';
    reps = 50;
elseif nodes == 8
    network = 'asia';
    reps = 50;
elseif nodes == 27
    network = 'insurance';
    reps = 50; % for mwst, k2, k2wT
%     reps = 1;  % for gs, gswT, ges
elseif nodes == 37
    network = 'alarm';
    reps = 1;
end

load_name = [network, 'Results/', network, '_', algorithm];
load(load_name) 

%% dataset description
% contains: bnet
% adjacency - (nodes x nodes)
% dataN - {1x50}x(nodes x N), N = [50,100,500,1000,5000,10000]
% node_sizes
% networkSizeAlgorithm - eg: asia5000gs {5000 observation greedy search}
data_size=[50 100 500 1000 5000 10000];
%% perform struct analysis
dataToScore = data50{1};                                                    % use this dataset for normalized DAG scoring
sensname = ['sens',network,'_',algorithm];
selname = ['sel',network,'_',algorithm];
specname = ['spec',network,'_',algorithm];
eval([sensname '=[]'])
eval([selname '=[]'])
eval([specname '=[]'])
for a = 1:length(data_size);
    dagsToTest = eval([network, num2str(data_size(a)), algorithm]);
    for b = 1:reps
        [sens(b) sel(b) spec(b)] = algperf(dagsToTest{b},adjacency); % for 50 reps
%         [sens(b) sel(b) spec(b)] = algperf(dagsToTest,adjacency); % for 1 rep
    end
    eval(['sens',network, num2str(data_size(a)), algorithm, '= sens']);
    eval(['sel',network, num2str(data_size(a)), algorithm, '= sel']);
    eval(['spec',network, num2str(data_size(a)), algorithm, '= spec']);
    dataScoreName = [network, num2str(data_size(a)), algorithm, 'SCORES'];
    eval([dataScoreName ...
        '= score_dags(dataToScore, node_sizes, dagsToTest, ''scoring_fn'', ''bic'')']);
    eval([dataScoreName,'_mean','=nanmean(eval(dataScoreName))']);
    eval([sensname, '=[eval(sensname) nanmean(sens)]']);
    eval([selname, '=[eval(selname) nanmean(sel)]']);
    eval([specname, '=[eval(specname) nanmean(spec)]']);
end
save(load_name)
            
