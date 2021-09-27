function Q = ortho(A, n)
%%Gram-Schmidt-Algorithm for nxm-Matrix A,
%% returns ON-basis of A as columns of Q
% Q = zeros(n, rank(A));
% for i = 1:rank(A)
%     v = A(:,i);
%     for j = 1:i-1
%         v = v - dot(Q(:,j),A(:,i))*Q(:,j);
%     end
%     Q(:,i) = v/norm(v);
% end
k = size(A,2);

for ii = 1:1:k
    A(:,ii) = A(:,ii) / norm(A(:,ii));
    for jj = ii+1:1:k
        A(:,jj) = A(:,jj) - proj(A(:,ii),A(:,jj));
    end
end

Q = A;
end

