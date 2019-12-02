function [K_y,K_z,K_i] = calc_K_y_z_i(r,K_c,T_r)

for i = 1:r
    K_y_all(i) = K_c(1+3*(i-1));
    K_z_all(i) = K_c(2+3*(i-1));
    K_i_all(i) = K_c(3+3*(i-1));
end

clear i

K_y = 0;
K_z = 0;
K_i = 0;
for i = 1:r 
    K_y = K_y+K_y_all(i)*T_r^(i-1);
    K_z = K_z+K_z_all(i)*T_r^(i-1);
    K_i = K_i+K_i_all(i)*T_r^(i-1);
end

clear i 