function power = puissance_signal(signal)
    F = fft(signal);
    power = sum(F.*conj(F));
end