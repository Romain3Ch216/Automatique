function [sig_stereo] = apply_ild(sig,ILD)
% Fonction qui applique un ILD donné à un signal mono UNIQUEMENT.
%
% sig : signal à traiter (MONO)
% ILD : ILD à appliquer au signal (en dB)

sig_stereo = zeros(length(sig),2) ; %crée deux pistes
sig_stereo(:,1) = sig ; 
sig_stereo(:,2) = 10^(ILD/20)*sig ; %applique la différence de niveau sonore à l'une d'entre elles
sig_stereo = sig_stereo/max(sig_stereo(:)) ; %normalisation