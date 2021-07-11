function [the_best_cromosums, the_best_values] = genetic_algorithm_for_feature_selection(X,y,num_gens)
%% initialization
num_pop = 100;
max_it = 50;
n_crossover = 0.4 * num_pop;
n_elitism = 0.4 * num_pop;
genes_range = size(X,2);

for i = 1:num_pop
    initial_pop(i,:) = randperm(genes_range, num_gens);
end

%% GA Algorith      *******************************
pop = initial_pop;
k_fold = 4;
value = zeros(num_pop,1);

for j = 1:max_it
    j
    for i2 = 1:num_pop
        i2
        coromosum = pop(i2,:);
        value(i2) = k_fold_cross_validaion(X(:,coromosum), y, k_fold);
    end
    
    [m,ind] = sort(value);  
    the_best_values(j) = m(1)
    the_best_cromosums(j,:) = pop(ind(1),:)
    
    % elitism
    elits = pop(ind(1:n_elitism),:);
    value = (1./value).^10;
    value = value ./ sum(value);
    % crossover
    parents_index = Roulette_wheel(pop,value,n_crossover);
    childs_crossover = crossover_parents(parents_index, pop, genes_range);
    
    % mutation
    n_mut = num_pop - size(childs_crossover,1) - n_elitism;
    new_random = zeros(n_mut, num_gens);
    for i3 = 1:n_mut
        new_random(i3,:) = randperm(genes_range, num_gens);
    end
    
%     n_permutation_on_childs = round(n_permutation/2);
%     n_permutation_new_random = n_permutation - n_permutation_on_childs;
%     new_random = randi(size(X,2), n_permutation_new_random, num_gens);
%     childs = permutation_on_gens(childs, n_permutation_on_childs, total_genes);
    permutes = new_random;
    
    % new generation
    pop = [elits; childs_crossover; permutes];    
end


coro = 0;

%% functions ***************************************************
% 43    36    50    28    44     4    33    35    39     5
%     20    51    36    40    24    42    33    35    39     5
%     37    21     4    24    44    30    32     7    15    27
% ***************************************************************************************
% ***************************************************************************************
% ***************************************************************************************
% function child_perm = permutation_on_gens(childs, n_permutation_on_childs, total_genes)
% a = randperm(size(childs,1), n_permutation_on_childs);
% g = size(childs, 2);
% for i = 1:n_permutation_on_childs
%     indp = randi(2, 1, g) > 1;
%     for
% end
% 
% g = size(childs, 2);
% ind = zeros(size(childs)) > 0;
% rp = randi(2, n_permutation_on_childs, g) > 1;
% ind(a(1: n_permutation_on_childs),:) = rp;
% 
% 
% childs(a(1: n_permutation_on_childs), 
% rp = randi(size(childs,2),n_permutation_on_childs);


% ***************************************************************************************
% ***************************************************************************************
% ***************************************************************************************
function rand_roulette_index = Roulette_wheel(pop,value,n_crossover)
% whithout repeat
weights = 1./(value + 10e-10);
chosen_index = -1;
for ir = 1:n_crossover
    accumulation = cumsum(weights);
    p = rand() * accumulation(end);
    chosen_index(ir) = find(accumulation>p, 1);
    weights(chosen_index(ir))=0;
end
rand_roulette_index = chosen_index;



% ***************************************************************************************
% ***************************************************************************************
% ***************************************************************************************
function childs = crossover_parents(parents_index, pop, genes_range)
nn = length(parents_index);
gg = size(pop, 2);
parents_for_crossover = pop(parents_index, :);
childs = zeros(nn,gg);
for i10=1:2:nn-1
    pos = randi(gg-1, 1);
    child_c1(i10,:) = [parents_for_crossover(i10, 1:pos), parents_for_crossover(i10+1, pos+1:end)];
    child_c2(i10,:) = [parents_for_crossover(i10+1, 1:pos), parents_for_crossover(i10, pos+1:end)];
    for jj=1:gg-1
        indd = [];
        indd = find(child_c1(i10,:) == child_c1(i10,jj));
        if (length(indd) > 1)
            set_g = 1:genes_range;
            set_g (child_c1(i10,:)) = [];
            d_rand = randperm(length(set_g),length(indd)-1);
            child_c1(i10,indd(2:end)) = d_rand;
        end
        
        indd = [];
        indd = find(child_c2(i10,:) == child_c2(i10,jj));
        if (length(indd) > 1)
            set_g = 1:genes_range;
            set_g (child_c2(i10,:)) = [];
            d_rand = randperm(length(set_g),length(indd)-1);
            child_c2(i10,indd(2:end)) = d_rand;
        end 
    end
    childs(i10,:) = child_c1(i10,:);
    childs(i10+1,:) = child_c2(i10,:);
end


% ***************************************************************************************
% ***************************************************************************************
% ***************************************************************************************
function err_percentage = k_fold_cross_validaion(X, y, k)
num_samples = size(X, 1);
rp = randperm(num_samples)';
err=zeros(1,k);
fold_size = floor(num_samples/k);

k_fold_test = cell(1,k);
k_fold_train = cell(1,k);
for ik = 1:k
    k_fold_test{1,ik} = rp(fold_size * (ik-1) + 1 : fold_size * ik);
    k_fold_train{1,ik} = [rp(1 : fold_size * (ik-1)) ; rp(fold_size * ik + 1 : end)];
end

for i5 = 1 : k
    xtest = X(k_fold_test{i5},:);
    ytest = y(k_fold_test{i5});
    
    xtrain = X(k_fold_train{i5},:);
    ytrain = y(k_fold_train{i5});
%     size_xtest = size(xtest)
%     size_xtrain = size(xtrain)
    
    [err(i5), err2(i5)] = fun_mlp_classifier_fitnet(xtrain, ytrain, xtest, ytest);
end

err_percentage = sum(err2)/num_samples;

% ***************************************************************************************
% ***************************************************************************************
% ***************************************************************************************
% function err = fun_mlp_classifier(xtrain, ytrain, xtest, ytest)
% % 1 input neuron , 1 output neuron
% num_hiden_neuron = 20;               % num neurons for the hidden layer
% net = fitnet(num_hiden_neuron) ;
% net.trainParam.showWindow =0;
% 
% xx = xtrain';
% tt = ytrain';
% net = train(net, xx, tt);
% y  = net(xtest');
% % err = perform (net, ytest', y);
% err = num_miss_classified(ytest, y); %ytest nsample*1    y 1*nsample


% ***************************************************************************************
% ***************************************************************************************
% ***************************************************************************************
function num_err = num_miss_classified(ytest, y)
d = abs(y - ytest');
num_err = sum(d > 0.5)

yr = round(y);
num_err2 = sum((yr - ytest') ~= 0)




