function [sig_stereo] = apply_itd(sig,ITD,Fe)
% Fonction qui applique un ITD donné à un signal mono ou stéréo.
%
% sig : signal à traiter (mono ou stéréo)
% ITD : ITD à appliquer au signal (en millisecondes)

% Création de la matrice signal finale
Nb_dec = abs(round(0.001*ITD*Fe)) ; %conversion en secondes et calcul du nbr 
%d'échantillons à décaler pour représenter l'ITD
Nb_sample = length(sig) ;
sig_stereo = zeros(Nb_sample+Nb_dec,2) ;

% Gestion du cas ou le signal d'entrée est mono
if size(sig,2)==1
    sig_fill = zeros(Nb_sample,2) ;
    sig_fill(:,1) = sig ;
    sig_fill(:,2) = sig ;
else
    sig_fill = sig ;
end

% Création de l'ITD
if (ITD>0)
    sig_stereo(1:Nb_sample,1) = sig_fill(:,1) ;
    sig_stereo(Nb_dec+1:Nb_dec+Nb_sample,2) = sig_fill(:,2) ;%création du décalage temporel 
else
    sig_stereo(1:Nb_sample,2) = sig_fill(:,1) ;
    sig_stereo(Nb_dec+1:Nb_dec+Nb_sample,1) = sig_fill(:,2) ;
end