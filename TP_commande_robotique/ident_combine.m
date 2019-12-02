%% CE SCRIPT PERMET D'IDENTIFIER LES PARAMETRES DES
%% TERMES DE COUPLAGE POUR LES AXES 1 et 2
%% v1 G. MOREL - 2005/12/29
%% v2 V. PADOIS - 2007/10/31
%% v3 V. PADOIS - 2012/12/03

clear all;
close all;
clc;
load releve_mvts_combines;

%% constantes connues
kc1=0.0525;
N1=20.25;
kc2=0.0525;
N2=4.5;

%% Parametres identifies a vitesse constante
%% Pour l'axe 1 : 
alpha1=0.889140184994100;
a1=0.181533806305298;
b1=-0.000266353356286;
c1=-0.048843223218079;
%% Pour l'axe 2 :
alpha2=0.085326167595372;
a2=0.078433190540950;
b2=0.000332664823074;
c2=-0.011870656685087;

%% identification a partir des donnees filtrees
for(i=1:length(t)) 
    Z(2*i-1:2*i,1:3)=[qppfil1(i), qppfil2(i)*cos(q2(i)-q1(i))-qpfil2(i)^2*sin(q2(i)-q1(i)),0 ;...
        0, qppfil1(i)*cos(q2(i)-q1(i))+qpfil1(i)^2*sin(q2(i)-q1(i)), qppfil2(i)];
    u(2*i-1,1)=N1*kc1*ifil1(i) - alpha1*cos(q1(i)) - a1*sign(qpfil1(i))+b1*qpfil1(i)+c1;
    u(2*i,1)=N2*kc2*ifil2(i) - alpha2*cos(q2(i)) - a2*sign(qpfil2(i))+b2*qpfil2(i)+c2;
end

p=pinv(Z)*u;
format long
disp('Parametres estimes a partir des donnees filtrees :');
p'

% reconstruction du modele complet
p1=p(1);
p2=p(2);
p3=p(3);

for(i=1:length(t)) 
    %% couple d'inertie
    ciner(2*i-1,1)=p1*qppfil1(i)+p2*cos(q2(i)-q1(i))*qppfil2(i); %% AXE 1 
    ciner(2*i,1)=p2*cos(q2(i)-q1(i))*qppfil1(i)+p3*qppfil2(i); %%AXE 2
    %% couple centrifuge
    ccentri(2*i-1,1)=-p2*sin(q2(i)-q1(i))*qpfil2(i)^2; %% AXE 1
    ccentri(2*i,1)=p2*sin(q2(i)-q1(i))*qpfil1(i)^2; %% AXE 2
    %% couple de gravite
    cgravi(2*i-1,1) = alpha1*cos(q1(i)); %% AXE 1
    cgravi(2*i,1) = alpha2*cos(q2(i)); %% AXE 2
    %% couple de frottements
    cfrott(2*i-1,1)=a1*sign(qpfil1(i))+b1*qpfil1(i)+c1; %% AXE 1
    cfrott(2*i,1)=a2*sign(qpfil2(i))+b2*qpfil2(i)+c2; %% AXE 2
    %% couple total
    ctotal(2*i-1:2*i,1)=ciner(2*i-1:2*i,1)+ccentri(2*i-1:2*i,1)+cgravi(2*i-1:2*i,1)+cfrott(2*i-1:2*i,1);
end

%% Affichage des commandes.
figure(1) %% pour l'axe 1
clf
hold on
grid on
h=plot(t,N1*kc1*i1,'y');
h=plot(t,N1*kc1*ifil1,'b');
set(h,'LineWidth',1.5);
h=plot(t,ciner(1:2:length(ctotal)),'r');
set(h,'LineWidth',1.5);
h=plot(t,cgravi(1:2:length(ctotal)),'m');
set(h,'LineWidth',1.5);
h=plot(t,ccentri(1:2:length(ctotal)),'k');
set(h,'LineWidth',1.);
h=plot(t,cfrott(1:2:length(ctotal)),'g');
set(h,'LineWidth',1.);
h=plot(t,ctotal(1:2:length(ctotal)),'c--');
set(h,'LineWidth',1.5);
legend('\Gamma_1 mesure','\Gamma_1 filtre','inertie','gravite','centrifuge','frottements','modele total');
title('Resultats axe 1 ; identification a partir de donnees filtrees');
figure(2)
clf
hold on
grid on
h=plot(t,N2*kc2*i2,'y');
h=plot(t,N2*kc2*ifil2,'b');
set(h,'LineWidth',1.5);
h=plot(t,ciner(2:2:length(ctotal)),'r');
set(h,'LineWidth',1.5);
h=plot(t,cgravi(2:2:length(ctotal)),'m');
set(h,'LineWidth',1.5);
h=plot(t,ccentri(2:2:length(ctotal)),'k--');
set(h,'LineWidth',1);
h=plot(t,cfrott(2:2:length(ctotal)),'g');
set(h,'LineWidth',1);
h=plot(t,ctotal(2:2:length(ctotal)),'c--');
set(h,'LineWidth',1.5);
legend('\Gamma_2 mesure','\Gamma_2 filtre','inertie','gravite','centrifuge','frottements','modele total');
title('Resultats axe 2 ; identification a partir de donnees filtrees');
