function B = check(A,i)

% Used during computing GVF field, whether the matrix is of proper size or
% not; if not so add elements across the boundary

if (i==1)
[m,n] = size(A);
yi = 2:m+1; xi = 2:n+1;
B = zeros(m+2,n+2);
B(yi,xi) = A;
B([1 m+2],[1 n+2]) = B([3 m],[3 n]); 
B([1 m+2],xi) = B([3 m],xi);          
B(yi,[1 n+2]) = B(yi,[3 n]);          
end

if (i==2)
[m,n] = size(A);
yi = 2:m-1; xi = 2:n-1;
B = A;
B([1 m],[1 n]) = B([3 m-2],[3 n-2]); 
B([1 m],xi) = B([3 m-2],xi);          
B(yi,[1 n]) = B(yi,[3 n-2]);          
end

if (i==3)
[m,n] = size(A);
yi = 2:m-1; xi = 2:n-1;
B = A(yi,xi);
end