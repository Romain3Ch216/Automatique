function [t,f,tfd,sd] = st(s,Fs,Nf)
    %s le signal, Fs la fr�quence d'�chantillonage, Nf le nb de fen�tre
    sd = [];
    N = length(s);
    for i=1:Nf
        sd = [sd s(1+floor(N/Nf)*(i-1):i*floor(N/Nf))];%on d�coupe le signal
    end
    tfd = [];
    n = length(sd(:,1));
    Amax = max(abs(fft(s)));
    %on calcule les spectres pour chaque fenetre 
    for i=1:Nf
        fft_s = abs(fft(sd(:,i)));
        fft_s = fft_s(1:floor(n/2));
        for i=1:length(fft_s)
            %Condition pour �viter que le log diverge
            if fft_s(i)<1e-2
                fft_s(i) = -100;
            else
                fft_s(i) = 20*log(fft_s(i)/Amax)/log(10); %normalisation par le max
            end
        end
        tfd = [tfd fft_s];
    end
    Te = 1/Fs;
    t = [0.5:Nf-0.5]*(Te*N/Nf);
    f = [0:n-1]/(n*Te);
    f = f(1:floor(n/2));
end