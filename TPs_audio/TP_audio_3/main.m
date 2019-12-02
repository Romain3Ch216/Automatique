clear all;
close all;
clc;

%% TP1
Fe = 44100;
sig = gene_mono(0.2,Fe);
ITD = 0.3;
ILD = 5;
sig = apply_ild(sig,ILD);
sig = apply_itd(sig,ITD,Fe);
%soundsc(sig);

%% TP2
[hrir Fs]= hrir_loader(90,30,'1003');
% N = length(hrir);
% t =[0:N-1]/Fs;
% Te = 1/Fs;
h_g = hrir(:,1)/max(hrir(:,1));
h_d = hrir(:,2)/max(hrir(:,2));

sources.signaux = {h_g, h_d};
sources.freq = {Fs, Fs};
sources.titres = {'HRIR gauche', 'HRIR droite'};

cd ../audio_functions
[N_array,T_array,F_array,Gain,gain_ITF,phase_ITF] = plot_HRIR_HRTR_ITF(sources);
cd ../TP_audio_3

f = F_array{1};
coef_directeur = f(1:floor(length(f)/2))'\phase_ITF(1:floor(length(f)/2));

%% TP3

bathroom_data = load('bathroom.mat');
Fs = bathroom_data.fs;
bathroom = bathroom_data.h_air;
N = length(bathroom);
t = [0:N-1]/Fs;
ty = t;
bathroom_db = sig_in_db(bathroom);

y = -60*ones(1,N);
figure()
subplot(2,1,1);
plot(t,bathroom);
subplot(2,1,2);
plot(t,bathroom_db);hold on;
plot(ty,y);

office_data = load('office.mat');
Fs = office_data.fs;
office = office_data.h_air;
N = length(office);
t = [0:N-1]/Fs;

office_db = sig_in_db(office);

figure()
subplot(2,1,1);
plot(t,office);
subplot(2,1,2);
plot(t,office_db);hold on;
plot(ty,y);

stairway_data = load('stairway.mat');
Fs = stairway_data.fs;
stairway = stairway_data.h_air;
N = length(stairway);
t = [0:N-1]/Fs;

stairway_db = sig_in_db(stairway);

figure()
subplot(2,1,1);
plot(t,stairway);
subplot(2,1,2);
plot(t,stairway_db);hold on;
plot(ty,y);

%Temps de réverbération
%Bathroom : 0.3057s
%Office : 0.2968s
%Stairway : 0.6877s

%% TP4
Fe = 44.1e3;
Te = 1/Fe;
N = Fe + 1;
t = [0:N-1]*Te;
bruit_blanc = rand(1,N);
figure();
plot(t,bruit_blanc);

u = conv(bruit_blanc,bathroom);
tu = [0:length(u)-1]*Te;
figure();
subplot(3,1,1);
plot(tu,u);
xlim([0,1.5]);

v = conv(bruit_blanc,office);
tv = [0:length(v)-1]*Te;
subplot(3,1,2);
plot(tv,v);
xlim([0,1.5]);

w = conv(bruit_blanc,stairway);
tw = [0:length(w)-1]*Te;
subplot(3,1,3);
plot(tw,w);
xlim([0,1.5]);

[hrir Fs] = hrir_loader(45,0,'1003');
% N = length(hrir);
% t =[0:N-1]/Fs;
% Te = 1/Fs;
h_d = hrir(:,1);
h_g = hrir(:,2);

bruit_h = conv(bruit_blanc,h_d);

bruit_g = conv(bruit_blanc,h_g);
plot(bruit_g);

bruit(:,1) = bruit_h;
bruit(:,2) = bruit_g;

%soundsc(bruit);

w_g= conv(w,h_g);

%% TP5
clear array_itd
r = xcorr(h_g,h_d);

t = T_array{1};
figure();
subplot(2,1,1);
plot(t,h_g);hold on;
plot(t,h_d);
tt = [-t(end:-1:2),t];
subplot(2,1,2);
plot(tt,r);

%ITD = ITD_woodworth(13/100,340,deg2rad(90));

theta = [-pi:0.001:pi];
for i=1:length(theta)
    array_itd(i) = ITD_woodworth(0.13,340,theta(i));
end

yy = 5.89e-4*ones(length(theta));
figure();
plot(theta,array_itd);hold on;
plot(theta,yy);







