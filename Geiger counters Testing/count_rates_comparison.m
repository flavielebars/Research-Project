
close all;
clear all;

%Author: Flavie Le Bars

%2 sets of Geiger counters were tested, SET A had a faulty tube, so the testing
%was done with SET B only (hence only the pulse (individual counts))

%Potassium acts as a radioactive source; it increases the count rates of
%each pulse, but it doesn't affect the coincidence rate count (ie: cosmic
%rays)

%Lead acts as a radioactive shield; it blocks individual count rates, but
%does not affect coincidence rate count

%refer to the functions read_data and read_data_teensy for the meaning of
%the variables outputed

%This code compares the accuracy of different data loggers to counting pulses (radiation) detected
%by the Geiger counter:
    %1 - Campbell data logger with Potassium VS Campbell within a Lead box
    %without potassium
    %2 - COMPARISON TEENSY WITH CPU SPEED 600 MHz and CAMPBELL (BOTH WITH POTASSIUM ADDED)
    %3 - COMPARISON TEENSY WITH CPU SPEED 24 MHz and 600 MHz


%% CAMPBELL (with Potassium added)
file_pulses_pot = 'B_POWDER_PULSES.dat';
file_ctime_pot = 'B_POWDER_CTIME.dat';        
[P1C,P2C,M1C,M2C,ERP1C,ERP2PC,minC] = read_data(file_pulses_pot,file_ctime_pot);
TotP1C = sum(P1C);
TotP2C = sum(P2C);


%% TEENSY (with Potassium added with default speed 600MHz)
file_name = 'digitalinterruptV2.txt';
[P1T,P2T,M1T,M2T,ERP1T,ERP2T,minT] = read_data_teensy(file_name);
TotP1T = sum(P1T);
TotP2T = sum(P2T);

%% CAMPBELL (within a Lead Box)
file_pulses_potl = 'B_LEAD_PULSES.dat';
file_ctime_potl = 'B_LEAD_CTIME.dat';  
[P1lead,P2lead,M1lead,M2lead,ERP1lead,ERP2lead,minTlead] = read_data(file_pulses_potl,file_ctime_potl);


%% TEENSY (with potassium and lowered CPU speed at 24MHz)
file_name ='CPU24.txt';
[P1TL,P2TL,M1TL,M2TL,ERP1TL,ERP2TL,minTl] = read_data_teensy(file_name);

%% COMPARISON CAMPBELL WITH POTASSIUM AND LEAD

%Calculation of the upper and lower bounds of the errors
y = [M1C M1lead;M2C M2lead];
errhigh = [ERP1C ERP1lead; ERP2PC ERP2lead];

figure(1); clf; 
b = bar(y);
b(1).FaceColor = '#ADD8E6';
b(2).FaceColor = '#708090';
grid on
ylim([0 2.1])
grid on
hold on
for k = 1:size(y,2)
    % get x positions per group
    xpos = b(k).XData + b(k).XOffset;
    % draw errorbar
    errorbar(xpos, y(:,k), errhigh(:,k), 'LineStyle', 'none', ... 
        'Color', 'k', 'LineWidth', 1);
end 
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','right',...
    'VerticalAlignment','bottom','FontSize', 10)

xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','left',...
    'VerticalAlignment','bottom','FontSize', 10)


l = cell(1,2);
l{1}='Campbell Potassium'; l{2}='Campbell Lead Box';
legend(b,l,'FontSize', 10,'NumColumns',2)
%title('Comparison of the average pulses measured per minute by the Campbell and the Teensy dataloggers')
ylabel ('Average pulses detected in one minute (-)','FontSize', 10)

set(gca,'xticklabel',{'Pulse 1'; 'Pulse 2'},'FontSize', 10);
print -depsc leadvsregular %save the graph in your folder in a very high
%quality, suited for Latex
hold off

%% COMPARISON TEENSY WITH CPU SPEED 600 MHz and CAMPBELL (BOTH WITH POTASSIUM ADDED)

%Calculation of the upper and lower bounds of the errors
y = [M1C M1T;M2C M2T];
errhigh = [ERP1C ERP1T; ERP2PC ERP2T];

figure(2); clf; 
b = bar(y);
b(1).FaceColor = '#ADD8E6';
b(2).FaceColor = '#708090';
grid on
ylim([0 2.1])
grid on
hold on
for k = 1:size(y,2)
    % get x positions per group
    xpos = b(k).XData + b(k).XOffset;
    % draw errorbar
    errorbar(xpos, y(:,k), errhigh(:,k), 'LineStyle', 'none', ... 
        'Color', 'k', 'LineWidth', 1);
end 
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','right',...
    'VerticalAlignment','bottom','FontSize', 10)

xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','left',...
    'VerticalAlignment','bottom','FontSize', 10)


l = cell(1,2);
l{1}='Campbell'; l{2}='Teensy';
legend(b,l,'FontSize', 10,'NumColumns',2)
%title('Comparison of the average pulses measured per minute by the Campbell and the Teensy dataloggers')
ylabel ('Average pulses detected in one minute (-)','FontSize', 10)
%title should mention the ER as well

set(gca,'xticklabel',{'Pulse 1'; 'Pulse 2'},'FontSize', 10);
print -depsc V2speedv2
hold off


%% COMPARISON TEENSY WITH CPU SPEED 24 MHz and 600 MHz

%Calculation of the upper and lower bounds of the errors
yL = [M1T M1TL;M2T M2TL];
errhighL = [ERP1T ERP1TL; ERP2T ERP2TL];
figure(3); clf; 
bL = bar(yL);
grid on
bL(1).FaceColor = '#708090	';
bL(2).FaceColor = '#20B2AA';

ylim([1 2.1])
grid on
hold on
for g = 1:size(yL,2)
    % get x positions per group
    xposL = bL(g).XData + bL(g).XOffset;
    % draw errorbar
    errorbar(xposL, yL(:,g), errhighL(:,g), 'LineStyle', 'none', ... 
        'Color', 'k', 'LineWidth', 1);
end
 
xtips1L = bL(1).XEndPoints;
ytips1L = bL(1).YEndPoints;
labels1L = string(bL(1).YData);
text(xtips1L,ytips1L,labels1L,'HorizontalAlignment','right',...
    'VerticalAlignment','bottom','FontSize', 10)

xtips2L = bL(2).XEndPoints;
ytips2L = bL(2).YEndPoints;
labels2L = string(bL(2).YData);
text(xtips2L,ytips2L,labels2L,'HorizontalAlignment','left',...
    'VerticalAlignment','bottom','FontSize', 10)


lL = cell(1,2);
lL{1}='600 MHz'; lL{2}='24 MHz';
legend(bL,lL,'FontSize', 10,'NumColumns',2)

ylabel ('Average pulses detected in one minute (-)','FontSize', 10)

set(gca,'xticklabel',{'Pulse 1'; 'Pulse 2'},'FontSize', 10);
print -depsc V2speed
hold off

