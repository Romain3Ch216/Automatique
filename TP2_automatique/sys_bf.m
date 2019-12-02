function [A_bf,B_bf,C_bf,D_bf] = sys_bf(T_r,r,K_c,A,B,C,D,u_pi_o,C_int)

for i = 1:length(T_r)
    [K_y,K_z,K_i] = calc_K_y_z_i(r,K_c,T_r(i));
    A_bf(:,:,i) = [A(:,:,i)-B(:,:,i)*K_y*C(:,:,i)-B(:,:,i)*K_z*u_pi_o(i,:) -B(:,:,i)*K_i; C(:,:,i) zeros(1)];
    B_bf(:,:,i) = [0; 0; -1];
    C_bf(:,:,i) = C_int(:,:,i);
    D_bf(:,:,i) = 0;
end
clear i