function [k_max,f_max] = max_frequences_energie(signal,Fe,nb_f)
    N = length(signal);
    Te = 1/Fe;
    f = [0:N-1]/(N*Te);
    f = f(1:floor(N/2));
    spectre = abs(fft(signal));
    spectre = spectre(1:floor(N/2));
    N = floor(N/2);
    if nb_f == 1
        [max_ampl,k_max] = max(spectre);
        f_max = f(k_max);
    else
        [sort_amp, sort_k] = sort(spectre);
        k_max = sort_k(N:-1:N-nb_f+1);
        for i=1:nb_f
            f_max(i) = f(k_max(i));
        end
    end
end