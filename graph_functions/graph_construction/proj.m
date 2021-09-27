function w = proj(u,A)
% This function projects vector v on vector u
w = (dot(A,u) / dot(u,u)) * u;
end
