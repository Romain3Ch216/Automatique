function [P_bf,Rc_bf,Ro_bf] = analyse_bf(T_r,A_bf,B_bf,C_bf,D_bf,P_d,G_d,r)

for i = 1:length(T_r)
    
    P_bf(:,i) = eig(A_bf(:,:,i));
    
    Qc_bf_i = ctrb(A_bf(:,:,i),B_bf(:,:,i));
    Rc_bf(:,i) = rank(Qc_bf_i);
    
    Qo_bf_i = obsv(A_bf(:,:,i),C_bf(:,:,i));
    Ro_bf(:,i) = rank(Qo_bf_i);
     
    if Rc_bf(:,i) ~= length(A_bf(:,:,i))
        disp('Le modèle n est pas commandable!');
    end
    
    if Ro_bf(:,i) ~= length(A_bf(:,:,i))
        disp('Le modèle n est pas observable!');
    end
    
    G_bf_i = ss(A_bf(:,:,i),B_bf(:,:,i),C_bf(:,:,i),D_bf(:,:,i));
   
    figure(3*r+1);
    plot(real(P_bf(:,i)),imag(P_bf(:,i)),'*');
    hold on;
    plot(real(P_d),imag(P_d),'O');
    hold on;
    figure(3*r+2);
    h=stepplot(G_bf_i);
    setoptions(h,'OutputVisible',{'on','off','off'},'Normalize','on');
    hold on;
    h_d=stepplot(G_d,'--');
    setoptions(h_d,'OutputVisible',{'on','off','off'},'Normalize','on');
    hold on;
    
    clear G_bf_i Qc_bf_i Qo_bf_i
end

clear i