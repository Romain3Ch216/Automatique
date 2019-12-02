function [sig_dec] = signal_fenetre(signal,K)
    sig_dec = [];
    n = length(signal);
    L = floor(n/K);
    for i=1:L
        sig_dec = [sig_dec signal(1+K*(i-1):K*i)];
    end    
end