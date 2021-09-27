function fneu = myEasyClassifier(G, f0, p, lambda, its, conv)
falt = f0;
%tau = 10e-9;
fneu = gaussjacobidiffusion(falt, f0, p, lambda, G);
diff = norm(fneu-falt);

if conv
    while diff > eps
        falt = fneu;
        fneu = gaussjacobidiffusion(falt, f0, p, lambda, G);
        diff = norm(fneu-falt);
        disp(diff)
    end
else
    for i = 1:its
        falt = fneu;
        fneu = gaussjacobidiffusion(falt, f0, p, lambda, G);
        diff = norm(fneu-falt);
        disp(diff)
    end
end
end