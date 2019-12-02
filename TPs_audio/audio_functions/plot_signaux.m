function [N_array,T_array,F_array,Spectres,x,y] = plot_signaux(sources,varargin)
    %sources.signaux = {sinus,voix,bruit_blanc};
    %sources.freq = {Fs_s, Fs_v, Fs_b};
    %sources.titles = {'sinus', 'voix', 'bruit_blanc'};
    K = size(sources.signaux,2);
    for k=1:K
        signal = sources.signaux{k};
        Fe = sources.freq{k};
        N = length(signal);
        N_array{k} = N;
        T_array{k} = [0:N-1]*(1/Fe);
        f = [0:N-1]*(Fe/N);
        F_array{k} = f(1:floor(N/2));
        spectre = abs(fft(signal));
        Spectres{k} = spectre(1:floor(N/2));
    end
    figure('Name','Visualisation temporelle');
    for k=1:K
        fig = subplot(K,1,k);
        plot(T_array{k},sources.signaux{k}); 
        title(sources.titres{k});
        xlabel('Temps (s)');
        ylabel('Amplitude');
    end
    if isempty(varargin) == 0
        [x,y,button] = ginput(2);
    end
    figure('Name','Visualisation fréquentielle');
    for k=1:K
        fig = subplot(K,1,k);
        plot(F_array{k},Spectres{k}); 
        title(sources.titres{k});
        xlabel('Fréquence(Hz)');
        ylabel('Amplitude');
    end
end