function [ output ] = gridCurrent(Vak, Vgk)
% grid to cathode diode current
% input is 2x1 vector [Vak; Vgk]

% Vak = v(1);
% Vgk = v(2);

Gg = 2e-3;
Cg = 1;
epsilon = 1.3;
Igo = 8e-8;


Ig = Gg*( log(1 + exp(Cg*Vgk) )/Cg ).^epsilon + Igo;

output = Ig;
end
