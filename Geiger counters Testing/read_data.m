
%Author: Flavie Le Bars

% function to read the two text files generated by the Campbell Data Logger

%INPUTS
%file_name_pulses - .dat file with the number of pulses detected 
%file_name_ctime - .dat file with the count of coincidence (not used
%further in this version of the code)

%OUTPUTS
% P1 - Pulse of Geiger set A
% P1 - Pulse of Geiger set B
% S1 - Sum of the pulses detected by set A
% S2 - Sum of the pulses detected by set B
% M1 - Average number of pulses detected by Geiger set A in 1 minute
% M2 - Average number of pulses detected by Geiger set B in 1 minute
% ERP1 - Error Rate Pulse 1
% ERP2 - Error Rate Pulse 2
% MIN - length of the testing in minutes

function [P1,P2,M1,M2,ERP1,ERP2,min] = read_data(file_name_pulses,file_name_ctime)

data = importdata(file_name_pulses);
P1 = data.data(:,3);
P2 = data.data(:,4);
M1 = mean(P1);
M2 = mean(P2);
min = length(data.data);
days = min/1440; %1440 min in 1 day
S1 = sum(P1);
S2 = sum(P2);
ERP1 = (sqrt(S1))/min;
ERP2 = (sqrt(S2))/min;

data_count = importdata(file_name_ctime);
C = data_count.data(:,4);
counts = length(C);
average = counts/days;
ERC = (sqrt(counts))/days;


end
