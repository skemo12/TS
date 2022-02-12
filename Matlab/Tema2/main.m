%% Variabilele de baza

% H(s) = 100 / (2s + 1)

num = [100];
den = [2 1];

H = tf(num, den);
t = 0:0.01:50;

%% Task 1 - stabilitatea sistemului

poli = roots(den);
pzmap(H);

% Se poate observa ca functia are un singur pol in -1/2, iar acest lucru
% nu influenteaza stabilitatea sistemului deoarece acesta se afla in 
% semiplanul stang.

%% Task 2 

% Fie H_2 = 100 / (2s - 1);
% Acum functia are un pol in 1/2 iar sistemul nu mai este stabil.

num_2 = [100];
den_2 = [2 -1];

H_2 = tf(num_2, den_2);

poli_2 = roots(den_2);
pzmap(H_2);


%% Task 3

% Analiza la semnal de tip treapta pentru H
y_step = step(H); % salvarea datelor
step(H); % generarea graficului
title("Raspunsul unui propulsor la un semnal de tip treapta");

% se poate observa ca sistemul este stabil

%% Analiza la semnal de tip treapta pentru H'

% Acum functia are un pol in 1/2, deci sistemul nu mai este stabil.
y_step2 = step(H_2); % salvarea datelor
step(H_2); % generarea automata a graficului
title("Raspunsul unui propulsor de tip H' la un semnal de tip treapta");

% se poate observa ca sistemul nu mai este stabil

%% Task 4

% In mod ofensiv, propulsorul raspunde la semnal de intrare de tip impuls.
y = impulse(H); % salvarea datelor
impulse(H); % generarea automata a graficului.
title("Raspunsul unui propulsor la un semnal de tip impuls");

% Observatie: Se poate remarca ca semnalul obtinut are acelasi stil ca si 
% sunetul de propulsorului lui Iron Man din filmele Marvel.

%% Task 5

% Crearea semnalului de intrare
t_2 = 0:0.01:10;

u_1 = (t_2 - 0 >= 0) * 1;
u_2 = (t_2 - 1 >= 0) * 1;
u_3 = (t_2 - 2 >= 0) * 1;
u_4 = (t_2 - 3 >= 0) * 1;
u_5 = (t_2 - 4 >= 0) * 1;
u_6 = (t_2 - 5 >= 0) * 1;
sig = u_1 - u_2 + u_3 - u_4 + u_5 - u_6;

% Reprezentarea grafica semnalului de intrare
plot (t_2, sig); 
xlabel("Timp (s)");
ylabel("Input la nivelul semnalului de propulsie");
title("Semnal corespunzator la subpunctul 5");

%% Raspunsul la semnalul de acest tip.

y = lsim(H, sig, t_2); % salvarea datelor
lsim(H, sig, t_2) % Generarea automata a graficului
title("Raspunsul la semnalul corespunzator subpunctului 5");
