clear all;
close all;
clc;

%%
data = load('releve_vit_cste_axe2.mat');
%i1 et i2 courants (A)
%ifil1 et ifil2 les courants filtrés (A)
%q1 et q2 les positions (rad)
% qd1 et qd2 positions désirées (rad)
%qpfil1 et qpfil2 les vitesses filtrées (rad/s)
i1 = data.i1;
i2 = data.i2;
ifil1 = data.ifil1;
ifil2 = data.ifil2;
q1 = data.q1;
q2 = data.q2;
qd1 = data.qd1;
qd2 = data.qd2;
qp1 = data.qp1;
qp2 = data.qp2;
qpfil1 = data.qpfil1;
qpfil2 = data.qpfil2;
t = data.t;

figure();
plot(t,q1);
plot(t,qp2);
figure();
plot(q2,ifil2);
figure();
plot3(q2,qp2,ifil2);
figure();
plot(t,q2);hold on;
plot(t,ifil2); 

%%
data = load('releve_vit_cste_axe1.mat');
%i1 et i2 courants (A)
%ifil1 et ifil2 les courants filtrés (A)
%q1 et q2 les positions (rad)
% qd1 et qd2 positions désirées (rad)
%qpfil1 et qpfil2 les vitesses filtrées (rad/s)
i1 = data.i1;
i2 = data.i2;
ifil1 = data.ifil1;
ifil2 = data.ifil2;
q1 = data.q1;
q2 = data.q2;
qd1 = data.qd1;
qd2 = data.qd2;
qp1 = data.qp1;
qp2 = data.qp2;
qpfil1 = data.qpfil1;
qpfil2 = data.qpfil2;
t = data.t;

figure();
plot(t,qp1);
figure();
plot(q1,ifil1);
figure();
plot3(q1,qp1,ifil1);




