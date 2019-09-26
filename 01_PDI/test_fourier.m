Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

% sum of a 50Hx sinusoid and 120 Hz sinusoid
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% plot(0.7*sin(2*pi*50*t)
X = S + 2*randn(size(t));
plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);

% Calcule el espectro bilateral P2. A continuación, calcule el espectro unilateral P1 basado en P2 y la longitud de la señal de valor uniforme L.

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Defina el dominio de la frecuencia f y represente gráficamente el espectro de amplitud unilateral P1. Las amplitudes no son exactamente de 0,7 y 1, como se esperaba, debido al ruido añadido. Como promedio, las señales más largas producen mejores aproximaciones de frecuencia.

f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Ahora, tome la transformada de Fourier de la señal original, la señal sin dañar y recupere las amplitudes exactas, 0,7 y 1,0.

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 2^nextpow2(L);
Y = fft(X,n);
f = Fs*(0:(n/2))/n;
P = abs(Y/n);

plot(f,P(1:n/2+1)) 
title('Gaussian Pulse in Frequency Domain')
xlabel('Frequency (f)')
ylabel('|P(f)|')
