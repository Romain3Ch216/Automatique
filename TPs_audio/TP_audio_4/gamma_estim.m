function [Gamma,base_esp_bruit,base_esp_sig,diag_gamma] = gamma_estim(Y,L)
    for k=1:size(Y,3)
        Gamma(:,:,k) = (1/L)*(Y(:,:,k)*Y(:,:,k)');
        N = size(Gamma,1);
        [vp_gamma diag_gamma(:,:,k)] = eig(Gamma(:,:,k));
        max_vp = max(diag_gamma,[],'all');
        S = 0;
        for i=1:N
            if diag_gamma(i,i)/max_vp < 1e-3
                S = S;
            else
                S = S+1;
            end
        end
        base_esp_bruit(:,:,k) = vp_gamma(:,1:N-S);
        base_esp_sig(:,:,k) = vp_gamma(:,N-S+1:N);
    end
end