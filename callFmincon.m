function [ x,fval ] = callFmincon( x0 )
    optiuni=optimset('fmincon');
    optiuni.LargeScale='off';
    [x,fval]=fmincon(@objfun,x0,[],[],[],[],...
    [],[],@confun,optiuni);
end

