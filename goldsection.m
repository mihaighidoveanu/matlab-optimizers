function [xst,fst]= goldsection(x,eps)
    a = x - pi; 
    b = x + pi;
    lambda = a + 0.382 * (b - a);
    miu = a + 0.618 * (b - a);
    while ((b - a) >= eps)
        if (objfun(lambda) <= objfun(miu))
            b = miu;
        else
            a = lambda;
        end
            lambda = a + 0.382 * (b - a); 
            miu = a + 0.618 * (b - a);
    end
    if (objfun(lambda) <= objfun(miu))
        fst = objfun(lambda); 
        xst = lambda;
    else
        fst=objfun(miu); xst=miu;
    end
end