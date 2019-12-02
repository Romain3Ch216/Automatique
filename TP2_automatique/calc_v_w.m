function [v,w] = calc_v_w(n_int,m,A_int,B_int,Lambda,V_id)

v = [];
w = [];
for i = 1:n_int
    T_Lambda_i = [A_int-Lambda(i)*eye(n_int) -B_int];
    [U,S,V] = svd(T_Lambda_i);
    R_Lambda_i = V(:,(n_int+1):(n_int+m));
    N_Lambda_i = R_Lambda_i(1:n_int,:);
    M_Lambda_i = R_Lambda_i((n_int+1):(n_int+m),:);
    z_i = inv(N_Lambda_i'*N_Lambda_i).*N_Lambda_i'*V_id(:,i);
    v_i = N_Lambda_i.*z_i';
    w_i = M_Lambda_i.*z_i';
    v = [v v_i];
    w = [w w_i];
    
    clear T_Lambda_i U S V R_Lambda_i N_Lambda_i M_Lambda_i z_i v_i w_i
end

clear i