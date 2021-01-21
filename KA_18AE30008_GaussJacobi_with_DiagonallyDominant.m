%Developer: Kshitij Anand
%Roll number: 18AE30008
%Subject: CAAE
%Date: 21 January 2021


clear all
clc

%Enter the coefficient matrix and b vector here
A = [4 2 1; 2 1 8; 3 9 2];
B = [43 89 96]';

[n m] = size(A);

%Checking if the coefficient matrix is square
if n~=m
    fprintf('The coefficient matrix is not a square matrix.\n');
    return 
end

is_not_diagonally_dominant = 0;
%Checking if the matrix as it is diagonally dominant
for k = 1:n
    sum = 0;
    for i = 1:n
        sum = sum + abs(A(k,i));
    end
    % Sum of the absolute values of all non-diagonal entries must be lesser
    % than the absolute value of the diagonal value.
    if 2*abs(A(k,k)) < sum
        fprintf('This coefficient matrix is not diagonally dominant.\n');
        is_not_diagonally_dominant = 1;
        break
    end
end

%If matrix is not diagonally dominant, we make it diagonally dominant
%otherwise we skip this code.
if is_not_diagonally_dominant
    [max_row, max_ind] = max(abs(A),[],2);
    %First Check that the individual rows can suffice to make diagonally
    %dominant matrix
    for i = 1:n
        sum = 0;
        for k = 1:n
            sum = sum + abs(A(i,k));
        end
        if 2*abs(A(i,max_ind(i))) < sum
            fprintf('This coefficient matrix cannot be made diagonally dominant\n');
            fprintf('SOLUTION IS NOT POSSIBLE USING ITERATIVE METHODS.\n');
            return %terminate the program 
        end
    end
    
    v = 1:1:n;
    %Second Check - To find whether the row can be shuffled without the
    %largest entry in each row having a unique column number
    c = isequal(sort(max_ind), v');
    if ~c %The max element index positions clash
        fprintf('This coefficient matrix cannot be made diagonally dominant\n');
        fprintf('SOLUTION IS NOT POSSIBLE USING ITERATIVE METHODS.\n');
        return %terminate the program
    end
    
    %If both checks are passed, then make them diagonally dominant
    if c
        A(max_ind,:) = A;
        B(max_ind) = B;
    end
end




solution_vector = zeros(n,1);

err_x = 0.00001;

for k = 1:100
    iteration_history_matrix(k,:) = solution_vector';
    for i = 1:n
        sum = 0;
        for j = 1:n
            sum = sum + A(i,j)*solution_vector(j);
        end
        Residual(i,1) = B(i) - sum;
        new_solution_vector(i,1) = solution_vector(i,1) + Residual(i,1)/A(i,i);
    end
    solution_vector = new_solution_vector;
    delta_x = abs(solution_vector' - iteration_history_matrix(k,:));
    if delta_x < err_x
        break
    end
end

serial = 1:1:k;
result = [serial' iteration_history_matrix];
disp(result);