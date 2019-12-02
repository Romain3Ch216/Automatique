function P = pseudo_spectre(r,theta,f,ARRAY,proj_esp_bruit)
    P = 1/(steering_vector(r,theta,f,ARRAY)'*proj_esp_bruit*steering_vector(r,theta,f,ARRAY));
end