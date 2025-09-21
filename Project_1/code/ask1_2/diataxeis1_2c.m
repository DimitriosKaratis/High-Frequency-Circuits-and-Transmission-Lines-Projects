%% 1.2 (c) Karatis Dimitrios 10775

% Δεδομένα
f0 = 1e9; % Κεντρική συχνότητα σε Hz
c = 3e8; % Ταχύτητα φωτός σε m/s
lambda0 = c / f0; % Μήκος κύματος στη συχνότητα f0
N = 200; % Αριθμός τιμών συχνότητας
ZLoad = 50; % Τιμή φορτίου σε Ω

% Χαρακτηριστικές αντιστάσεις γραμμών σε Ω
ZH = 150;
ZL = 20;
Z0 = 50;

% Υπολογισμός l1 = x1*λ, για λ σε συχνότητα f0
x1 = (21.903 * (pi/180)) / (2*pi);
x2 = (31.426 * (pi/180)) / (2*pi);
x3 = (37.720 * (pi/180)) / (2*pi);
x4 = (31.426 * (pi/180)) / (2*pi);
x5 = (21.903 * (pi/180)) / (2*pi);

l1 = x1 * lambda0;
l2 = x2 * lambda0;
l3 = x3 * lambda0;
l4 = x4 * lambda0;
l5 = x5 * lambda0;

% Συχνότητες
f = 0:(2*f0/N):(2*f0); % Διάνυσμα συχνοτήτων

% Σταθερά διάδοσης β
beta = (2*pi*f/f0) / lambda0;

Zin1 = ZH * (ZLoad + 1i*ZH*tan(beta*l5)) ./ (ZH + 1i*ZLoad*tan(beta*l5)); % Αντίσταση εισόδου δεξιά του ΖL μήκους l4 
Zin2 = ZL * (Zin1 + 1i*ZL*tan(beta*l4)) ./ (ZL + 1i*Zin1.*tan(beta*l4)); % Αντίσταση εισόδου δεξιά του ΖΗ μήκους l3 
Zin3 = ZH * (Zin2 + 1i*ZH*tan(beta*l3)) ./ (ZH + 1i*Zin2.*tan(beta*l3)); % Αντίσταση εισόδου δεξιά του ΖL μήκους l2 
Zin4 = ZL * (Zin3 + 1i*ZL*tan(beta*l2)) ./ (ZL + 1i*Zin3.*tan(beta*l2)); % Αντίσταση εισόδου δεξιά του ΖH μήκους l1 
Zin5 = ZH * (Zin4 + 1i*ZH*tan(beta*l1)) ./ (ZH + 1i*Zin4.*tan(beta*l1)); % Αντίσταση εισόδου αριστερά του ΖH μήκους l1 ή αλλιώς συνολική αντίσταση εισόδου 

Zin = Zin5;

% Υπολογισμός του μέτρου του συντελεστή ανάκλασης Γ στην είσοδο
Gamma = abs((Zin - Z0) ./ (Zin + Z0));
Gamma_dB = 20*log10(Gamma);

% Υπολογισμός του SWR
SWR = (1 + Gamma) ./ (1 - Gamma);
%SWR_dB = 20*log10(SWR);

% Εμφάνιση του γραφήματος Gamma σε dB
figure;
plot(f, Gamma_dB);
xlabel('Συχνότητα (Hz)');
ylabel('Μέτρο συντελεστή ανάκλασης (dB)');
title('Μέτρο συντελεστή ανάκλασης (dB) σε συνάρτηση με τη συχνότητα');
grid on;

% Εμφάνισε μέχρι την τιμή max_SWR
max_SWR = 10;

% Φίλτραρε τα δεδομένα
f_filtered = f(SWR <= max_SWR);
SWR_filtered = SWR(SWR <= max_SWR);

% Εμφάνιση του γραφήματος SWR σε dB μέχρι το max_SWR
figure;
plot(f_filtered, SWR_filtered);
xlabel('Συχνότητα (Hz)');
ylabel('SWR');
title('Μέτρο SWR σε συνάρτηση με τη συχνότητα');
grid on;

