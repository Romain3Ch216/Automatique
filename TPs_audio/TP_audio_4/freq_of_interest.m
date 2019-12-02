function [max_k,max_f] = freq_of_interest(MICROS,K,nb_f)
    signal = MICROS.Signal(:,1);
    sig = signal_fenetre(signal,K);
    [max_k, max_f] = max_frequences_energie(sig(:,1),MICROS.Fe,nb_f);
end