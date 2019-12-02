function [L,Y] = matrice_covariance(MICROS,K,f_ind)
    N = size(MICROS.Signal,2); %Nbr de micros
    n = size(MICROS.Signal,1); %Longueur signaux
    L = floor(n/K); %Nbr de fenêtres
    Y = zeros(N,L);
    for k=1:size(f_ind)
        for i=1:N
            signal = MICROS.Signal(:,i);
            sig = signal_fenetre(signal,K);
            for j=1:L
                fft_sig = fft(sig(:,j));
                Y(i,j,k) = fft_sig(f_ind(k));
            end
        end
    end
end