function [] = cochleogram(v_sig,F_low,F_high,Nb_chan,Fe_v)

    fs_chos = 20 ;
    t_vec = (0:length(v_sig)-1)/Fe_v ;

    % Chargement des fonctions
    cd Gammatones
    addpath(pwd)
    cd ..
    
    % Calcul du cochléogramme
    cfs=MakeErbCFs(F_low,F_high,Nb_chan);
    [BMS,ENVS,INSTFS]=gammatonebank(v_sig,F_low,F_high,Nb_chan,Fe_v) ;
    BMS = 0.9*BMS/max(BMS(:));

    % Tracé
    a = figure() ;
    set(a,'windowstyle','docked')
    for n=1:size(BMS,1)
        plot(t_vec,BMS(n,:)+n)
        hold on
    end
    set(gca,'ytick',(1:length(cfs)))
    set(gca,'yticklabel',round(cfs))
    xlabel('Temps (sec)','fontsize',fs_chos)
    ylabel('Fréquence centrale (Hz)','fontsize',fs_chos)
    set(gca,'fontsize',0.9*fs_chos)
    xlim([0 max(t_vec)])
    ylim([0 Nb_chan+1])