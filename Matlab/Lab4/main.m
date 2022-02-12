
%% Task  2
% Frecventa de cut_off f_c este numeric egala cu  = 1 / ( 2 * pi * R * C )
% Deci R*C = 1 / ( 2 * pi * f_c)
% Dorim o frecventa f_c = 100Hz => R*C = 1 / ( 200 * pi );

s = tf('s');
R = 1;
C = 1 / (200 * pi);

H = (s * R * C) / (1 + s * R *C );
[bass_test, fs_bass] = play_file("bass_test.wav", false);

% Grafice

title = ["Task 2: Bode si spectrul sunetului inainte si dupa aplicarea" ...
    " lui H"];

figure;
sgtitle(title);

subplot(1,2,1);
plot_fft(bass_test,fs_bass);

subplot(1,2,2);
bass_test_output = apply_filter(H, bass_test, fs_bass);
plot_fft(bass_test_output, fs_bass);

% Diferentele audio
% play_signal(x);
% play_signal(y);


%% Task 3

H = s^2 / (s^2 + 62.83 * s + 394800);

bass_test_output = apply_filter(H, bass_test, fs_bass);

% Grafice

title = ["Task 3: Bode si spectrul sunetului inainte si dupa aplicarea" ...
    " lui H"];

figure;
sgtitle(title);

subplot(1,3,1);
bode(H);

subplot(1,3,2);
plot_fft(bass_test,fs_bass);

subplot(1,3,3);
plot_fft(bass_test_output, fs_bass);

%% Task 3 - part 2
    % Rezolvarea problemei functiei de transfer


% WN este aproximativ egal cu 628.33 iar zeta devine aproximativ egal cu
% 0.05

wn = sqrt(394800);
zeta = 62.83 / ( wn * 2 );

% Zeta are o valoare mult prea mica, de aici si rezultatul eronat. Pentru
% a obtine o filtrare buna, ar trebui ca zeta sa se aproprie de 1.

% Luam zeta = 0.87

zeta_new = 0.87;

H_new = s^2 / (s^2 + 62.83 * s + 394800);
bass_test_output_new = apply_filter(H_new, bass_test, fs_bass);

% Grafice

title = ["Task 3: Bode si spectrul sunetului dupa aplicarea noului" ...
    " filtru"];

figure
sgtitle(title);

subplot(1,2,1);
bode(H_new);

subplot(1,2,2);
plot_fft(bass_test_output_new, fs_bass);

%% Task 4

% Putem construi un filtru band-pass prin combinarea unui low-pass filter
% si unui high-pass filter
% Frecventa pentru ambele filtre este egala cu :
%   f_c = 1 / ( 2 * pi * R * C )

% Pentru filtrul low-pass dorim o frecventa f_c = 5kHz =>
% R*C = 1 / ( 2 * pi * 5 * 10^3)

R_low = 1;
C_low = 1 / (2 * pi * 5 * 10e3);
H_low = 1 / (s * R_low * C_low + 1);

% Pentru filtrul high-pass dorim o frecventa f_c = 1kHz =>
% R*C = 1 / ( 2 * pi * 1 * 10^3)

R_high = 1;
C_high = 1 / (2 * pi * 1 * 10e3);
H_high = (s * R_high * C_high) / (s * R_high * C_high + 1);

% Creeam filtrul band-pass
    k = 10^(5/20);

H_band = k* H_low * H_high;


[song, fs_song] = play_file("supernova.wav", false);

song_filtered = apply_filter(H_band, song, fs_song);


% Grafice

title = ["Task 4: Bode si spectrul melodiei inainte si dupa aplicarea" ...
    "filtrului"];

figure
sgtitle(title);

subplot(1,3,1);
bode(H_band);

subplot(1,3,2);
plot_fft(song, fs_song);

subplot(1,3,3);
plot_fft(song_filtered, fs_song);

%% Task 5 - part 1 :  determinarea frecventei beep-ului

[beep, fs_beep] = play_file("beep.wav", false);


% Grafice

title = "Task 5: Semnalul de tip beep";

figure
sgtitle(title);

plot_fft(beep, fs_beep);

% Observan din grafic ca frecventa zgomotului este de 16000 Hz

%% Task 5 - part 2 - sunetul corupt si repararea acestuia

[song_merged, fs_merged] = merge_sound_files("supernova.wav",...
    "beep.wav", 45/50);

w0 = 16000 * 2 * pi;
wc = (16100 - 15900)* 2 * pi;
H_antibeep = (s^2 + w0^2)/(s^2 + wc*s + w0^2);

[song_merged_filtered] = apply_filter(H_antibeep, song_merged, fs_merged);

% Grafice

figure

title = ["Task 5: Bode si spectrul melodiei inainte si dupa aplicarea" ...
    "filtrului"];

sgtitle(title);

subplot(1,3,1)
bode(H);

subplot(1,3,2);
plot_fft(song_merged, fs_merged);

subplot(1,3,3);
plot_fft(song_merged_filtered, fs_merged);
