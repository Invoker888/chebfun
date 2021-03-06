function pass = test_randnfun( pref )

if ( nargin == 0 ) 
    pref = chebfunpref();
end

rng(0)
f = randnfun(.01);
pass(1) = (abs(std(f)-1) < .1);
pass(2) = (abs(mean(f)) < .1);

rng(0)
g = randnfun(.01,1,[5,7]);
pass(3) = (abs((sum(f)-sum(g))) < 1e-3);

A = randnfun(1,10,[0 10]);
X = cov(A);
pass(4) = (norm(X-X') == 0);

rng(0), f1 = randnfun('norm',1/64,[0 3]);
rng(0), f2 = 8*randnfun(1/64, 1, [0 3]);
pass(5) = norm(f1-f2) == 0;


end
