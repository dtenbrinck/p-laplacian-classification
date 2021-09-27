%%distfun for matlab function knnsearch
%%input arguments:
%%-ZI: 1 x n vector containing picture
%%-ZJ: m x n matrix containing all pictures
%%output:
%%-D2: m x 1 matrix: j-th element is distance between ZI and ZJ(j,:)
function D2 = tangent(ZI, ZJ)

    [elements, ~] = size(ZJ);
    D2 = zeros(elements,1);
       
    for j = 1:elements
        D2(j) = twosidedTangentDistance(ZI', ZJ(j,:)', ones(1,7), 28, 28, 0);
    end

end