function Signal = decouper_signal(signal,K)
    %Entr�es : signal et nombre de points par fen�tre K
    N = length(signal);
    nb_fen = floor(N/K);
    for i=1:nb_fen
        Signal(i,:) = signal((i-1)*K+1:i*K);
    end
end