function [features, prev_accuracy] = forward_selection(X, Y)
warning = ['Warning, Accuracy has decreased! ' ...
    'Continuing search in case of local maxima \n'];
%Forward Selection Algorithm
%Initialize an empty vector containing 
%the indexes of the best features
fprintf('Beginning search. \n');
best = []; n = size(X, 2);
prev_accuracy = 0;
for add = 1:n
    index = 0; best_accuracy = 0; 
    for j = 1:n
        flag = true;
        if ~isempty(best)
            for k = 1:length(best)
                if isequal(j, best(k))
                    %disp(j)
                    %disp(best(k))
                    flag = false;
                end
            end
        end
        if flag
            accuracy = cross_validation(X(:, [best, j]), Y);
            %temp_X = X(error_vector, :); temp_Y = Y(error_vector, :);
            %X(error_vector, :) = []; Y(error_vector, :) = [];
            %X = [temp_X; X]; Y = [temp_Y; Y];
            fprintf('Using features ');
            fprintf('%i,', [best, j]);
            fprintf(' the accuracy is %f \n', accuracy);
            if accuracy > best_accuracy
                best_accuracy = accuracy;
                index = j;
            end
        end
    end
    if prev_accuracy > best_accuracy + 3
        break;
    elseif (prev_accuracy <= best_accuracy + 3 ...
            && prev_accuracy > best_accuracy)
        %Add best to index
        best = [best, index];
        fprintf(warning);
    else
        prev_accuracy = best_accuracy;
        best = [best, index];
        true_best = best;
    end
end
features = true_best;
end