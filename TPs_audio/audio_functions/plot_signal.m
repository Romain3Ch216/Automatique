function [N,t,f,spectre] = plot_signal(signal,Fe)
    %Entrées : signal et fréquence d'échantillonnage
    %Sorties : longueur signal N, vecteur temps t, vecteur fréquence f,
    %spectre du signal spectre
    %Affiche le signal par rapport au temps et le spectre du signal
    N = length(signal);
    t = [0:N-1]*(1/Fe);
    f = [0:N-1]*(Fe/N);
    f = f(1:floor(N/2));
    spectre = abs(fft(signal));
    spectre = spectre(1:floor(N/2));
    figure();
    subplot(2,1,1);
    plot(t,signal);
    subplot(2,1,2);
    plot(f,spectre);
end