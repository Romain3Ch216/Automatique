function [sig_stereo] = apply_ild(sig,ILD)
% Fonction qui applique un ILD donn� � un signal mono UNIQUEMENT.
%
% sig : signal � traiter (MONO)
% ILD : ILD � appliquer au signal (en dB)

sig_stereo = zeros(length(sig),2) ; %cr�e deux pistes
sig_stereo(:,1) = sig ; 
sig_stereo(:,2) = 10^(ILD/20)*sig ; %applique la diff�rence de niveau sonore � l'une d'entre elles
sig_stereo = sig_stereo/max(sig_stereo(:)) ; %normalisation