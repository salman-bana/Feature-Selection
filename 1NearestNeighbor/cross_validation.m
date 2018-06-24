function accuracy = cross_validation(X, Y)
error_vector = []; m = size(X, 1);
for i = 1:m
    min_distance = 100000; index = 0;
    for j = 1:m
        if i ~= j
            current_distance = sqrt(sum((X(j, :) - X(i, :)) .^ 2));
            if current_distance <= min_distance
                min_distance = current_distance;
                index = j;
            end
        end
    end
    if ~isequal(Y(i), Y(index))
        error_vector = [error_vector index];
        %if accuracy < base
            %break
        %end 
    end
end
accuracy = (m - length(error_vector)) * 100 / m;
end