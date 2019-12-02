function [signal,Fe,N,t,f,spectre] = plot_signal(source)
    Fe = source.fe;
    signal = source.signal;
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