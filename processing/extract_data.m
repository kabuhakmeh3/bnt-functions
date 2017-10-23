function extract_data(networkName)
% function extract_data(networkName)
% ---------------------------------------------
% to extract data from Causal Discovery 
% supplementary files to manageable MATLAB 
% files to use for further analysis
% ---------------------------------------------

%% begin routine
% testing variables
% network.Name = 'alarm';
% fileHandle
network.Name = networkName;
%% change directories
network.dataFile = [network.Name, '_data'];
network.pathToData = [network.Name '/' network.dataFile];
cd(network.pathToData)

%% parse through files to construct dataSets
network.fileHandle = [upper(network.Name(1)) network.Name(2:length(network.Name))];
% graph = load([network.fileHandle num2str(1) '_graph.txt']); % alarm, munin
graph = load([network.fileHandle '_graph.txt']); % other networks
data = cell(1,10);

for i = 1:10
    % alarm, munin
%     data{i} = load([network.fileHandle num2str(1) '_s500_v' num2str(i) '.txt']);    

    % other networks
    data{i} = load([network.fileHandle '_s500_v' num2str(i) '.txt']); 
end

%% cleanup
clear i networkName
save([network.Name '_data'])
cd ../..
save([network.Name '_data'])