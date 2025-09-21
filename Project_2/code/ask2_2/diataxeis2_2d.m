%% 2.2 (d) Karatis Dimitrios 10775

clc;
clear;

% Υπολογισμός αποστάσεων hx και hy για τις τρεις περιπτώσεις
syms hx hy n m p q;

% Αρχικές παράμετροι
f = 1e9; % Συχνότητα σε Hz
I = 1; % Ρεύμα 1Α
c0 = physconst('LightSpeed'); % Ταχύτητα φωτός σε m/s
lambda = c0 / f; % Μήκος κύματος σε μέτρα
k = 2 * pi / lambda; % Κυματικός αριθμός
r = 50; % Απόσταση αναφοράς

% 1η περίπτωση
eq11 = sqrt(2)/2 * k * (hx + hy) == 2*pi*n;
eq12 = sqrt(2)/2 * k * (-hx + hy) == (2*m + 1)*pi;
equation1 = [eq11, eq12];

solution_case1 = solve(equation1, [hx, hy]);

case_hx1 = solution_case1.hx;
case_hy1 = solution_case1.hy;

% Έυρος τμών για τα n,m
n_range = -2:2;
m_range = -2:2;

disp('Λύσεις για την 1η περίπτωση για συγκεκριμένο εύρος τιμών n,m:');
for n_val = n_range
    for m_val = m_range
        specific_hx1 = subs(case_hx1, [n, m], [n_val, m_val]);
        specific_hy1 = subs(case_hy1, [n, m], [n_val, m_val]);
        if (double(specific_hx1) > 0) & (double(specific_hy1) > 0)
            disp(['n = ', num2str(n_val), ', m = ', num2str(m_val)]);
            disp(['hx1: ', num2str(double(specific_hx1))]);
            disp(['hy1: ', num2str(double(specific_hy1))]);
            disp(newline);
        end
    end
end






% 2η περίπτωση
eq11_case2 = sqrt(2)/2 * k * (hx + hy) == (2*p + 1)*pi;
eq12_case2 = sqrt(2)/2 * k * (-hx + hy) == 2*q*pi;
equation2 = [eq11_case2, eq12_case2];

solution_case2 = solve(equation2, [hx, hy]);

case_hx2 = solution_case2.hx;
case_hy2 = solution_case2.hy;


% Έυρος τμών για τα p,q
p_range = -2:2;
q_range = -2:2;

disp('Λύσεις για την 2η περίπτωση για συγκεκριμένο εύρος τιμών n,m:');
for p_val = p_range
    for q_val = q_range
        specific_hx2 = subs(case_hx2, [p, q], [p_val, q_val]);
        specific_hy2 = subs(case_hy2, [p, q], [p_val, q_val]);
        if (double(specific_hx2) > 0) & (double(specific_hy2) > 0)
            disp(['p = ', num2str(p_val), ', q = ', num2str(q_val)]);
            disp(['hx2: ', num2str(double(specific_hx2))]);
            disp(['hy2: ', num2str(double(specific_hy2))]);
            disp(newline);
        end
    end
end

disp(newline);
disp('Γενικές λύσεις για την 1η περίπτωση');
disp('hx1:');
disp(case_hx1);
disp('hy1:');
disp(case_hy1);

disp(newline);
disp('Γενικές λύσεις για την 2η περίπτωση');
disp('hx2:');
disp(case_hx2);
disp('hy2:');
disp(case_hy2);


%%%%%%%% Για το (δ1) %%%%%%%%%%%%%%%%%
% Ορισμός των γωνιών φ
phi = linspace(0, 2 * pi, 1000);

hxd1 = 0.10599;
hyd1 = 0.10599;

% Υπολογισμός έντασης ηλεκτρικού πεδίου με βάσει την αρχή της επαλληλίας
E0 = (1j*60*I/r)*exp(-j*k/r);
E1_total_horiz = 2*E0 * (cos(k*(hxd1*cos(phi)+ hyd1*sin(phi))) - cos(k*(-hxd1*cos(phi) + hyd1*sin(phi))));

% Οριζόντιο δίαγραμμα ακτινοβολίας 
figure;
polarplot(phi, abs(E1_total_horiz), 'LineWidth', 1);
title(['Οριζόντιο δίαγραμμα ακτινοβολίας για (δ1)']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% Για το (δ2) %%%%%%%%%%%%%%%%%
% Ορισμός των γωνιών φ
phi = linspace(0, 2 * pi, 1000);

hxd2 = 0.10599;
hyd2 = 0.31798;

% Υπολογισμός έντασης ηλεκτρικού πεδίου με βάσει την αρχή της επαλληλίας
E0 = (1j*60*I/r)*exp(-j*k/r);
E2_total_horiz = 2*E0 * (cos(k*(hxd2*cos(phi)+ hyd2*sin(phi))) - cos(k*(-hxd2*cos(phi) + hyd2*sin(phi))));

% Οριζόντιο δίαγραμμα ακτινοβολίας 
figure;
polarplot(phi, abs(E2_total_horiz), 'LineWidth', 1);
title(['Οριζόντιο δίαγραμμα ακτινοβολίας για (δ2)']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% Για το (δ3) %%%%%%%%%%%%%%%%%
% Ορισμός των γωνιών φ
phi = linspace(0, 2 * pi, 1000);

hxd3 = 0.31798;
hyd3 = 0.31798;

% Υπολογισμός έντασης ηλεκτρικού πεδίου με βάσει την αρχή της επαλληλίας
E0 = (1j*60*I/r)*exp(-j*k/r);
E3_total_horiz = 2*E0 * (cos(k*(hxd3*cos(phi)+ hyd3*sin(phi))) - cos(k*(-hxd3*cos(phi) + hyd3*sin(phi))));

% Οριζόντιο δίαγραμμα ακτινοβολίας 
figure;
polarplot(phi, abs(E3_total_horiz), 'LineWidth', 1);
title(['Οριζόντιο δίαγραμμα ακτινοβολίας για (δ3)']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%