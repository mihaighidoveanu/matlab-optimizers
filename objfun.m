% % 1.4
% function f = objfun(x)
%     f = exp(x(1))*(4*x(1)^2+2*x(2)^2+4*x(1)*x(2)+2*x(2)+1);
% end
% % 1.5
% function f = objfun(x)
%     f = cos(3*pi*x) + sin(2*pi*x);
% end
% % 1.6
% function [f]=objfun(x)
%     f=x(1)^2+4.25*x(2)^2+x(3)^2+0.5*x(1)*x(2)+2*x(2)*x(3);
% end
% % 1.7
function [f]=objfun(delta)
    f=delta;
end