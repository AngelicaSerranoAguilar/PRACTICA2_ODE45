clc
clear 
close

% Condiciones iniciales 
y0 = [0; 35*pi/180; 0; 0];

% Tiempo de muestreo
tspan = [0 10];

%Se llama a la funcion pendulo
[t, y] = ode45(@(t, y) pendulo(t, y), tspan, y0);

% Imprimir graficas
figure;
plot(t, y(:, 1));
xlabel('Tiempo (s)');
title('Theta_1');

figure;
plot(t, y(:, 2));
xlabel('Tiempo (s)');
title('Theta_2');


function dydt = pendulo(t, y)

% Valores iniciales
m1 = 0.2;
m2 = 0.1; 
l1 = 0.3; 
l2 = 0.25; 
g = 9.81; 

% Diferencial de los con y sin
dif = y(2)-y(1);

% Definimos las ecuaciones, y(1)=theta 1, y(2)=theta 2
s1 = (m1 + m2) * l1 - m2 * l1 * cos(dif) * cos(dif);
s2 = (l2 / l1) * s1;

dydt = zeros(4,1);

dydt(1) = y(3); % Primera derivada de theta 1
dydt(2) = y(4); % Primera derivada de theta 2

% Segunda derivada de theta 1
dydt(3) = (m2 * l1 * y(3) * y(3) * sin(dif) * cos(dif) + m2 * g * sin(y(2)) * cos(dif) + m2 * l2 * y(4) * y(4) * sin(dif) - (m1 + m2) * g * sin(y(1))) / s1;

% Segunda derivada de theta 2
dydt(4) = (-m2 * l2 * y(4) * y(4) * sin(dif) * cos(dif) + (m1 + m2) * g * sin(y(1)) * cos(dif) - (m1 + m2) * l1 * y(3) * y(3) * sin(dif) - (m1 + m2) * g * sin(y(2))) / s2;

end
