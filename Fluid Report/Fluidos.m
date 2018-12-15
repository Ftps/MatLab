r = xlsread('~/Documents/dados.xlsx', 'C3:BA3');
V1 = xlsread('~/Documents/dados.xlsx', 'C4:BA4');
V2 = xlsread('~/Documents/dados.xlsx', 'C5:BA5');

Q1 = V1.*r;
Q2 = V2.*r;
M1 = V1.*Q1;
M2 = V2.*Q2;
E1 = V1.*M1;
E2 = V2.*M2;

rho = 1.164;
dr = 0.0008;
B = 0.0848;
C = 3.31;
R = 0.007;

qt = zeros(1,2);
qs = zeros(1,2);
mt = zeros(1,2);
ms = zeros(1,2);
et = zeros(1,2);
es = zeros(1,2);
U_c = zeros(1,2);
x_t = zeros(1,2);

qt(1) = pi*rho*trap(Q1, 51, dr);
qt(2) = pi*rho*trap(Q2, 51, dr);
qs(1) = pi*rho*simp(Q1, 51, dr);
qs(2) = pi*rho*simp(Q2, 51, dr);

mt(1) = pi*rho*trap(M1, 51, dr);
mt(2) = pi*rho*trap(M2, 51, dr);
ms(1) = pi*rho*simp(M1, 51, dr);
ms(2) = pi*rho*simp(M2, 51, dr);

et(1) = 0.5*pi*rho*trap(E1, 51, dr);
et(2) = 0.5*pi*rho*trap(E2, 51, dr);
es(1) = 0.5*pi*rho*simp(E1, 51, dr);
es(2) = 0.5*pi*rho*simp(E2, 51, dr);

v_max1 = max(V1);
v_max2 = max(V2);
oof = 0;
delta = [0, 0];

for i = 1:26
   if V1(i) > v_max1/2 && ~bitand(oof, 1)
       delta(1) = (r(i)+r(i-1))/2;
       oof = oof + 1;
   end
   if V2(i) > v_max2/2 && ~bitand(oof, 2)
       delta(2) = (r(i)+r(i-1))/2;
       oof = oof + 2;
   end
   if oof == 3
       break
   end
end

oof = 0;

for i = 26:51
    if V1(i) < v_max1/2 && ~bitand(oof, 1)
        delta(1) = (delta(1) + (r(i)+r(i-1))/2)/2;
        oof = oof + 1;
    end
    if V2(i) < v_max2/2 && ~bitand(oof, 2)
        delta(2) = (delta(2) + (r(i)+r(i-1))/2)/2;
        oof = oof + 2;
    end
    if oof == 3
        break
    end
end

x_t(1) = delta(1)/B;
x_t(2) = delta(2)/B;

for i = 26:51
    r(i) = -r(i);
end

U_c(1) = 7.41*sqrt(ms(1)/rho)/x_t(1);
U_c(2) = 7.41*sqrt(ms(2)/rho)/x_t(2);
y1 = (1+(0.125*C*r.^2)./delta(1)^2).^(-2);
y2 = (1+(0.125*C*r.^2)./delta(2)^2).^(-2);

subplot(2, 1, 1);
scatter(V1/U_c(1), r/R, '+'); hold on;
plot(y1, r/R); hold off;
xlabel('U/U_c');
ylabel('r/R');
title('Data Set 1');

subplot(2, 1, 2);
scatter(V2/U_c(2), r/R, '+'); hold on;
plot(y2, r/R); hold off;
xlabel('U/U_c');
ylabel('r/R');
title('Data Set 2');

DataType = {'Mass Flow (Trapezoid)'; 'Mass Flow (Simpson)'; 'Momentum Flow (Trapezoid)'; 'Momentum Flow (Simpson)'; 'Energy Flow (Trapezoid)'; 'Energy Flow (Simpson)'};
DataSet_1 = [qt(1); qs(1); mt(1); ms(1); et(1); es(1)];
DataSet_2 = [qt(2); qs(2); mt(2); ms(2); et(2); es(2)];

T = table(DataType, DataSet_1, DataSet_2)

function s = simp(data, n, dr)

    s = data(1)+data(n);
    
    for i = 2:(n-1)
        s = s + (3+(-1)^i)*data(i);
    end

    s = s*dr/3;
end

function t = trap(data, n, dr)

    t = 0;
    
    for i = 1:n
        t = t + data(i);
    end
    
    t = t*dr;
end