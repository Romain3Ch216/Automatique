function [N_array,T_array,F_array,Gain,gain_ITF,phase_ITF] = plot_HRIR_HRTR_ITF(sources)
    %sources.signaux = {gauche,droite};
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
        spectre = spectre/max(spectre);
        gain = 20*log(spectre)/log(10);
        Gain{k} = gain(1:floor(N/2));
    end
    figure('Name','Visualisation temporelle');
    for k=1:K
        fig = subplot(K,1,k);
        plot(T_array{k}(1:1000),sources.signaux{k}(1:1000)); 
        title(sources.titres{k});
        xlabel('Temps (s)');
        ylabel('Amplitude');
    end
    figure('Name','Visualisation fréquentielle');
    for k=1:K
        fig = subplot(K,1,k);
        plot(F_array{k},Gain{k}); 
        title(sources.titres{k});
        xlabel('Fréquence(Hz)');
        ylabel('Amplitude (dB)');
    end
    
    ITF = fft(sources.signaux{1})./fft(sources.signaux{2});
    ITF = ITF(1:floor(N/2));
    gain_ITF = abs(ITF);
    phase_ITF = unwrap(angle(ITF));
    
    figure('Name',"ITF");
    subplot(2,1,1);
    plot(F_array{1},gain_ITF);
    title('Gain ITF');
    xlabel('Fréquence(Hz)');
    ylabel('Amplitude (dB)');
    subplot(2,1,2);
    plot(F_array{1},phase_ITF);
    title('Phase ITF');
    xlabel('Fréquence(Hz)');
    ylabel('Phase (deg)');
end