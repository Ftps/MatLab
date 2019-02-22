H = tf([0 7842.1530856],[1 171.716208 15684.306]);
f = [1 10 16.67 18 19 20 21 22 25 33 66.7 100];
vb = [2 1.9 1.65 1.55 1.45 1.4 1.35 1.25 1.05 0.66 0.175 0.078];
ph = [-0.069120 -0.7854 -1.309 -1.4025 -1.4819 -1.5708 -1.6535 -1.7074 -1.9164 -2.26195 -2.7646 -2.8274];
w2 = 2*pi*f;
b = 0.25*vb;
z = zeros(size(f));
w1 = logspace(0, 4, 1000);
w = sort([w1 w2], 'ascend');
[mag, phase] = bode(H, w);

x1 = [0 2.1118 5.6735 8.9329 12.571 15.025];
y1 = [0 0.363994 0.978030 1.53960 2.16710 2.59044];
x2 = [0 2.2763 7.6534 15.025];
y2 = [0 0.392351 1.31923 2.59044];

x1 = x1(:)/1000;
x2 = x2(:)/1000;
y1 = y1(:);
y2 = y2(:);


bs = x1()\y1
bd = x2()\y2
ys = bs.*x1;
yd = bd.*x2;

Rsq_s = 1 - sum((y1-ys).^2)/sum((y1-mean(y1)).^2)
Rsq_d = 1 - sum((y2-yd).^2)/sum((y2-mean(y2)).^2)

text1 = sprintf('y=%fx\nR2=%f', bs, Rsq_s);
text2 = sprintf('y=%fx\nR2=%f', bd, Rsq_d);

for i = 1:1:12
    z(i) = find(w == w2(i));
end

figure(1)
subplot(2,1,1)
semilogx(w, 20*log(squeeze(mag)), w(z), 20*log(b), 'rs')
xlabel('\omega in rad/s')
ylabel('|H(j\omega)|dB')
grid on

subplot(2,1,2)
semilogx(w, squeeze(phase), w(z), ph*180/pi, 'rs')
xlabel('\omega in rad/s')
ylabel('\phi in º')
grid on

figure(2)
subplot(2, 1, 1)
plot(x1, y1, 'bs', linspace(0,0.016), bs.*linspace(0,0.016), 'b')
xlabel('I/A')
ylabel('V/V')
text(0.004, 2, text1)
grid on
subplot(2, 1, 2)
plot(x2, y2, 'bs', linspace(0,0.016), bd.*linspace(0,0.016), 'b')
xlabel('I/A')
ylabel('V/V')
text(0.004, 2, text2)
grid on





