load('arousal data.mat');
%Concatenate matrices A and B
%Write CSV file
csvwrite('arousal_data.csv',arousal_data);