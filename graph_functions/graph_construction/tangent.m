%%distfun for matlab function knnsearch
%%input arguments:
%%-ZI: 1xn vector containing picture
%%-ZJ: mxn matrix containing all pictures
%%output:
%%-D2: mx1 matrix: j-th element is distance between Z1 and ZJ(j,:)
function D2 = tangent(ZI, ZJ)

    [elements, picsize] = size(ZJ);
    D2 = zeros(elements,1);
    choice = ones(1,7);
    
    im1 = ZI';
    
    for j = 1:elements
        im2 = ZJ(j,:)';
        D2(j) = twosidedTangentDistance(im1, im2, choice, 28, 28, 0);
    end

end