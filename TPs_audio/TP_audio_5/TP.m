close all
clear all
clc

%% Etude du diagramme d'antenne
% -------------------------------------------------------------------------
ANTENNE.N = 10; % Nombre de microphones
ANTENNE.C = 340; % Vitesse du son
ANTENNE.D = 0.06; % Distance entre les microphones
for i=1:ANTENNE.N % Position des microphones
    ANTENNE.Pos(i) = (i-(ANTENNE.N + 1)/2)*ANTENNE.D;
end

% Source
load('source1.mat');
%Signal réaliste d'un cas de robotique
t = [0:length(SOURCE.signal)-1]/SOURCE.fe;
%f = [500, 1000, 2000, 3000, 4000, 5000, 6000, 7000];
%A = [1,5,10,20,8,12,6,3];
% SOURCE.signal = 0*t;
% for i=1:length(f)
%     SOURCE.signal = SOURCE.signal + sin(2*pi*f(i)*t);
% end

[signal,Fe,N,t,f,spectre] = plot_signal(SOURCE);
%%

theta = [0:1:360];
for i=1:length(theta)
    power(i) = puissance_signal(diagramme(SOURCE,theta(i),ANTENNE));
end

figure();
polarplot(power);

%%
%ON FAIT BOUGER LA SOURCE POUR IDENTIFIER LA POLARISATION DE L'ANTENNE
theta = [0:1:180];
f = [500:200:10000];

for k=1:length(f)
    SOURCE.signal = sin(2*pi*f(k)*t);
    power = 0*theta;
    for i=1:length(theta)
        power(i) = puissance_signal(diagramme(SOURCE,theta(i),ANTENNE));
        POWER(k,i) = puissance_signal(diagramme(SOURCE,theta(i),ANTENNE));
    end
    %figure();
    %polarplot(power);
end

surf(theta,f,POWER);
xlabel('azimuth');
ylabel('fréquence');
title("Diagramme d'antenne - représentation 2D")

%% TP2

%ON DISPOSE D'UNE ANTENNE, ON SOUHAITE LOCALISER LA SOURCE 

%VISUALISATION DES SORTIES DES 4 MICROS ET DE LEURS SPECTRES
load('data1.mat');

micros.signaux = {MICROS.Signal(:,1),MICROS.Signal(:,2),...
    MICROS.Signal(:,3),MICROS.Signal(:,4)};

Fe = MICROS.fe;
micros.freq = {Fe,Fe,Fe,Fe};
micros.titres = {'Signal 1','Signal 2', 'Signal 3', 'Signal 4'};

cd ../audio_functions
plot_signaux(micros);
cd ../TP_audio_5

%%
theta = [0:1:360];
for i=1:length(theta)
    beam = beamforming(MICROS.Signal,MICROS.fe,ANTENNE,theta(i));
    nrj_map(i) = puissance_signal(beam);
end

figure();
polarplot(nrj_map);
thetalim([0,180]);

%% LOCALISATION AU COURS DU TEMPS data 2
clear all;
close all;
clc; 

load('data2.mat');

micros.signaux = {MICROS.Signal(:,1),MICROS.Signal(:,2),...
    MICROS.Signal(:,3),MICROS.Signal(:,4)};

Fe = MICROS.fe;
micros.freq = {Fe,Fe,Fe,Fe};
micros.titres = {'Signal 1','Signal 2', 'Signal 3', 'Signal 4'};

cd ../audio_functions
plot_signaux(micros);
cd ../TP_audio_5


for i=1:4
    Signal(:,:,i) = decouper_signal(MICROS.Signal(:,i),512);
end

theta = [0:1:360];

for k=1:size(Signal,1)%pour chaque fenêtre temporelle
    for i=1:length(theta)%pour chaque azimuth
        signaux = reshape(Signal(k,:,:),[size(Signal,2),size(Signal,3)]);
        beam = beamforming(signaux,MICROS.fe,ANTENNE,theta(i));%on écoute le signal en polarisant l'antenne à theta
        nrj_map(k,i) = puissance_signal(beam);
    end
end

nrj_map = nrj_map/max(nrj_map(:));%normalisation par le max

[max_nrj,theta_dir] = max(nrj_map');

figure();
for k=1:size(Signal,1)
    polarplot(nrj_map(k,:));hold on;
    thetalim([0,180]);
    pause(0.05);
    hold off;
end
 
[max_nrj,theta_dir] = max(nrj_map');

figure();
plot(theta_dir, 'o');
    
%% LOCALISATION AU COURS DU TEMPS Data 3
clear all;
close all;
clc; 

load('data3.mat');

micros.signaux = {MICROS.Signal(:,1),MICROS.Signal(:,2),...
    MICROS.Signal(:,3),MICROS.Signal(:,4)};

Fe = MICROS.fe;
micros.freq = {Fe,Fe,Fe,Fe};
micros.titres = {'Signal 1','Signal 2', 'Signal 3', 'Signal 4'};

cd ../audio_functions
plot_signaux(micros);
cd ../TP_audio_5


for i=1:4
    Signal(:,:,i) = decouper_signal(MICROS.Signal(:,i),512);
end

theta = [0:1:360];

for k=1:size(Signal,1)
    for i=1:length(theta)
        signal = reshape(Signal(k,:,:),[size(Signal,2),size(Signal,3)]);
        beam = beamforming(signal,MICROS.fe,ANTENNE,theta(i));
        nrj_map(k,i) = puissance_signal(beam);
    end
end

nrj_map = nrj_map/max(nrj_map(:));

figure();
for k=1:size(Signal,1)
    polarplot(nrj_map(k,:));hold on;
    thetalim([0,180]);
    rlim([0,1]);
    pause(0.2);
    hold off;
end

%% LOCALISATION AU COURS DU TEMPS Data 4
clear all;
close all;
clc; 

load('data4.mat');

micros.signaux = {MICROS.Signal(:,1),MICROS.Signal(:,2),...
    MICROS.Signal(:,3),MICROS.Signal(:,4)};

Fe = MICROS.fe;
micros.freq = {Fe,Fe,Fe,Fe};
micros.titres = {'Signal 1','Signal 2', 'Signal 3', 'Signal 4'};

cd ../audio_functions
plot_signaux(micros);
cd ../TP_audio_5

%Définition d'un passe-bande
f1 = 400 ; 
f2 = 600;
ordre = 100;

for i=1:4
    Signal(:,:,i) = decouper_signal(MICROS.Signal(:,i),512);
    Signal(:,:,i) = passe_bande(Signal(:,:,i),Fe,f1,f2,ordre);
end

theta = [0:1:360];

for k=1:size(Signal,1)
    for i=1:length(theta)
        signal = reshape(Signal(k,:,:),[size(Signal,2),size(Signal,3)]);
        beam = beamforming(signal,MICROS.fe,ANTENNE,theta(i));
        nrj_map(k,i) = puissance_signal(beam);
    end
end

nrj_map = nrj_map/max(nrj_map(:));

figure();
for k=1:size(Signal,1)
    polarplot(nrj_map(k,:));hold on;
    thetalim([0,180]);
    rlim([0,1]);
    pause(0.1);
    hold off;
end

[max_nrj,theta_dir] = max(nrj_map');

figure();
plot(theta_dir,'o')

beam = beamforming(MICROS.Signal,MICROS.fe,ANTENNE,60);
%%

cd ../audio_functions
plot_signal(beam,Fe);
plot_signal(micros.signaux{1},Fe);
cd ../TP_audio_5

%%
load('data5.mat');

micros.signaux = {MICROS.Signal(:,1),MICROS.Signal(:,2),...
    MICROS.Signal(:,3),MICROS.Signal(:,4)};

Fe = MICROS.fe;
micros.freq = {Fe,Fe,Fe,Fe};
micros.titres = {'Signal 1','Signal 2', 'Signal 3', 'Signal 4'};

cd ../audio_functions
plot_signaux(micros);
cd ../TP_audio_5

source.signaux = {MICROS.Signal(:,1)};
source.freq = {MICROS.fe};
cd ../audio_functions
[t_array,f_array,tfd_array,sd_array] = temp_freq(source,40);
cd ../TP_audio_5



 
