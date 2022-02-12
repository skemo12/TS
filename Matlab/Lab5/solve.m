%% Task 1

load('RCAM_lon.mat');
sys = ss(A_lon, B_lon, C_lon, D_lon);
values = eig(A_lon);
poles = pole(sys);
H = tf(sys);

polesAndValuesEqual = false;
if values == poles
    polesAndValuesEqual = true;
end
isSysStable = isstable(sys);
% Se poate observa ca variabila polesAndValuesEqual este setata la valoare true,
% deci spectrul de stare al matricei A si polii matricei de transfer
% sunt egali.

% Deoarece transformare din model pe stare in functie de transfer se reduce
% la calculul valorilor proprii ale lui A si calculul polinomul
% caracteristic a lui A_0, aceasta transformare se poate face mereu.

% Sistemul este stabil, dovedit de faptul ca polii sistemului se afla in
% semiplanul stang ( afirmatie confirmate de valoare true a variabilei
% isSysStable).

%% Task 2
t = 0:0.01:50;
input = [2, 0, 20, 0];
u_0 = zeros(length(t), 2);
response = lsim(sys, u_0, t, input);

figure('Name', 'Raspunsul liber')
hold on;

subplot(3,1,1);
plot(t, response(:,1),'-r');
xlabel('Timp(s)');
ylabel('Rata de tangaj(grade)');

subplot(3,1,2);
plot(t, response(:,2),'-g');
xlabel('Timp(s)');
ylabel('Viteza pe OZ(m/s)');

subplot(3,1,3);
plot(t, response(:,3),'-b');
xlabel('Timp(s)');
ylabel('Viteza totala(m/s)');

hold off;

%% Task 3

t = 0:0.01:50;
t_double = double(t >= 0);
u = [2; 3] * t_double;
forced_response = lsim(sys, u, t);

figure('Name', 'Raspunsul fortat')
hold on;

subplot(3,1,1);
plot(t, forced_response(:,1),'-r');
xlabel('Timp(s)');
ylabel('Rata de tangaj(grade)');

subplot(3,1,2);
plot(t, forced_response(:,2),'-g');
xlabel('Timp(s)');
ylabel('Viteza pe OZ(m/s)');

subplot(3,1,3);
plot(t, forced_response(:,3),'-b');
xlabel('Timp(s)');
ylabel('Viteza totala(m/s)');

hold off;

%% Task 4
input = [2, 0, 20, 0];
t = 0:0.01:50;
total_response = lsim(sys, u, t, input);

figure('Name', 'Raspunsul total')
hold on;

subplot(3,1,1);
plot(t, total_response(:,1),'-r');
xlabel('Timp(s)');
ylabel('Rata de tangaj(grade)');

subplot(3,1,2);
plot(t, total_response(:,2),'-g');
xlabel('Timp(s)');
ylabel('Viteza pe OZ(m/s)');

subplot(3,1,3);
plot(t, total_response(:,3),'-b');
xlabel('Timp(s)');
ylabel('Viteza totala(m/s)');

hold off;

totalOk = false;
aux_response = total_response - response - forced_response;
if aux_response < 1e-10
    totalOk = true;
end

% Deoarece totalOk primeste valoarea de true, putem spune cu o eroare de
% 10^(-10) ca raspunsul total este suma raspunsului liber si a raspunsului
% fortat. Totodata, acest lucru se observa, in mod evident si pe grafice.
% Am facut sa demonstrez si matematic acest lucru.
