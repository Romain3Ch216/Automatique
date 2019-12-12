function [ITD,x,y] = ITD_woodworth(a,c,ITD_bis)
    theta1 = (-pi/2:0.01:pi/2);
    ITD1 = a/c*(theta1+sin(theta1));

    theta2 = (pi/2:0.01:pi);
    ITD2 = a/c*(pi-theta2+sin(theta2));

    theta3 = (-pi:0.01:-pi/2);
    ITD3 = a/c*(-pi-theta3+sin(theta3));

    ITD = [ITD3 ITD1 ITD2];
    theta = [theta3 theta1 theta2];
    
    figure();
    plot(rad2deg(theta),ITD);hold on;
    plot(rad2deg(theta),ITD_bis*ones(length(ITD)));
    [x,y] = ginput(1);
end