%% TP 2 Automatique

clear;
clc;
close all;

%% Système

% Variables 

K_m = 253.05; % rad/sV
tau_m = 0.47; % s
K_rpm = 60/(2*pi);
K_r = 1/32;

% Dimensions

m = 1; % entrés
p = 1; % sorties
n = 2; % états

% Vecteur du retard de mésure

T_r = [0.01;0.05;0.1]*tau_m;

% Représentation d'état du système en boucle ouverte

s = tf('s');

for i = 1:length(T_r)
    G = (K_m*K_rpm)/(1+tau_m*s);
    G_r = (1-T_r(i)/2*s)/(1+T_r(i)/2*s);
    G_g(i) = G*K_r*G_r;
    [A(:,:,i),B(:,:,i),C(:,:,i),D(:,:,i)] = ssdata(G_g(i));
    G_g(i) = ss(G_g(i));
end

%%
clear i G G_r

% Modèles augmentés de l'observateur

pi_o = -100;
t_pi_o = ones(1,p);

for i=1:length(T_r)
    if eig(A(:,:,i)) == pi_o
        disp('Attention: Pole de l`observateur = Pole du système!');
    end
    u_pi_o(i,:) = t_pi_o.*C(:,:,i)*inv((pi_o.*eye(n))-A(:,:,i));
    C_o(:,:,i) = [C(:,:,i); u_pi_o(i,:)];
end

clear i

% Modèles augmentés de l'observateur et de l'intégrateur

n_int = n+1;

for i=1:length(T_r)
    A_int(:,:,i) = [A(:,:,i) zeros(n,1); C(:,:,i) zeros(1)];
    B_int(:,:,i) = [B(:,:,i) ; zeros(1)];
    B_r_int(:,:,i) = [zeros(n,1); -1];
    C_int(:,:,i) = [C_o(:,:,i) zeros(n,1); zeros(1,n) 1];
    D_int(:,:,i) = 0;
end

clear i 

%% Analyse en boucle ouverte

[P,Rc,Ro] = analyse_bo(T_r,G_g,A);
pause;
%% Modèle désiré

p_1 = -8;
p_2 = -42;
p_3 = -212;

r = 1;

[P_d,G_d,A_d,B_d,C_d,D_d,V_id,Lambda] = modele_d(p_1,p_2,p_3,r);

%% Traitement du modèle nominal (modèle 1)

r = 1; % nombre de  modèles traités
T_r_all(r,1) = T_r(1);
C_all(:,:,r) = C_int(:,:,1);

% Calcul de v et w

[v_n,w_n] = calc_v_w(n_int,m,A_int(:,:,1),B_int(:,:,1),Lambda,V_id);
v_all(:,:,1) = v_n;
w_all(1,:) = w_n;

% Calcul du gain

[K_c] = calc_K_c(r,n,n_int,T_r_all,C_all,v_all,w_all);

% Représentation d'etat du système en boucle fermée

[A_bf,B_bf,C_bf,D_bf] = sys_bf(T_r,r,K_c,A,B,C,D,u_pi_o,C_int);

% Analyse en boucle fermée

[P_bf,Rc_bf,Ro_bf] = analyse_bf(T_r,A_bf,B_bf,C_bf,D_bf,P_d,G_d,r);
pause;

%% Traitement des modèles pire-cas

for r = 2:length(T_r)
    
    % Trouver le pire-cas
    
    if or(any(real(P_bf)>0),any(real(P_bf)>max(P_d)))
        [p_pire_k, pire_k] = max(max(real(P_bf)));
    elseif any(any(imag(P_bf)~=0)>0)
        [p_pire_k, pire_k] = max(max(imag(P_bf)));
    else 
        break;
    end
    
    T_r_all(r,1) = T_r(pire_k);
    C_all(:,:,r) = C_int(:,:,pire_k);
    
    % Modèle desiré décalé (pour eviter les problèmes numériques)

    [P_d,G_d,A_d,B_d,C_d,D_d,V_id,Lambda] = modele_d(p_1,p_2,p_3,r);

    % Calcul de v et w

    [v_pire_k,w_pire_k] = calc_v_w(n_int,m,A_int(:,:,pire_k),B_int(:,:,pire_k),Lambda,V_id);
    v_all(:,:,r) = v_pire_k;
    w_all(1,((n_int*r)-n):(n_int*r)) = w_pire_k;
    
    % Calcul du gain

    [K_c] = calc_K_c(r,n,n_int,T_r_all,C_all,v_all,w_all);

    % Représentation d'etat du système en boucle fermée

    [A_bf,B_bf,C_bf,D_bf] = sys_bf(T_r,r,K_c,A,B,C,D,u_pi_o,C_int);

    % Analyse en boucle fermée

    [P_bf,Rc_bf,Ro_bf] = analyse_bf(T_r,A_bf,B_bf,C_bf,D_bf,P_d,G_d,r);

end
