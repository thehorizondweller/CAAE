%Name: Kshitij Anand
%Roll Number: 18AE30008
%Subject: CAAE
%Gauss Jordan Elimination Assignment 

%clearing the workspace
clear all;

%Sample system of 3 linear equations have been used. The user may alter the
%equations as they wish in the code.

%Sample system of equations used here
% x1 -2x2 +3x3 = 7
% 2x1 +x2 +x3 = 4
% -3x1 +2x2 -2x3 = -10


%Enter your coefficient matrix here
coefficient_matrix = [1 -2 3; 2 1 1; -3 2 -2];

%Enter the b vector here
b = [7 4 -10];

%Augmented Matrix
A = [coefficient_matrix b'];

%Check if solution can be found
if det(coefficient_matrix)==0
    fprintf('The given system has no unique solution.');
    return
end

%Gauss-Jordan Method
[m,n] = size(A);
for j = 1:m-1
    %Pivoting
    for z = 2:m
        if A(j,j) == 0
            t = A(1,:);
            A(1,:) = A(z,:);
            A(z,:) = t;
        end
    end
    %Making entries above of major diagonal zero
    for i = j+1:m
        A(i,:) = A(i,:) - A(j,:)*(A(i,j)/A(j,j));
    end
end

for j = m:-1:2
    %Making entries below of major diagonal zero
    for i = j-1:-1:1
        A(i,:) = A(i,:) - A(j,:)*(A(i,j)/A(j,j));
    end
end

for s = 1:m
    A(s,:) = A(s,:)/A(s,s);
    x(s) = A(s,n);
end

fprintf('The row reduced form of the augmented matrix:\n');
disp(A);

fprintf('The solution is: \n');
for k = 1:length(b)
    fprintf('x%d = %.3f\n', k, x(k));
end


            
