function tangents = calculateTangents(img,choice, width, height, background)
  %% Adaption of tangent calculation in Simard et al,
  %% modified version of Daniel Keyser's C-code,
  %% https://web.archive.org/web/20161221132138/http://www-i6.informatik.rwth-aachen.de/~keysers/td//  
  
  %%calculates tangents of different operations on image img(given as a vector), chosen by vector 'choice'
  %%'choice': length = 5, choice(i) <- {0,1}, with 1: compute tangent for op i
  %%operations: 1 - horizontal shift
  %%            2 - vertical shift
  %%            3 - scaling
  %%            4 - rotation
  %%            5 - line thickness
  %%            6 - compress in x direction 
  %%            7 - compress in y direction
  %% Possible optimization: substitute 6 and 7 by transformations mentioned in Simard et al.
  
  size = width*height;
  maxdim = max(width,height);
  numTangents = sum(choice);
  tangents = zeros(size,numTangents);
  
  pic = reshape(img, width, height);
  
  factorW = width*0.5;
  offsetW = floor(factorW);
  factorW = 1.0/factorW;
  
  factorH = height*0.5;
  offsetH = floor(factorH);
  factorH = 1.0/factorH;
  
  factor = min(factorW, factorH);
  
  %%tangent calculation by normed 3x3 Sobel-filter, Keyser uses extended sobel
  
  %%x1: shift in x-direction (left to right)
  %sobel 3x3:  
  sobelx = 1/8*[-1,0,1;-2,0,2;-1,0,1];
  picc = background*ones(height+2, width+2);
  picc(2:height+1, 2:width+1) = pic;
  p1 = conv2(picc, sobelx, 'valid');
  x1 = reshape(p1, 1, size);
  
  %%x2: shift in y-direction (down)
  %sobel 3x3
  sobely = 1/8*[-1, -2, -1; 0, 0, 0; 1, 2, 1];
  p2 = conv2(picc, sobely, 'valid'); 
  x2 = reshape(p2, 1, size);
  
  
  %%compute tangents
  tangentNum = 1;
  index = 1:size;
  row = mod(index-1,height)+1;
  column = ceil(index/height);
  
  %horizontal shift
  if choice(1) > 0
    tangents(:,tangentNum) = x1;
    tangentNum = tangentNum+1;
  end
  
  %vertical shift
  if choice(2) > 0
    tangents(:,tangentNum) = x2;
    tangentNum = tangentNum+1;
  end
  
  %scaling
  if choice(3) > 0
    tangents(:, tangentNum) = (column-offsetW).*x1 + (row-offsetH).*x2;
    tangentNum = tangentNum+1;
  end

  %rotation counterclockwise
  if choice(4) > 0
    tangents(:, tangentNum) = ((row-offsetH).*x1 - (column-offsetW).*x2)*factor;
    tangentNum = tangentNum+1;
  end
  
  %line thickness
  if choice(5) > 0
    tangents(:, tangentNum) = x1.^2 + x2.^2;
    tangentNum = tangentNum+1;
  end
  
  %compress in x-direction
  if choice(6) > 0
    tangents(:, tangentNum) = (offsetH-row).*x1;
    tangentNum = tangentNum+1;
  end
      
  %compress in y-direction
  if choice(7) > 0
    tangents(:, tangentNum) = (offsetW-column).*x2;
    tangentNum = tangentNum+1;
  end
  
  
  end
