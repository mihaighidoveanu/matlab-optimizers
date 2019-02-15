function laurentz_cone()
    [y1,y2]=meshgrid(-1:0.01:1,-1:0.01:1);
    y3=sqrt(y1.^2+y2.^2); dom=[y3>1];
    z3=y3; z3(dom)=inf;
    figure(1);
    hold on;
    surf(y1,y2,z3); set(gca,'FontSize',15);
    hold off;
end
