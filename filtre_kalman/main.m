clear all;
close all;
clc;

data = load('echantillon_trajectoire.mat');
T = data.z;
x = T(:,1);
y = T(:,2);
t = [0:1:length(x)-1];

X = kalman1D(x);
Y = kalman1D(y);

figure()
plot3(t,x,y);
hold on;
plot3(t,X(1,:),Y(1,:));

%%
[X,Z] = kalman1D();
plot(X(1,:));
legend('estime');
hold on;
plot(Z);
legend('mesure');
legend()