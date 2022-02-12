%% Task 1

load('CAR_TSA.mat')
t = 0:0.01:50;
t_double = double(t >= 0);

acc = 100;%;
temp = 24;

u = [acc; temp] * t_double;

sys = ss(A, B, C, D);
response = lsim(sys, u, t);


figure('Name', 'Raspunsul')
hold on;

subplot(3,1,1);
plot(t, response(:,1),'-r');
xlabel('Timp(s)');
ylabel('Pozitia(km)');

subplot(3,1,2);
plot(t, response(:,2),'-g');
xlabel('Timp(s)');
ylabel('Viteza(km/h)');

subplot(3,1,3);
plot(t, response(:,3),'-b');
xlabel('Timp(s)');
ylabel('Temperatura in habitaclu(*C)');

hold off;

% Dupa 25 de secunde, dupa cum se poate vedea in variabila response, prin
% s-au parcus aproximativ 0.6386 km. Totodata, se atinge temperatura de
% referinta de 24 de grade dupa aproximativ 25 de secunde.

%% Task 2

dimA = size(A);

% Controlabilitate
R = ctrb(A, B);
r = rank(R);

isCtrb = false;
if r ==  dimA
    isCtrb = true;
end

% Observabilitate
Q = obsv(A, C);
q = rank(Q);

isObsv = false;
if q == dimA
    isObsv = true;
end

% Sistemul este controlabil daca rank-ul matricei de controlabilitate este
% egal cu numarul de stari (dimensiunea lui A). A este o matrice patratica
% de dimensiune 3. Se poate observa ca variabila r care este egala cu
% rangul matricii de controlabilitate este egal cu 3, deci sistemul acestei
% controlabil, totodata variabila isCtrb devenind true. Analog pentru
% observabilitate, daca rangul matricii de observabilitate este egal cu
% dimensiunea lui A, adica cu 3, atunci sistemul este observabil. Se poate
% observa ca rangul matricii de observabilitate este egal cu dimnesiunea lui A,
% adica egal cu 3, si totodata variabila isObsv este setata cu true. Asadar,
% sistemul este si controlabil si observabil.

%% Task 3

B_f = [0 0; 0 0 ; 0 0.33];
sys_f = ss(A, B_f, C, D);
response_f = lsim(sys_f, u, t);

figure('Name', 'Raspunsul sistemului eronat(B_f)')
hold on;

subplot(3,1,1);
plot(t, response_f(:,1),'-r');
xlabel('Timp(s)');
ylabel('Pozitia(km)');

subplot(3,1,2);
plot(t, response_f(:,2),'-g');
xlabel('Timp(s)');
ylabel('Viteza(km/h)');

subplot(3,1,3);
plot(t, response_f(:,3),'-b');
xlabel('Timp(s)');
ylabel('Temperatura in habitaclu(*C)');

hold off;

dimA = size(A);

% Controlabilitate
R_f = ctrb(A, B_f);
r_f = rank(R_f);

isCtrb_f = false;
if r_f ==  dimA
    isCtrb_f = true;
end

% Observabilitate
Q_f = obsv(A, C);
q_f = rank(Q_f);

isObsv_f = false;
if q_f == dimA
    isObsv_f = true;
end
% Modificarea matricei B a dus la defectarea sistemului de accelaratie, Viteza
% ramanand constant egala cu 0, deci si distanta. Totodata, sistemul a devenit
% in mod evident, si necontrolabil. Observabilitate sistemului s-a pastrat,
% lucru care era de asteptat, aceasta nedepinzand de matricea B.

%% Task 4

C_f = [1 0 0; 0 1 0 ; 0 0 0];
sys_f_2 = ss(A, B, C_f, D);
response_f_2 = lsim(sys_f_2, u, t);

figure('Name', 'Raspunsul sistemului eronat(C_f)')
hold on;

subplot(3,1,1);
plot(t, response_f_2(:,1),'-r');
xlabel('Timp(s)');
ylabel('Pozitia(km)');

subplot(3,1,2);
plot(t, response_f_2(:,2),'-g');
xlabel('Timp(s)');
ylabel('Viteza(km/h)');

subplot(3,1,3);
plot(t, response_f_2(:,3),'-b');
xlabel('Timp(s)');
ylabel('Temperatura in habitaclu(*C)');

hold off;

% Controlabilitate
R_f_2 = ctrb(A, B);
r_f_2 = rank(R_f_2);

isCtrb_f_2 = false;
if r_f_2 ==  dimA
    isCtrb_f_2 = true;
end

% Observabilitate
Q_f_2 = obsv(A, C_f);
q_f_2 = rank(Q_f_2);

isObsv_f_2 = false;
if q_f_2 == dimA
    isObsv_f_2 = true;
end

% Sistemul obtinut cu matricea C_f, dupa cum se poate observa din isCtrb_f_2 si
% isObsv_f_2 este controlabil, dar nu observabil. Din grafice, se poate observabil
% cum temperatura nu se schimba, deci avem 2 variante: senzorul este defect sau
% sistemul de incalzire este defect. Din moment ce sistemul este controlabil,
% inseamna ca defectiunea este la senzorul de temperatura.
