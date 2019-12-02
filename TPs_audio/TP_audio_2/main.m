clear all;
close all;
clc;

%%
%TP 1 

%Chargement des données audio
[sinus Fs_s] = audioread('sinus.wav');
[voix Fs_v] = audioread('voix.wav');
[bruit_blanc Fs_b] = audioread('bruit_blanc.wav');

sources.signaux = {sinus,voix,bruit_blanc};
sources.freq = {Fs_s, Fs_v, Fs_b};
sources.titres = {'sinus', 'voix', 'bruit blanc'};

%%

cd ../audio_functions
[N,T,F,Spectres] = plot_signaux(sources);
cd ../TP_audio_2

%Signal inverse
%%
cd ../audio_functions
sources.signaux = {inv_signal(sinus),inv_signal(voix),inv_signal(bruit_blanc)};
cd ../TP_audio_2

cd ../audio_functions
[N,T,F,Spectres] = plot_signaux(sources);
cd ../TP_audio_2

%%
%TP3

%Choix du nombre de fenêtres Nf
Nf = 60;
%On observe le principe d'incertitude d'Heinsenberg en variant le nombre de
%fenêtres 

%Visualisation de la représentation temps - fréquence
sources.signaux = {sinus,voix,bruit_blanc};

cd ../audio_functions
[t_array,f_array,tfd_array,sd_array] = temp_freq(sources,Nf);
cd ../TP_audio_2

%%
%TP 4

cd ../audio_functions
cochleogram(sinus,0,1000,10,sources.freq{1});
cochleogram(voix,0,1000,10,sources.freq{2});
cochleogram(bruit_blanc,0,1000,3,sources.freq{3});


