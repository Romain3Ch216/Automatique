function X = kalman1D(Z)
    %mesures 
    A = [1 1;0 1];
    H = [1 0];
    R = 1; %covariance de la mesure
    Q = 1*eye(2); %covariance du modele
    U = -[0.5;1];
    B = 1;
    Pbarre = [10 0;0 1];
    z = [95;1]; %etat initial
    X = zeros(2,length(z));
    for k=1:length(Z)
        P = A*Pbarre*A'+Q;
        K = P*H'*inv(H*P*H'+R);
        Pbarre = P - K*(H*P*H'+R)*K';
        E = Z(k)-H*(A*z+B*U);
        X(:,k) = A*z+B*U+K*E;
        z = X(:,k);
    end
end