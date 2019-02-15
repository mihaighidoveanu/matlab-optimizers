function [ x,fval,exitflag,output ] = callFminunc( x0)
%CALLFMINUNC Summary of this function goes here
%   Detailed explanation goes here
    optiuni=optimset('LargeScale','off');
    [x,fval,exitflag,output] = fminunc(@objfun,x0,optiuni);

end

