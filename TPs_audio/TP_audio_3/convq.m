function c = convq(x,y)
% c = convq(x,y)
% Fast convolution between x and y using FFT.

% reshaping data
x = reshape(x,length(x),1);
y = reshape(y,length(y),1);

% length of the convolued signal
Nfft = length(x)+length(y)-1;

% convolution
c = real(ifft(fft(x,Nfft).*fft(y,Nfft)));