function [y,out] = diagramme(SOURCE,theta_source,ANTENNE,theta_0)
% DIAGRAMME Identification d'un diagramme d'antenne
%
% DIAGRAMME(SOURCE,theta_source,ARRAY) computes the output of a standart
% beamforming for a linear array being polarized in a given azimuth.
%  * SOURCE is a structure with the following data:
%     - SOURCE.signal: source signal
%     - SOURCE.fe: sampling frequency
%  * theta_source is the source azimuth in degrees
%  * ARRAY is a Matlab structure with the following data:
%     - ARRAY.N : number of microphones in the array,
%     - ARRAY.C : speed of sound,
%     - ARRAY.D : microphone interspace,
%     - ARRAY.Pos : microphone positions
%
% [y,out] = DIAGRAMME(SOURCE,theta_source,ARRAY,theta_pol) also computes
% the outputs for each filter in the beamformers. theta_pol can be used to
% specify the polarization of the array.

% x_source must be a row vector

if (nargin < 4) theta_0 = 130; end %Si la polarisation de l'antenne n'est pas spécifiée en argument,
%alors elle est par défaut égale à 130°

x_source = SOURCE.signal;
siz = size(x_source);
if (siz(1) == 1) x_source = x_source.'; end

N = length(x_source);
X_source = fft(x_source.*ones(N,1));
f = (0:SOURCE.fe/N:(N-1)/N*SOURCE.fe).';

tau_source = ANTENNE.Pos./ANTENNE.C.*cos(theta_source*pi/180); %calcule le retard pour chaque micros
tau_0 = ANTENNE.Pos./ANTENNE.C.*cos(theta_0*pi/180);
delay = exp(j*2*pi*kron(f,tau_0-tau_source)); %calcul des nb_micros vecteurs d'antennes de taille 501
Y = kron(X_source,ones(1,ANTENNE.N)).*delay; %on applique la fonction de transfert 'vecteur d'antenne' à 
%la fft de la source, on obtient le spectre de  sortie des micros, Y est une matrice 
%de taille 501 (la taille du signal) par nb_micros

%Ici ce fait l'atténuation (ou pas) de la source en prenant le conjugué du
%signal ?
if (mod(N,2)==0) %N est pair
    Y(N/2+2:end,:) = conj(Y(N/2:-1:2,:));
else % N est impair
    Y(round(N/2)+1:end,:) = conj(Y(round(N/2):-1:2,:));
end

out = real(ifft(Y));%on revient au signal temporel
y = sum(out,2)/ANTENNE.N; %on somme les sorties des micros