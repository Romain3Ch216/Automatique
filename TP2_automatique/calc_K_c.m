function [K_c] = calc_K_c(r,n,n_int,T_r_all,C_all,v_all,w_all)

for i = 1:r % lignes
    for l = 1:r % colonnes
        X((i*n_int)-n:(i*n_int),(l*n_int)-n:(l*n_int)) = (T_r_all(l,1))^(i-1).*C_all(:,:,l)*v_all(:,:,l);
    end
end

clear i l

K_c = w_all*inv(X);