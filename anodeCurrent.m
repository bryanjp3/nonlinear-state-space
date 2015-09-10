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

