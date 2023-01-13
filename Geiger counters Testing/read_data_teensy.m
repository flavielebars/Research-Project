
%Author: Flavie Le Bars

% function to read the text file generated by the Teensy

% P1 - Pulse of Geiger set A
% P1 - Pulse of Geiger set B
% S1 - Sum of the pulses detected by set A
% S2 - Sum of the pulses detected by set B
% M1 - Average number of pulses detected by Geiger set A in 1 minute
% M2 - Average number of pulses detected by Geiger set B in 1 minute
% ERP1 - Error Rate Pulse 1
% ERP2 - Error Rate Pulse 2
% min - length of the testing in minutes

function [P1,P2,M1,M2,ERP1,ERP2,min] = read_data_teensy(file_name)


datateensy = importdata(file_name);
minutes = datateensy(:,1);
P1 = datateensy(:,2);
P2 = datateensy(:,3);

S1 = sum(P1);
S2 = sum(P2);
min = length(datateensy);
ERP1 = (sqrt(S1))/min;
ERP2 = (sqrt(S2))/min; 
M1 = mean(P1);
M2 = mean(P2);
end