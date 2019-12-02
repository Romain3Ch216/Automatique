function proj = projecteur_esp_bruit(base_esp_bruit)
    N = size(base_esp_bruit,1);
    M = size(base_esp_bruit,2);
    K = size(base_esp_bruit,3);
    proj = zeros(N,N,K);
    for k=1:K
        for i=1:M
            proj(:,:,k) = proj(:,:,k) + base_esp_bruit(:,i,k)*base_esp_bruit(:,i,k)';
        end
    end
end