function [t,f,tfd,sd] = st(s,Fs,Nf)
    sd = [];
    N = length(s);
    for i=1:Nf
        sd = [sd s(1+floor(N/Nf)*(i-1):i*floor(N/Nf))];
    end
    tfd = [];
    n = length(sd(:,1));
    Amax = max(abs(fft(s)));
    for i=1:Nf
        fft_s = abs(fft(sd(:,i)));
        fft_s = fft_s(1:floor(n/2));
        for i=1:length(fft_s)
            %Condition pour éviter que le log diverge
            if fft_s(i)<1e-2
                fft_s(i) = -100;
            else
                fft_s(i) = 20*log(fft_s(i)/Amax)/log(10);
            end
        end
        tfd = [tfd fft_s];
    end
    Te = 1/Fs;
    t = [0.5:Nf-0.5]*(Te*N/Nf);
    f = [0:n-1]/(n*Te);
    f = f(1:floor(n/2));
end