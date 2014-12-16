function output = log_sum_mat(A)
    output = A(:,1);
    for i=1:size(A,1)
        for j=2:size(A,2)
            output(i) = log_sum(output(i), A(i,j));
        end
    end
end