function rand_roulette_index = Roulette_wheel_my(weights,n_class)
% whithout repeat
% weights = 1./(value + 10e-10);
chosen_index = -1;
for ir = 1:n_class
    accumulation = cumsum(weights);
    p = rand() * accumulation(end);
    chosen_index(ir) = find(accumulation>p, 1);
    weights(chosen_index(ir))=0;
end
rand_roulette_index = chosen_index;