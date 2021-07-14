clc
clear
close all;

%% reading the dataset
load('arousal data.mat');
d = arousal_data;

X = d(:,1:end-1);

%% data balance analyze
Lable_arousal = round(d(:,end)); 
Lable_arousal(Lable_arousal==1) = 1;
d(Lable_arousal<7 & Lable_arousal>1,:) = [];
Lable_arousal(Lable_arousal<7 & Lable_arousal>1) = [];
Lable_arousal(Lable_arousal==7) = 2;
d(Lable_arousal==4,:) = [];

% 15 4 35-> 34 zira 24 hazf shode
% 15 4 31-> tahlile ghabli
% 24    29    14     9    10 jadid

% 37 51 12 -> pesare

% for i = 1:size(X,2)
%     xx = d(:,i);
%     figure();hist(xx,100)
% end

% 52, 50, 39, 25, 24, 23, 15
% 43, 40, 33, 32, 31, 22, 21, 14, 12

% 15 4 34
% 15 4 31
% 37 51 12
% 36 51 12
% 36 50 12
% 24    29    14     9    10
% 24    29    9    
% 24    29    10
% 52, 39, 25, 24, 23, 15
% 52, 50, 39, 25, 24, 23, 15
% 52, 39, 25, 24, 23, 15
% 52, 25, 15

% for i=1:53
%     figure();hist(d(:,i),1000)
% end
% no: 53 51 38 37 36 35
% strip: 52 50 39
% strip dist: 49 34  25  15
% jaleb: 24 23 10
% 49 47 46 ... 40 34 ..31  29 22..18  17 16 14..11 9...1
% dist:
% barresi shavad 30  28  27  26  



% great : 52 23
x15 = d(:,24);
x4 = d(:,29);
x35 = d(:,14);

figure();hist(x15,100)
figure();hist(x4,100)
figure();hist(x35,100)
figure();hist(Lable_arousal,100)

Image = zeros(1000);
Data = [x15, x4, Lable_arousal];
Image = zeros(100);
Plot_Data(Image,Data,-1)

Image = zeros(1000);
x15_2 = x15; x4_2=x4; Lable_arousal_2 = Lable_arousal;
x15_2(Lable_arousal==1) = []; x4_2(Lable_arousal==1) = [];Lable_arousal_2(Lable_arousal==1)=[];
Data = [x15_2, x4_2, Lable_arousal_2];
Image = zeros(100);
Plot_Data(Image,Data,-1)
size(Lable_arousal_2)

Image = zeros(1000);
x15_1 = x15; x4_1=x4; Lable_arousal_1 = Lable_arousal;
x15_1(Lable_arousal==2) = []; x4_1(Lable_arousal==2) = [];Lable_arousal_1(Lable_arousal==2)=[];
Data = [x15_1, x4_1, Lable_arousal_1];
Image = zeros(100);
Plot_Data(Image,Data,-1)
size(Lable_arousal_1)



Data = [x35, x4, Lable_arousal];
Plot_Data(Image,Data,-1)

Data = [x15, x35, Lable_arousal];
Plot_Data(Image,Data,-1)

Data = [x15, x35, x4, Lable_arousal];
Plot_Data(Image,Data,-1)


% after 18 tekrar
% sorted = 34    33    15    52    35    32    1    16    31    28    26    20    19    9     7     3
% m      = 3     3     3     2     3     2     2    2      1     1     1     1     1    1     1     1

% i(end[3,4,3,11,0,7,0,4,2,0,3,2,3,1,17,6,0,0,6,0,9,1,0,0,0,5,1,0,3,0,3,5,6,4,9,1,0,0,2,0,3,5,2,6,1,2,1,3,2,3,0,6,0,1]
% 
%  15     4    35    21     6    52    44    33    19    16    42
%  17    11     9     9     7     6     6     6     6     6     5
% the best = 15, 4, 35


% new with 40 neuron
% 24    29    14     9    10

% ID3
% 26 13 12 8 3
% 26 13 17 3 8
% 26 13 17 3 50 33 20 21 23 18 14
% 26 13 17 33
% 26 13 17 36 24 1 31
% 26 13, 17 20 18 4 3 31 40 17
% 29 17 38 35

