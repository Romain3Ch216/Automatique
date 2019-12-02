function s_filtre = passe_bande(signal,Fe,f1,f2,ordre)
    f = [0 f1 f2 Fe]/Fe ; 
    m = [0 1 1 0];
    b = fir2(ordre,f,m); 
    s_filtre = filter(b,1,signal);
end