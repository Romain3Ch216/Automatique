function [sig] = gene_mono(T,Fe)
% Génération d'un signal mono de durée T à la fréquence d'échantillonnage
% Fe

% Création du signal mono
Nb_sample = round(Fe*T) ; %calcul du nbr d'échantillons
sig = randn(Nb_sample,1) ; %création d'un vecteur d'échantillons aléatoires entre -1 et 1 

% filtrage passe-bas pour ne garder de l'énergie qu'en dessous de 4 kHz
F_pb = 4000 ; %
f = [0 F_pb F_pb Fe]/Fe ; %f couplé à m défini le filtre, ça passe en dessous de Fpb, ça passe plus à partir de Fpb
m = [1 1 0 0];
b = fir2(100,f,m); %définition d'un filtre d'ordre 100
sig = filter(b,1,sig) ; %filtrage du signal par une fonction de transfert de numérateur b et dénominateur 1

% Normalization du signal
sig = 0.9*(sig-mean(sig))/max(sig) ;