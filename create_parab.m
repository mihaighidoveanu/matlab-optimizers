
function create_parab
    [x,y] = meshgrid([-10:.2:10]);
    z=x.^2+0.25*(y.^2)-x.*y-0.5*x+y;
    surf(x,y,z,gradient(z))
end