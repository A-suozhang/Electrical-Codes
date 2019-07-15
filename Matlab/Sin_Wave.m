fs = 625000;
N = 2048;
f0 = 15000;
Amp0 = 0.1;
f1 = 15010;
Amp1 = 0.5;

xs = 0:1/fs:(1/fs)*(N-1);

% -----------------The C Signal -----------------
ys0 = Amp0*sin(2*pi*f0*xs) + Amp1*sin(2*pi*f1*xs);  % ע����Ϊ��������ˣ�Ҫ��֤���Ľ��������ȷ, ������ҪAmp0 + Amp1 < 1,���Υ���Ļ��������
y0 =  round(ys0*(2^13))
y0_bak =  round(ys0*(2^13));
y0(find(y0<0))=y0(find(y0<0))+2^14;   %����ת����

% plot(y0);
 y0 = dec2hex(y0);
 
 %--------------- The B Signal -------------------
 ys1 = Amp1*sin(2*pi*f1*xs);
y1 =  round(ys1*(2^13))
y1_bak =  round(ys1*(2^13));
y1(find(y1<0))=y1(find(y1<0))+2^14;   %����ת����

% plot(y0);
 y1 = dec2hex(y1);


f0= fopen("sin_wave0.txt","w");
for i = 1:length(y0)
    fprintf(f0, "%s\n", y0(i,1:4));
end
fclose(f0);

f1= fopen("sin_wave1.txt","w");
for i = 1:length(y1)
    fprintf(f1, "%s\n", y1(i,1:4));
end
fclose(f1);

dy0_fft = abs(fft(y0_bak - y1_bak,N));
y0_fft = abs(fft(y0_bak, N));
y1_fft = abs(fft(y1_bak, N));
dy = y0_fft - y1_fft;
plot(dy);
hold on;
plot(dy0_fft);
hold on; 
plot(dy - dy0_fft);

% stem(y0_fft);
% hold on;
% stem(y1_fft);



