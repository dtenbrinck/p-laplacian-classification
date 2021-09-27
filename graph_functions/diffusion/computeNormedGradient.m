function ngrad = computeNormedGradient(W,f,p, length, dim)
epsilon = 0;
if p<=1 %avoid negative denominator
    epsilon = 0.01;
end

if p == 2 %time saver
     normedGrads = ones(length, dim);
else
normedGrads = zeros(length,dim);
for i = 1:dim
  fgrid = repmat(f(:,i),1,length);
  differences = fgrid - fgrid';
  grad = sqrt(W).*differences;
  z = sqrt(sum(grad.*grad, 2)+epsilon);
  normedGrads(:,i) = z.^(p-2);
end
end
ngrad = sqrt(sum(normedGrads.*normedGrads, 2));
end