function normedGrads = computeNormedGradient(W, f, p)
n = size(f, 1);
epsilon = 0;

if p<2 %avoid negative denominator
    epsilon = 0.01;
end

if p == 2 %time saver
    normedGrads = ones(n, 1);
else
    fgrid = repmat(f, 1, n);
    differences = fgrid - fgrid';
    grad = sqrt(W).*differences;
    z = sqrt(sum(grad.*grad, 2)+epsilon);
    normedGrads = z.^(p-2);
end
end