function [features, prev_accuracy] = backward_elimination(X, Y, cond, not)
%Backwards Elimination
warning = ['Warning, Accuracy has decreased! ' ...
    'Continuing search in case of local maxima \n'];
fprintf('Beginning search. \n');
n = size(X, 2); 
if isempty(not)
    worst = [];
else
    worst = not;
end
prev_accuracy = 0;
for remove = 1:n
    index = 0; best_accuracy = 0; 
    for j = 1:n
        flag = true;
        if ~isempty(worst)
            for k = 1:length(worst)
                if isequal(j, worst(k))
                    %disp(j)
                    %disp(best(k))
                    flag = false;
                end
            end
        end
        tempX = X;
        tempX(:, [worst, j]) = [];
        if flag
            accuracy = cross_validation(tempX, Y);
            %temp_X = X(error_vector, :); temp_Y = Y(error_vector, :);
            %X(error_vector, :) = []; Y(error_vector, :) = [];
            %X = [temp_X; X]; Y = [temp_Y; Y];
            fprintf('Removing features ');
            fprintf('%i,', [worst, j]);
            fprintf(' the accuracy is %f \n', accuracy);
            if accuracy > best_accuracy
                best_accuracy = accuracy;
                index = j;
            end
        end
    end
    if cond
        if prev_accuracy > best_accuracy + 3
            break;
        elseif (prev_accuracy <= best_accuracy + 3 ...
                && prev_accuracy > best_accuracy)
            %Add worst to index
            worst = [worst, index];
            fprintf(warning);
        else
            prev_accuracy = best_accuracy;
            worst = [worst, index];
            true_worst = worst;
        end
    else
        if prev_accuracy > best_accuracy
            break;
        else
            prev_accuracy = best_accuracy;
            worst = [worst, index];
            true_worst = worst;
        end
    end
end
features = 1:n;
features(true_worst) = [];
end