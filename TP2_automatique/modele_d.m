function [P_d,G_d,A_d,B_d,C_d,D_d,V_id,Lambda] = modele_d(p_1,p_2,p_3,r)

P_d = [p_1;p_2;p_3]-((r-1)*0.001)*ones(3,1);

s = tf('s');

G_d = -P_d(1)*P_d(2)*P_d(3)/((s-P_d(1))*(s-P_d(2))*(s-P_d(3)));
[A_d,B_d,C_d,D_d] = ssdata(G_d);
[V_id, Lambdax] = eig(A_d);
Lambda = diag(Lambdax);

clear Lambdax