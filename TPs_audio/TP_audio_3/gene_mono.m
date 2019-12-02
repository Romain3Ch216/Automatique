function [sig] = gene_mono(T,Fe)
% G�n�ration d'un signal mono de dur�e T � la fr�quence d'�chantillonnage
% Fe

% Cr�ation du signal mono
Nb_sample = round(Fe*T) ; %calcul du nbr d'�chantillons
sig = randn(Nb_sample,1) ; %cr�ation d'un vecteur d'�chantillons al�atoires entre -1 et 1 

% filtrage passe-bas pour ne garder de l'�nergie qu'en dessous de 4 kHz
F_pb = 4000 ; %
f = [0 F_pb F_pb Fe]/Fe ; %f coupl� � m d�fini le filtre, �a passe en dessous de Fpb, �a passe plus � partir de Fpb
m = [1 1 0 0];
b = fir2(100,f,m); %d�finition d'un filtre d'ordre 100
sig = filter(b,1,sig) ; %filtrage du signal par une fonction de transfert de num�rateur b et d�nominateur 1

% Normalization du signal
sig = 0.9*(sig-mean(sig))/max(sig) ;