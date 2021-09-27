function d = twosidedTangentDistance(E, P, choice, width, height, background)
  %%calculates distance between tangent spaces as proposed in Simard et al. 
  
  LE = calculateTangents(E, choice, width, height, background);
  LP = calculateTangents(P, choice, width, height, background);
  
  size = width * height; 
  
  LE = ortho(LE, size);
  LP = ortho(LP, size);
  
  LEE = LE'*LE;
  LPP = LP'*LP;
  
  LEP = LE'*LP;
  LPE = LEP';
  
  invLEE = inv(LEE);
  invLPP = inv(LPP);
  
  MP = LPE*invLEE*LE'-LP';
  ME = LEP*invLPP*LP'-LE';
  
  BP = LPE*invLEE*LEP'-LPP';
  BE = -(LEP*invLPP*LPE'-LEE');
  
  aE = BE\(ME*(E-P));
  aP = BP\(MP*(E-P));
  
  PE = E+LE*aE;
  PP = P+LP*aP;
  
  d = norm(PE-PP);
  
end
