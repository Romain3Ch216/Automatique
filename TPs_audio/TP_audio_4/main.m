clear all;
close all;
clc;

%% Analyse des signaux

data = load('data3.mat');
structure_antenne = data.ANTENNE;
signaux = data.MICROS.Signal;
Fe = data.MICROS.Fe;
t = data.MICROS.t;

source.signaux = {signaux(:,1),signaux(:,2),signaux(:,3),signaux(:,4)};
source.freq = {Fe,Fe,Fe,Fe};
source.titres = {'Micro 1','Micro 2','Micro 3','Micro 4'};

cd ../audio_functions
plot_signaux(source);
cd ../TP_audio_4

%% Localisation
K = 512;
nb_f = 2;
[max_k,max_f] = freq_of_interest(data.MICROS,K,nb_f);
[L,Y] = matrice_covariance(data.MICROS,K,max_k);

[Gamma,base_esp_bruit,base_esp_sig,diag_gamma] = gamma_estim(Y,L);

proj_esp_bruit = projecteur_esp_bruit(base_esp_bruit);

P = localisation([0,4],0.5,[0,180],1,max_f,data.ANTENNE,proj_esp_bruit);








