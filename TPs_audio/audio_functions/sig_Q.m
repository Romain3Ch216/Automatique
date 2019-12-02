function Q = sig_Q(signal)
    %Entrée : vecteur signal
    %Sortie : quantum du signal
    sig = sort(signal);
    sig = unique(sig);
    n = length(sig);

    Q = 1e5;

    for i=1:n-1
        diff = abs(sig(i+1) - sig(i));
        if diff < Q
            Q = diff;
        end
    end
end