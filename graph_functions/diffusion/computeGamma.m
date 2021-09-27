function gamma = computeGamma(W, falt, p, n,m)
  ngrad = computeNormedGradient(W,falt,p,n,m);
  nGGrid = repmat(ngrad,1,n);
  gamma = W.*(nGGrid+nGGrid');
end