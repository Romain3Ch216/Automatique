x = [-20:0.1:20];
y1 = -x.^2;
y2 = x.^2;
for i=1:length(x)
    for j=1:length(x)
        Y(i,j) = y1(i)*y2(i);
    end
end
surf(Y);