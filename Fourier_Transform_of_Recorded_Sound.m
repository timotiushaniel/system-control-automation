Rekaman = audioread('Recording.m4a');%Instructions untuk membaca file audio dengan nama file 'Recording.m4a' dan disimpan dalam variable Rekaman
[y_raw,myAudio] = audioread('Recording.m4a');%Instructions untuk membuat array berbentuk 2 dimensi dari 'Recoding.m4a' yang bernama y_raw dan myAudio
sound(y_raw,myAudio);%Mem-play file audio

subplot (2, 1, 1);%Membuat detail dalam membuat plot yang dimana 2(untuk memperkecil lebar dari grafik), 1(ukuran normal), 1(Pada bagian pertama)
plot (Rekaman);%Membuat Grafik dari Variable Rekaman
xlabel('Time')%Memberikan label untuk garis X
ylabel('Amplitude')%Memberikan label untuk garis Y
title('Time domain representation of y(t)')% Memberi judul pada plot

L = length(Rekaman);%panjang dari Rekaman
NFFT = 2^nextpow2(L); % Next power of 2 from length of Rekaman
Y = fft(Rekaman,NFFT)/L;%fast fourier transform dari myAudio terhadap NFFT
f = myAudio/2*linspace(0,1,NFFT/2+1);%myAudio dibagi dua lalu dikali dengan linspace untuk membuat vektor baris berisi NFFT/2+1 titik

subplot (2, 1, 2); %untuk memberikan detail dalam membuat plot-> (2{untuk memperkecil lebar dari graph},1{ukuran normal},2{dibagian kedua})
plot(f,2*abs(Y(1:NFFT/2+1)))%%Membuat Grafik New Fas Fourier Transform nya
drawnow;%Instructions untuk memulai gambar 
axis([0 myAudio/2 0 0.01])%Mengatur panjang dari garis X dan Y
title('Single-Sided Amplitude Spectrum of y(t)')% Memberi judul pada plot

xlabel('Frequency (Hz)')%Memberikan label untuk garis X
ylabel('|Y(f)|')%Memberikan label untuk garis Y