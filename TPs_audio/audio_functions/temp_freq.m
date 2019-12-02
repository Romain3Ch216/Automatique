function [t_array,f_array,tfd_array,sd_array] = temp_freq(sources,Nf)
    figure('Name','Visualisation temporelle - fr�quentielle')
    K = size(sources.signaux,2);
    for k=1:K
        fig = subplot(K,1,k);
        [t_array{k},f_array{k},tfd_array{k},sd_array{k}] = ...
            st(sources.signaux{k},sources.freq{k},Nf);
        imagesc(t_array{k},f_array{k},tfd_array{k})
        set(gca,'YDir','normal')
        c = colorbar;
        ylabel('Fr�quence (Hz)');
        xlabel('Temps (s)');
        title(c,'Amplitude relative (dB)');
    end
end