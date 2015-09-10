% The MIT License (MIT)
% 
% Copyright (c) 2015 John Bryan
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

function output = anodeCurrent(Vak, Vgk)
% anode to cathode current


mu = 100;
Kg = 1060;
Kp = 600;
Kvb = 300;
Vct = .5;

Ip =Vak/Kp*log( 1 + exp(Kp*(1/mu+(Vgk+Vct)/sqrt(Kvb+Vak*Vak)) ));

Ip = 2*Ip.^1.4/Kg;

% Ik = G*( log(1 + exp(C*( Vak/mu + Vgk ))/C ) ).^gamma;

output = Ip;
end

