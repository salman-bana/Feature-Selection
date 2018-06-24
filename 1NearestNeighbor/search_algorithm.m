function [best_features, best_accuracy] = search_algorithm(X, Y, num)
not = [];
if num == 1
    [best_features, best_accuracy] = forward_selection(X, Y);
elseif num == 2
    [best_features, best_accuracy] = backward_elimination(...
        X, Y, true, not);
else
    n = size(X, 2);
    best_features = []; best_accuracy = 0;
    for i = 1:floor(n / 5)
        %Shuffle the features
        idx = randperm(n);
        temp_X = X(:, idx);
        %Create two arrays of size (n / 5). One for the features
        %One for accuracy
        total_features = []; update = 1; not = [];
        %feature_cell = cell(1, floor(n / 5));
        %accuracy_array = zeros(1, 10);
        for k = 1:floor(n / 5)
            features = backward_elimination(...
                temp_X(:, update:(5 * k)), Y, true, not);
            total_features = [total_features, features + (5 * (k - 1))];
            %feature_cell(1, k) = features + ((k - 1) * 5);
            %accuracy_array(1, k) = accuracy;
            update = update + 5;
        end
        not = 1:n;
        not(total_features) = [];
        [features, accuracy] = backward_elimination(...
            temp_X, Y, true, not);
        for siz = 1:length(features)
            features(siz) = idx(features(siz));
        end
        if accuracy >= best_accuracy
            best_accuracy = accuracy;
            best_features = features;
        end
    end
% else
%     [f_features, f_accuracy] = forward_selection(X, Y);
%     [b_features, b_accuracy] = backward_elimination(X, Y, true, not);
%     total_features = union(f_features, b_features);
%     not = 1:n;
%     not(total_features) = [];
%     [test_features, test_accuracy] = backward_elimination(...
%         X, Y, true, not);
%     if test_accuracy < f_accuracy
%         best_accuracy = f_accuracy;
%         best_features = f_features;
%     else
%         best_accuracy = test_accuracy;
%         best_features = test_features;
%     end
end
end