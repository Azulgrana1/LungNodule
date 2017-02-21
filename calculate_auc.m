function [ auc_value ] = calculate_auc( prediction, ground_truth )
%CALCULATE_AUC
%   prediction: N * 2 matrix where prediction(:, 1) indicates sample id,
%       prediction(:, 2) indicates confidence value that the corresponding
%       sample is a positive sample(single/double, between 0.0 and 1.0).
%   ground_truth: N * 2 matrix where ground_truth(:, 1) indicates sample
%       id, ground_truth(:, 2) indicates whether the corresponding sample
%       is a positive sample(1.0 for positive samples, 0.0 for negative
%       samples).
%   auc_value: A float-point value indicates the accuracy of prediction,
%       normally between 0.5 and 1.0; if less than 0.5, you may retry with
%       (1.0 - prediction).

assert(size(prediction, 1) == size(ground_truth, 1));
assert(size(prediction, 2) == 2);
assert(size(ground_truth, 2) == 2);

nb_pos_samples = sum(ground_truth(:, 2) == 1.0);
nb_neg_samples = sum(ground_truth(:, 2) == 0.0);
assert(nb_pos_samples + nb_neg_samples == size(ground_truth, 1));

[~, ids] = sort(prediction(:, 1));
prediction = prediction(ids, 2);
[~, ids] = sort(ground_truth(:, 1));
ground_truth = ground_truth(ids, 2);

auc_value_1 = helper(prediction, ground_truth);

prediction = prediction(end:-1:1);
ground_truth = ground_truth(end:-1:1);
auc_value_2 = helper(prediction, ground_truth);

auc_value = (auc_value_1 + auc_value_2) / 2;
auc_value = auc_value / (nb_pos_samples * nb_neg_samples);

end

function [ auc_value ] = helper( prediction, ground_truth )
    [prediction, ids] = sort(prediction, 'descend');
    ground_truth = ground_truth(ids);

    area = zeros(size(prediction));
    area(ground_truth == 1.0) = 1.0;
    area = cumsum(area);
    auc_value = double(sum(area(ground_truth == 0.0)));
end
