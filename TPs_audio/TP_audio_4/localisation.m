function P = localisation(r_lim,r_res,theta_lim,theta_res,f,ANTENNE,proj_esp_bruit)
    r = (r_lim(1):r_res:r_lim(2));
    theta = (theta_lim(1):theta_res:theta_lim(2));
    K = size(proj_esp_bruit,3);
    PP = zeros(length(r),length(theta));
    if K>1
        figure('Name',"Localisation des sources par fréquences d'intérêt");
    end
    for k=1:K
        P = zeros(length(r),length(theta));
        for i=1:length(r)
            for j=1:length(theta)
                P(i,j) = pseudo_spectre(r(i),theta(j),f(k),ANTENNE,proj_esp_bruit(:,:,k));
                PP(i,j) = pseudo_spectre(r(i),theta(j),f(k),ANTENNE,proj_esp_bruit(:,:,k));
            end
        end
        if K > 1
            subplot(K,1,k);
            surf(theta,r,abs(P));
            titre = strcat('Fréquence : ',num2str(round(f(k))),'Hz'); 
            title(titre);
            xlabel('angle')
            ylabel('distance')
        end
    end
    figure('Name','Localisation des sources');
    surf(theta,r,abs(PP));
    xlabel('angle')
    ylabel('distance')
end