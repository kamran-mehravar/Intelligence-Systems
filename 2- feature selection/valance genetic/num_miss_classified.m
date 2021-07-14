function [num_err, err_percent] = num_miss_classified(ytest, y)
% d = abs(y - ytest');
% num_err = sum(d > 0.5);

yy = round(y);
yy (yy > 7) = 7;

m = min(ytest);
yy (yy < m) = m;

for i = 1:7
    class_ind = (ytest' == i);
    err(i) = sum(yy(class_ind) ~= i);
    err_percent(i) = err(i) / (eps+sum(class_ind));
end
num_err = err;


% 
% yy - ytest'
% 
% d = abs(y - ytest');
% num_err = sum(d > 0.5);
% 
% 
% 
% yr = round(y);
% num_err2 = sum((yr - ytest') ~= 0);