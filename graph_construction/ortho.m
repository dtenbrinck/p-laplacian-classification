function Q = ortho(A, n)
%%Gram-Schmidt-Algorithm for nxm-Matrix A,
%% returns ON-basis of A as columns of Q
k = size(A,2);

for ii = 1:1:k
    A(:,ii) = A(:,ii) / norm(A(:,ii));
    for jj = ii+1:1:k
        A(:,jj) = A(:,jj) - proj(A(:,ii),A(:,jj));
    end
end

Q = A;
end

