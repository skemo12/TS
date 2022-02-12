%% Task 1_1 - Functii de transfer
    clear
    clc

    % H(s) = 1 / (0.7 * s^2 + 0.1 * s + 0.3);
    num = [1];
    den = [0.7, 0.1, 0.3];
    H = tf(num, den);
    % w_n = pulsatia naturala
    % z = coeficient de amortizare
    [w_n, z] = damp(H);
    damp(H)
    % Cele 2 perechi de valori pt pulsatie si coeficient de amortizare sunt
    % egale. Deci w_n = 0.6547, iar z = 0.1091.

    % Acest lucru se poate si calcula prin reducerea lui H la forma :
    % H(s) =  K * w_n^2 / (s^2 + 2* z * w_n * s + w_n^2)
    % Si asta ar duce la:
    % H(s) = (1/7)/(s^2 + 1/7 * s + 3/7), deci =>
    % w_n^2 = 0.4285 iar z = 0.1428 / (2 * w_n) =>
    % w_n = 0.6547, iar z = 0.1091.

%% Task 1_2 - Functii de transfer

    %% Stabilitate
    poles = pole(H);
    dimen = length(poles);
    stableCheck = 1;
    for i = 1:dimen
        if (real(poles(i)) > 0)
            stableCheck = 0;
        end
    end

    % Se poate observa la sfarsitul buclei ca stableCheck ramane 1, deci totusi
    % polii functiei H se afla in semi-planul stang, asadar sistemul este
    % stabil. Totodata, putem apela functia isstable(H)
    isStableResponse = isstable(H);
    % Se observa sa raspunsul este 1 logic, adica sistemul este stabil.

    %% Suprareglaj

    % Putem calcula supra-reglajul fie cu stepInfo, fie matematic
    info = stepinfo(H);
    overshootStepInfo = info.Overshoot / 100;
    overshoot = exp( - pi * z(1) / sqrt(1 - z(1)^2));
    % Suprareglajul calculat prin formula este mai util, deoarece ne arata exact
    % de cine depinde suprareglajul, mai exact de zeta.

%% Task 1_3 - Functii de transfer

    % Pentru a obtine amplificarea maxima, regimul trebuie sa fie oscilant
    % asta inseamna ca zeta trebuie sa fie egal cu 0, iar din moment ce
    % w = w_n * sqrt(1 - zeta^2), asta inseamna pulsatie w trebuie sa fie egala
    % cu pulsatatie naturala w_n.
    w = w_n(1);
    t = 0:0.01:20;
    u = sin(w*t);

    figure
    lsim(H,u,t);
    title('Raspunsul sistemului H la o intrare armonica sin(wt)');

%% Task 1_4 - Functii de transfer

    figure
    bode(H);
    title('Diagrama Bode pentru sistemul H');

    % Din diagrama Bode, reiese ca sistemul H este un filtru de tipul low_pass.


%% Task 2_1

    A = [-51, 15, 8; 12, 10, 2; -8, 12, -80];
    B = [0.2, 0; 0.4, 1; 0, 0];
    C = [1, 4, 0; 0, 15, 0];
    D = [0, 0; 0, 0];
    sys = ss(A, B, C, D);

    % Numarul de intrari, numarul de iesiri si numarul de stari se pot deduce
    % din dimensiunile matricelor. Aux este o variabila de care nu suntem
    % interesati
    [nrStari] = length(A);
    [nrIntrari] = size(B, 2);
    [nrIesiri] = size(C, 2);

%% Task 2_2

    % Pentru ca sistemul sa fie stabil, valoriile proprii trebuie sa fie
    % negative
    values = eig(sys);
    dim = length(values);
    stableSysCheck = 1;
    for i = 1:dim
        if (values(i) > 0)
            stableSysCheck = 0;
        end
    end

    isStableAns = isstable(sys);
    % Se observa atat din valoare 0 logic a variabilei isStableAns, cat si Din
    % valoare 0 a variabilei stableSysCheck, ca sistemul nu este stabil.

%% Task 2_3

    % Controlabilitate
    R = ctrb(sys);
    r = rank(R);

    isControllable = 0;

    if (r == nrStari)
        isControllable = 1;
    end

    % Se poate observa din variabila isControllable ca sistemul este controlabil

    % Observabilitate

    Q = obsv(A,C);
    q = rank(Q);

    isObservable = 0;

    if (q == nrStari)
        isObservable = 1;
    end

 %% Task 2_4

    % Am ales Q = 1, R = 1
    Q = 1;
    R = 1;
    
    % Construirea filtrului Kalman
    [kalmf, L, P] = kalman(sys, Q, R);
    kalmf
