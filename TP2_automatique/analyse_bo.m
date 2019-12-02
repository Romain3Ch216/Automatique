function [P,Rc,Ro] = analyse_bo(T_r,G,A)

for i = 1:length(T_r)
    
    G_i = ss(G(i));
    
    P(:,i) = pole(G_i);
    
    Qc_i = ctrb(G_i);
    Rc(:,i) = rank(Qc_i);
    if Rc(:,i) ~= length(A(:,:,i))
        disp('Le modèle n est pas commandable!');
    end
    
    Qo_i = obsv(G_i);
    Ro(:,i) = rank(Qo_i);
    if Ro(:,i) ~= length(A(:,:,i))
        disp('Le modèle n est pas observable!');
    end
    
    figure(1);
    plot(real(P(:,i)),imag(P(:,i)),'*');
    hold on;
    figure(2);
    step(G_i/dcgain(G_i));
    hold on;
    figure(3);
    bode(G_i);
    hold on;
    
    clear G_i Qc_i Qo_i
end

clear i 