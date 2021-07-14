function d = dist_to_center(data,center)
% (data - repmat(center, size(data,1), 1))
% sum((data - repmat(center, size(data,1), 1)) .^ 2, 2)

d = sqrt(sum((data - repmat(center, size(data,1), 1)) .^ 2, 2));



