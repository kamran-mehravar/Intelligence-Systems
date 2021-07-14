clc
clear all;
close all;

%% reading the dataset
load('arousal data.mat');
d = arousal_data;
num_data = size(d, 1);

%% % 24    29    14    jadid
X = cell(7,1);
x24 = cell(7,1);
x29 = cell(7,1);
x14 = cell(7,1);
ind = cell(7,1);

Lable_arousal = round(d(:,end)); 

for i=1:7
    ind(i) = {(Lable_arousal==i)};
end
new_Lable_arousal = Lable_arousal;

x24(1) = {d(ind{1}|ind{2}|ind{3},24)};
x29(1) = {d(ind{1}|ind{2}|ind{3},29)};
x14(1) = {d(ind{1}|ind{2}|ind{3},14)};
new_Lable_arousal(ind{1}|ind{2}|ind{3}) = 1;

x24(2) = {d(ind{4},24)};
x29(2) = {d(ind{4},29)};
x14(2) = {d(ind{4},14)};
new_Lable_arousal(ind{4}) = 2;

x24(3) = {d(ind{5}|ind{6}|ind{7},24)};
x29(3) = {d(ind{5}|ind{6}|ind{7},29)};
x14(3) = {d(ind{5}|ind{6}|ind{7},14)};
new_Lable_arousal(ind{5}|ind{6}|ind{7}) = 3;

x24(4) = {d(:,24)};
x29(4) = {d(:,29)};
x14(4) = {d(:,14)};

h = cell(3);
hf1 = cell(3);
hf2 = cell(3);
windowSize1 = 3;
windowSize2 = 5;
b1 = (1/windowSize1)*ones(1,windowSize1);
b2 = (1/windowSize2)*ones(1,windowSize2);
w = [1, 1, 1];
for i=1:3  % i=1 na, i=2 za, i=3 pa
%     figure(); hist(x24{i},100);
    h(1,i) = {round(hist(x24{i},100)./w(i))};   %figure();   bar(h{1,i});   %hist(x24{i},100);   % 
    hf1(1,i) = {filter(b1,1,h{1,i})};            %figure();   bar(hf1{1,i});
    hf2(1,i) = {filter(b2,1,h{1,i})};            %figure();   bar(hf2{1,i});
    
%     figure(); hist(x29{i},100);
    h(2,i) = {round(hist(x29{i},100)./w(i))};   %figure();   bar(h{2,i});   %hist(x24{i},100);   % 
    hf1(2,i) = {filter(b1,1,h{2,i})};            % figure();   bar(hf1{2,i});
    hf2(2,i) = {filter(b2,1,h{2,i})};            %figure();   bar(hf2{2,i});
    
%     figure(); hist(x14{i},100);
    h(3,i) = {round(hist(x14{i},100)./w(i))};   %figure();   bar(h{3,i});   %hist(x24{i},100);   % 
    hf1(3,i) = {filter(b1,1,h{3,i})};            % figure();   bar(hf1{3,i});
    hf2(3,i) = {filter(b2,1,h{3,i})};            %figure();   bar(hf2{3,i});
end
% max(hf1{3,3})   % f = 14, pa

% m = max(hf1{2,1})   % m ~= 18.7
%% 
eq_cell_14 = {};
for j = 1:3
    h = hf1{3,j} ./ (3*18.7);    % hf1{3,3},hf1 means fiter window =3, 3 means f14, j means na, za, pa
    figure();   %bar(h);

    M = max(x14{j});
    m = min(x14{j});
    dif_mM = M - m;
    step_m = dif_mM / 99;
    % baraye har kodam, step, m , M fargh darand va bayad zakhire shavand
    syms x;
    y(x) = 0 * x;
    
    interv(1, :) = [m-1, m];
    hold on
    plot([0,1],[0,h(1)],'r','LineWidth',2)
    plot([100,101],[h(100),0],'r','LineWidth',2)
    for i=1:99
        y2 = h(i+1);
        y1 = h(i);
        x2 = i * step_m + m;
        x1 = (i-1) * step_m + m;
        interv(i+1,:) = [x1, x2];
        y(x) = [y(x); ((y2 - y1)/(x2 - x1)) * (x - x1) + y1];
        
        plot([i,i+1],[y1,y2],'r','LineWidth',2)
    end
    interv(i+2, :) = [M, M+1];
    y(x) = [y(x); 0 * x];
    eq_cell = {y(x), interv, [m], [M], [step_m]};
    eq_cell_14 = [eq_cell_14;eq_cell];
end

%%
eq_cell_29 = {};
for j = 1:3
    h = hf1{2,j} ./ (3*18.7);    % hf1{2,j},hf1 means fiter window =3, 3 means f14, j means na, za, pa
    figure();   %bar(h);

    M = max(x29{j});
    m = min(x29{j});
    dif_mM = M - m;
    step_m = dif_mM / 99;
    % baraye har kodam, step, m , M fargh darand va bayad zakhire shavand
    syms x;
    y(x) = 0 * x;
    
    interv(1, :) = [m-1, m];
    hold on
    plot([0,1],[0,h(1)],'r','LineWidth',2)
    plot([100,101],[h(100),0],'r','LineWidth',2)
    for i=1:99
        y2 = h(i+1);
        y1 = h(i);
        x2 = i * step_m + m;
        x1 = (i-1) * step_m + m;
        interv(i+1,:) = [x1, x2];
        y(x) = [y(x); ((y2 - y1)/(x2 - x1)) * (x - x1) + y1];
        
        plot([i,i+1],[y1,y2],'r','LineWidth',2)
    end
    interv(i+2, :) = [M, M+1];
    y(x) = [y(x); 0 * x];
    eq_cell = {y(x), interv, [m], [M], [step_m]};
    eq_cell_29 = [eq_cell_29;eq_cell];
end

%%
eq_cell_24 = {};
for j = 1:3
    h = hf1{1,j} ./ (3*18.7);   % hf1{3,3},hf1 means fiter window =3, 3 means f14, j means na, za, pa
    figure();   %bar(h);

    M = max(x24{j});
    m = min(x24{j});
    dif_mM = M - m;
    step_m = dif_mM / 99;
    % baraye har kodam, step, m , M fargh darand va bayad zakhire shavand
    syms x;
    y(x) = 0 * x;
    
    interv(1, :) = [m-1, m];
    hold on
    plot([0,1],[0,h(1)],'r','LineWidth',2)
    plot([100,101],[h(100),0],'r','LineWidth',2)
    for i=1:99
        y2 = h(i+1);
        y1 = h(i);
        x2 = i * step_m + m;
        x1 = (i-1) * step_m + m;
        interv(i+1,:) = [x1, x2];
        y(x) = [y(x); ((y2 - y1)/(x2 - x1)) * (x - x1) + y1];
        
        plot([i,i+1],[y1,y2],'r','LineWidth',2)
    end
    interv(i+2, :) = [M, M+1];
    y(x) = [y(x); 0 * x];
    eq_cell = {y(x), interv, [m], [M], [step_m]};
    eq_cell_24 = [eq_cell_24;eq_cell];
end

%%
% f = y(1);
% eval(f)
%%
t=0:0.1:100;
mf_out.yy1 = trimf(t,[0,0,50]);
mf_out.yy2 = trimf(t,[33 50 67]);
mf_out.yy3 = trimf(t,[50,100,100]);
figure;
plot(t,mf_out.yy1,'LineWidth',2); hold on
plot(t,mf_out.yy2,'r','LineWidth',2); 
plot(t,mf_out.yy3,'c','LineWidth',2);
figure; plot(t,mf_out.yy1,t,mf_out.yy2,t,mf_out.yy3)
mf_out.t = t;

%%
Data = [x24{4}, x29{4}, new_Lable_arousal];
Image = zeros(100);
Plot_Data(Image,Data,-1)

Data = [x24{4}, x14{4}, new_Lable_arousal];
Image = zeros(100);
Plot_Data(Image,Data,-1)

Data = [x29{4}, x14{4}, new_Lable_arousal];
Image = zeros(100);
Plot_Data(Image,Data,-1)

Data = [x24{4}, x29{4}, x14{4}, new_Lable_arousal];
Image = zeros(100);
Plot_Data(Image,Data,-1)

% Image = zeros(1000);
% x15_2 = x15; x4_2=x4; Lable_arousal_2 = Lable_arousal;
% x15_2(Lable_arousal==1) = []; x4_2(Lable_arousal==1) = [];Lable_arousal_2(Lable_arousal==1)=[];
% Data = [x15_2, x4_2, Lable_arousal_2];
% Image = zeros(100);
% Plot_Data(Image,Data,-1)
% size(Lable_arousal_2)
% 
% Image = zeros(1000);
% x15_1 = x15; x4_1=x4; Lable_arousal_1 = Lable_arousal;
% x15_1(Lable_arousal==2) = []; x4_1(Lable_arousal==2) = [];Lable_arousal_1(Lable_arousal==2)=[];
% Data = [x15_1, x4_1, Lable_arousal_1];
% Image = zeros(100);
% Plot_Data(Image,Data,-1)
% size(Lable_arousal_1)

%% Fuzzy Inference
% eq_cell_24   y(x), interv, [m], [M], [step_m]
% eq_cell_29
% eq_cell_14
% new_Lable_arousal % 1 na      2 za      3 pa
for i = 1 : num_data
    i
    data = [d(i,24), d(i,29), d(i,14)];
    defuz_res(i) = fuzzy_Inference(data,eq_cell_24,eq_cell_29,eq_cell_14,mf_out);
    dr(i,1) = defuz_res(i).centerofgravity(1);
end

new_arousal = [d(:,1:end-1), dr];






