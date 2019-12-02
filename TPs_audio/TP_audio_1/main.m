clear all;
close all;
clc;

[Signal,fs] = audioread('phrase.wav');

cd ../audio_functions
[N,t,f,spectre] = plot_signal(Signal,fs);
cd ../TP_audio_1

signal_source = [t', Signal/max(abs(Signal))];

cd ../audio_functions
Q = sig_Q(Signal);
cd ../TP_audio_1

%Q = 6.1035e-05

info_signal = audioinfo('phrase.wav')
%BitsPerSample: 16

Vp = Q*2^16;
%Vp = 4 La valeur de Q est donc cohérente.
%Le signal peut être codé entre -2V et 2V. Au-delà, il sature.


