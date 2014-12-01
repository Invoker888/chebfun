function [f,fa] = gallery(name)
%GALLERY   Chebfun example functions.
%   GALLERY(NAME) returns a chebfun corresponding to NAME. See the listing
%   below for available function names.
%
%   For example,  plot(cheb.gallery('zigzag'))  plots a degree 10000 polynomial
%   that doesn't look like a polynomial, and  plot(cheb.gallery('gamma'))  shows
%   a chebfun with poles. For details of how each function is constructed, try
%   type +cheb/gallery  or  edit cheb.gallery.
%
%   [F,FA] = GALLERY(NAME) also returns the anonymous function FA used to
%   define the function. Some gallery functions are generated by operations
%   beyond the usual Chebfun constructor (e.g. by solving ODEs), so FA in
%   those cases simply evaluates the chebfun.
%
%   GALLERY() with no input argument returns a random function from the gallery.
%
%   airy         Airy Ai function on [-40,40]
%   bessel       Bessel function J_0 on [-100,100]
%   bump         C-infinity function with compact support
%   blasius      Blasius function on [0,10]
%   chirp        Sine with exponentially increasing frequency
%   erf          Error function on [-10,10]
%   fishfillet   Wild oscillations from Extreme Extrema example
%   gamma        Gamma function on [-4,4]
%   gaussian     Gaussian function on [-Inf,Inf]
%   jitter       A piecewise constant function generated by ROUND
%   kahaner      Challenging integrand with four spikes
%   motto        Chebfun motto (Gilbert Strang)
%   rose         A complex-valued sinusoid
%   runge        Runge function
%   seismograph  Tanh plus growing oscillation
%   Si           Sine integral on [-50,50]
%   sinefun1     As smooth as it looks
%   sinefun2     Not as smooth as it looks
%   spikycomb    25 peaks, each sharper than the last
%   stegosaurus  max(wiggly, x/10)
%   wiggly       One of the Chebfun team's favorites
%   zigzag       Degree 10000 polynomial that looks piecewise linear
%
%   Gallery functions are subject to change in future releases of Chebfun.
%
% See also CHEB.GALLERYTRIG, CHEB.GALLERY2.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.


% If the user did not supply an input, return a random function
% from the gallery.
if ( nargin == 0 )
    names = {'airy', 'bessel', 'blasius', 'bump', 'chirp', 'erf', ...
        'fishfillet', 'gamma', 'gaussian', 'jitter', 'kahaner', 'motto', ...
        'rose', 'runge', 'seismograph', 'si', 'sinefun1', 'sinefun2', ...
        'spikycomb', 'stegosaurus', 'wiggly', 'zigzag'};
    name = names{randi(length(names))};
end

% The main switch statement.
switch lower(name)

    % Airy Ai function on [-40,40]
    case 'airy'
        fa = @airy;
        f = chebfun(fa, [-40 40]);

    % Bessel function with parameter 0 on [-100,100]
    case 'bessel'
        fa = @(x) besselj(0, x);
        f = chebfun(fa, [-100 100]);

    % Blasius function on [0,10]
    case 'blasius'
        op = @(u) 2*diff(u,3) + u.*diff(u,2);
        bc  = @(x,u) [u(0); feval(diff(u),0); feval(diff(u),10)-1];
        N = chebop(op, [0 10], bc);
        N.init = chebfun([3.55542; 4.25907; 0.43669; -0.21367;
                0.06382; -0.00118; -0.00865; 0.00306], [0 10], 'coeffs');
        f = N\0;
        fa = @(x) f(x);

    % Bump function
    case 'bump'
        fa = @(x) (abs(x) < 1).*exp(-1./(1-x.^2));
        f = chebfun(fa, [-2 2]);

    % Sine with exponentially increasing frequency
    case 'chirp'
        fa = @(x) sin(x.*exp(x));
        f = chebfun(fa, [0 5]);

    % Error function on [-10,10]
    case 'erf'
        fa = @erf;
        f = chebfun(fa, [-10 10]);

    % Wild oscillations from Extreme Extrema example
    case 'fishfillet'
        fa = @(x) cos(x).*sin(exp(x));
        f = chebfun(fa, [0 6]);

    % Gamma function on [-4,4]
    case 'gamma'
        fa = @gamma;
        f = chebfun(fa, [-4 4], 'blowup', 'on', 'splitting', 'on');

    % Gaussian function on [-Inf,Inf]
    case 'gaussian'
        fa = @(x) exp(-x.^2/2)/sqrt(2*pi);
        f = chebfun(fa, [-Inf Inf]);

    % A piecewise constant function generated by ROUND
    case 'jitter'
        fa = @(x) round(exp(x)*2.*sin(8*x));
        f = chebfun(fa, 'splitting', 'on');

    % Challenging integrand with four spikes
    case 'kahaner'
        fa = @(x) sech(10*(x-0.2)).^2 + sech(100*(x-0.4)).^4 + ...
         sech(1000*(x-0.6)).^6 + sech(1000*(x-0.8)).^8;
        f = chebfun(fa, [0 1]);

    % (Scribbled) Chebfun motto by Gilbert Strang
    case 'motto'
        f = exp(3i*scribble('there is no fun like chebfun'));
        fa = @(x) f(x);

    % Rose curve
    case 'rose'
        m = 5; n = 4;
        fa = @(t) cos(m/n*t).*cos(t) + 1i*cos(m/n*t).*sin(t);
        f = chebfun(fa, [0, 8*pi], 'trig');

    % Runge function
    case 'runge'
        fa = @(x) 1./(1 + x.^2);
        f = chebfun(fa, [-5 5]);

    % Tanh plus growing oscillation
    % from ATAP, Chapter 5
    case 'seismograph'
        fa = @(x) tanh(20*sin(12*x)) + .02*exp(3*x).*sin(300*x);
        f = chebfun(fa);

    % Sine integral
    case 'si'
        f = cumsum(chebfun(@(x) sin(x)./(x), [-50, 50]));
        fa = @(x) f(x);

    % As smooth as it looks
    case 'sinefun1'
        fa = @(x) (2 + sin(50*x));
        f = chebfun(fa);

    % Not as smooth as it looks
    case 'sinefun2'
        fa = @(x) (2 + sin(50*x)).^1.0001;
        f = chebfun(fa);

    % 25 peaks, each sharper than the last
    % from ATAP, Chapter 18
    case 'spikycomb'
        fa = @(x) exp(x).*sech(4*sin(40*x)).^exp(x);
        f = chebfun(fa);

    % max(wiggly, x/10)
    case 'stegosaurus'
        fa = @(x) max(sin(x)+sin(x.^2), x/10);
        f = chebfun(fa, [0 10], 'splitting', 'on');

    % One of the Chebfun team's favorites
    case 'wiggly'
        fa = @(x) sin(x) + sin(x.^2);
        f = chebfun(fa, [0 10]);

    % Degree 10000 polynomial that looks piecewise linear
    % from ATAP appendix
    case 'zigzag'
        f = cumsum(chebfun(@(t) sign(sin(100*t./(2-t))), 10000));
        fa = @(x) f(x);

    % Error if the input is unknown.
    otherwise
        error('CHEB:GALLERY:unknown:unknownFunction', ...
            'Unknown function.')

end

end
