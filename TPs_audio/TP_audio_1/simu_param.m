close all 
clear all
clc
%%%
%%% SIMULATION DE LA PROPAGATION
%%%
%%% ***********************************************************************

% Chargement du signal de source
% -------------------------------------------------------------------------
[Signal,fs] = audioread('voix1.wav');
N = length(Signal);
tp = [0:N-1].'*1/fs;
% Tracé du signal en fonction du temps:
plot(tp,Signal)
signal_source = [tp, Signal/max(abs(Signal))];

% Pour le sinus :
f0 = 1000;

% Durée de la simulation (en sec):
T_sim = 0.1;

% Filtre passe-bas
% -------------------------------------------------------------------------
load filtre

% Paramètres de l'antenne
% -------------------------------------------------------------------------
ANTENNE.N = 4;    % Nombre de microphones
ANTENNE.C = 340;  % Vitesse du son
ANTENNE.D = 0.8;  % Distance entre les microphones
for i=1:ANTENNE.N % Position des microphones
    ANTENNE.Pos(i) = (i-(ANTENNE.N + 1)/2)*ANTENNE.D;
end