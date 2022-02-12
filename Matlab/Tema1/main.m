%% Functia de pondere h(t) si functia de trasnfer H(s)

% Am facut aceste calcule cu toate ca nu era necesar, ma asteptam sa fie
% nevoie de ele, dar aparent nu a fost.

%Aplicam LaPlace pe functia pondere h(t)
%Obtinem H(s) = 100 / (3s + 1)

h = @(t) 100/3 * ( exp(-t/3) );
t = 0 : 0.01: 50;

%num = [100];
%den = [3 1];

%H = tf(num, den);

% PENTRU SUBPLOT AM FACUT MODIFICARI IN ts_continous_conv! 
% ATENTIE! Am facut o mica modificare in functia ts_continous_conv pentru 
% a putea grupa graficele. Am comentat linia ce contine figure. ( Acest
% comentariu l-am scris si in functia respectiva dar l-am mentionat si aici
% pentru cazul in care corectorul foloseste functia de pe moodle!

%% Primul task

% Generarea semnalului de tip dreptunghiular

v1 = (t - 5 >= 0) * 1;
v2 = (t - 10 >= 0) * 1;

rect = v1 - v2;
plot(t, rect);
title("Semnal de intrare de tip dreptunghiular");


%% Al doilea task

% Generarea semnalului de tip triunghiular
syms x
fplot(triangularPulse(x), [-2 2])
title("Semnal de intrare de tip triunghiular");


%% Al treilea task

%%Part 1 - Calculul pentru u1(t)

% Definim functia
u1 = @(t) sin ( 100 * t );

% Generam setul de date de intrare pentru u1 si h
input1 = u1(t);
h1 = h(t);

% Apelul functiei + generare grafic
y1 = ts_continous_conv(input1, h1, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y1(t) la intrarea u1(t) = sin(100t)");


%% Part 2

% Definim functia
u2 = @(t) (t >= 0 ) * 1;

% Generam setul de date de intrare pentru u2 si h
input2 = u2(t);
h2 = h(t);

% Apelul functiei + generare grafic
y2 = ts_continous_conv(input2, h2, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y2(t) la intrarea u2(t) = 1(t)");

% Mobilul ajunge la viteza de 100 km/h in aproximativ ~19.1 secunde, iar 
% la viteza absolut maxima de 100.2 km/h in aproximativ ~26.13 secunde.
% Am vrut sa mentionez ambele durate de timp deoarece diferenta este foarte
% mica in ceea ce priveste viteza, dar durata creste semnificativ pentru o
% crestere aproape irelevanta.

%% Studiem mobilul pentru accelaratia de 50%

% Datele de intrare
h2_1 = h(t);
input2_1 = input2 / 2;

% Apelul functiei + generare grafic
y2_1 = ts_continous_conv(input2_1, h2_1, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y2_1(t) la intrarea u2_1(t) = 50% din acceleratie");

% Folosind doar 50% din acceleratie, vehiculul va avea o viteza maxima
% injumatatia, dar timpul in care va atinge acel 50% din viteza maxina
% ramane aproape neschimbata, adica ~19.1 secunde pentru viteza de 50 km/h 
% si ~26.13 secunde pentru viteza de 50.08.

%% Task 4

% Setul de date de intrare
u3 = u1(t) + u2(t);
h3 = h(t);

% Generarea graficelor -- folosim subplot sa grupam graficele sub forma de
% matrice de 2x3 - prima linie o reprezinta intrarile, a 2-a raspunsurile

% Semnal de intrare u1 = sin (100t)
subplot(2,3,1);
plot(t, input1);
title("Semnal de intrare de tip u1(t) = sin(100t)");

% Semnal de intrare u2(t) = 1 (t)
subplot(2,3,2);
plot(t, input2);
title("Semnal de intrare de tip u2(t) = 1 (t)");

% Semnal de intrare u3(t) = u1(t) + u2(t)
subplot(2,3,3);
plot(t, u3);
title("Semnal de intrare u3(t) = u1(t) + u2(t)");

% Raspunsul y1(t) la intrarea u1(t) = sin(100t)
subplot(2,3,4);
y1 = ts_continous_conv(input1, h1, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y1(t) la intrarea u1(t) = sin(100t)");

% Raspunsul y2(t) la intrarea u2(t) = 1(t)
subplot(2,3,5);
y2 = ts_continous_conv(input2, h2, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y2(t) la intrarea u2(t) = 1(t)");

% Raspunsul y3(t) la intrarea u3(t) = u1(t) + u2(t)
subplot(2,3,6);
y3 = ts_continous_conv(u3, h3, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y3(t) la intrarea u3(t) = u1(t) + u2(t)");


% Verificam caracterul liniar al sistemului (atat matematic cat si din grafic)

% Verificarea matematica

y3_ref = y1 + y2;

ok = 0;
if ( abs(y3 - y3_ref) < 1e-10)
    ok = 1;
end

% RASPUNS:

% Observam ca ok este egal cu 1. folosim 10^(-10) in loc de == 0 pentru ca
% lucram cu numere double ce nu vor niciodata cu precizie 0, ci o valoare
% foarte mica

% Din moment ce ok este egal cu 1, inseamna ca sistemul are caracter liniar
% Verificand conditia:
% u3(t) = a * u1(t) + b * u2(t) => y3(t) = a * y1(t) + b * y2(t); unde
% y1(t) este raspunsul la u1(t) iar y2(t) este raspunsul la u2(t).

% Acest lucru este putin greu de observat doar din grafic, dar se poate
% observa aceea deplasare in cazul lui u3 fata de u1, adaugata practic de
% u2 ( trebuie folosit zoom ), iar pe y3 fata de y2 se observa ( la zoom )
% ca y3 nu mai este o dreapta fina, ci are acel aspect asemanator unei
% sinusoide in urcare


%% Task 5

% Generam intrarile pentru u4(t)
u4 = @(t) (t - 3 >= 0 ) * 1;
h4 = h(t);
input4 = u4(t);

% Generarea graficelor -- grupam graficele sub forma de matrice de 2x2, unde
% prima coloana sunt intrarile, iar a 2-a coloana sunt raspunsurile


% Semnalul de intrare u4(t)
subplot(2,2,1);
plot(t, input4);
title("Semnal de intrare de tip u4(t) = 1 * ( t - 3)");

% Raspunsul y4(t) la intrarea u4(t) = 1 * (t - 3)
subplot(2,2,2);
y4 = ts_continous_conv(input4, h4, t);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y4(t) la intrarea u4(t) = 1 * (t - 3)");

% Semnalul de intrare u2(t) = 1 (t)
subplot(2,2,3);
plot(t, input2);
title("Semnal de intrare de tip u2(t) = 1 (t)");

% Raspunsul y2(t) la intrarea u2(t) = 1(t)
subplot(2,2,4);
plot(t, y2);
xlabel("Timp(s)");
ylabel("Viteza(km/h)");
title("Raspunsul y2(t) la intrarea u2(t) = 1(t)");

% RASPUNS:

% Din grafice se poate observa ca singura diferenta cauzata de semnalul
% de tip treapta intarziata u4 este o intarziere de aceeasi valoarea in
% raspunsul y4. Asadar modelul automobilului reactioneaza la fel indiferent
% de intarzierea semnalului, avand un caracter invariant în timp.
