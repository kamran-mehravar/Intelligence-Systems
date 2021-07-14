function defuz_res = fuzzy_Inference(data,eq24,eq29,eq14,mf_out)
% eq_cell_24   y(x), interv, [m], [M], [step_m]
syms x

%% for f24
x24 = data(1);
interv24_na = eq24{1,2};
ind = find(x24 >= interv24_na(:,1) & x24 < interv24_na(:,2));
y(x) =  eq24{1,1}(ind(1));
f = y(x24);
mf_f24_na = eval(f);

interv24_za = eq24{2,2};
ind = find(x24 >= interv24_za(:,1) & x24 < interv24_za(:,2));
y(x) =  eq24{2,1}(ind(1));
f = y(x24);
mf_f24_za = eval(f);

interv24_pa = eq24{3,2};
ind = find(x24 >= interv24_pa(:,1) & x24 < interv24_pa(:,2));

y(x) =  eq24{3,1}(ind(1));
f = y(x24);
mf_f24_pa = eval(f);

%% for f29
x29 = data(2);
interv29_na = eq29{1,2};
ind = find(x29 >= interv29_na(:,1) & x29 < interv29_na(:,2));
y(x) =  eq29{1,1}(ind(1));
f = y(x29);
mf_f29_na = eval(f);

interv29_za = eq29{2,2};
ind = find(x29 >= interv29_za(:,1) & x29 < interv29_za(:,2));
y(x) =  eq29{2,1}(ind(1));
f = y(x29);
mf_f29_za = eval(f);

interv29_pa = eq29{3,2};
ind = find(x29 >= interv29_pa(:,1) & x29 < interv29_pa(:,2));
y(x) =  eq29{3,1}(ind(1));
f = y(x29);
mf_f29_pa = eval(f);

%% for f14
x14 = data(3);
interv14_na = eq14{1,2};
ind = find(x14 >= interv14_na(:,1) & x14 < interv14_na(:,2));
y(x) =  eq14{1,1}(ind(1));
f = y(x14);
mf_f14_na = eval(f);

interv14_za = eq14{2,2};
ind = find(x14 >= interv14_za(:,1) & x14 < interv14_za(:,2));
y(x) =  eq14{2,1}(ind(1));
f = y(x14);
mf_f14_za = eval(f);

interv14_pa = eq14{3,2};
ind = find(x14 >= interv14_pa(:,1) & x14 < interv14_pa(:,2));
y(x) =  eq14{3,1}(ind(1));
f = y(x14);
mf_f14_pa = eval(f);

%% inference and aggregation
mf_na(1) = mf_f24_na * mf_f29_na * mf_f14_na;
mf_za(1) = mf_f24_za * mf_f29_za * mf_f14_za;
mf_pa(1) = mf_f24_pa * mf_f29_pa * mf_f14_pa;

mf_na(2) = min([mf_f24_na , mf_f29_na , mf_f14_na]);
mf_za(2) = min([mf_f24_za , mf_f29_za , mf_f14_za]);
mf_pa(2) = min([mf_f24_pa , mf_f29_pa , mf_f14_pa]);

%% defuzzification
[m, defuz_res.max_prod] = max([mf_na(1), mf_za(1), mf_pa(1)]);
[m, defuz_res.max_min] = max([mf_na(2), mf_za(2), mf_pa(2)]);
% [m, defuz_res.max_prod] = max([mf_na(1), 0, mf_pa(1)]);
% [m, defuz_res.max_min] = max([mf_na(2), 0, mf_pa(2)]);

res_mf = max([min(mf_na(2),mf_out.yy1); min(mf_za(2), mf_out.yy2); min(mf_pa(2), mf_out.yy3)]);
% figure; plot(mf_out.t, res_mf)

for jj=1:length(mf_out.t)
    cdf(jj) = sum(res_mf(1:jj));
end
mean_val = cdf(end)/2;
ind_defuz_a = find(cdf > mean_val);
if (mean_val == 0)
    ind_defuz = 2;
else
    ind_defuz = ind_defuz_a(1);
end

defuz_res.centerofgrav.na = mf_out.yy1(ind_defuz);
defuz_res.centerofgrav.za = mf_out.yy2(ind_defuz);
defuz_res.centerofgrav.pa = mf_out.yy3(ind_defuz);
[m,defuz_res.centerofgravity] = max([defuz_res.centerofgrav.na, defuz_res.centerofgrav.za, defuz_res.centerofgrav.pa]);
% [m,defuz_res.centerofgravity] = max([defuz_res.centerofgrav.na, 0, defuz_res.centerofgrav.pa]);




