function fneu = myClassifier(G, f0, p, lambda)
falt = f0;
fneu = gaussjacobidiffusion(falt, f0, p, lambda, G);
diff = norm(fneu-falt);
while(diff>1e-3)
%for i = 1:1
    falt = fneu;
    fneu = gaussjacobidiffusion(falt, f0, p, lambda, G);
    diff = norm(fneu-falt);
    %disp(diff)
end
end