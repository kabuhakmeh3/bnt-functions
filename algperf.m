function [sens sel spec] = algperf(test,true)
% [sens sel spec] = algperf(test,true)
% returns algorithm performance measures where
% test = learned structure & true = known structure
% returns [sensitivity, selectivity, specificity]

% khaldoon - march 4, 2012
% kabuhakmeh@gmail.com

%% testing
% true = [0 1 1 0;0 0 0 1;0 0 0 1;0 0 0 0];
% test = [0 1 1 0;0 0 0 0;0 0 0 1;0 1 0 0];

%% preliminary tests
[a b]=size(test);
[c d]=size(true);

if a~=b || a~=c || c~=d || b~=d
  error('formats non compatibles: check matrix dimesions');
end

TP = 0; TN = 0; FP = 0; FN = 0;

for i = 1:a
    for j = 1:b
        if test(i,j) == 1 && true(i,j) == 1
            TP = TP + 1;
        elseif test(i,j) == 1 && true(i,j) == 0
            FP = FP + 1;
        elseif test(i,j) == 0 && true(i,j) == 1
            FN = FN + 1;
        elseif test(i,j) == 0 && true(i,j) == 0
            TN = TN + 1;
        end
    end
end

sel = TP/(TP+FP);               % precision

sens = TP/(TP+FN);              % recall

spec = TN/(FP+TN);             % true negative / negative [TNR]
