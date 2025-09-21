%% 2.4 (a) Karatis Dimitrios 10775

clear;
global f c0 lambda0 d epsilon_r Q Z0 A B W_d W epsilon_r_eff lambda l beta alpha

% Δεδομένα
f = 2.5e9; % Συχνότητα σε Hz
c0 = 3e8; % Ταχύτητα φωτός σε in m/s
lambda0 = c0 / f; % Μήκος κύματος σε μέτρα
d = 1.6e-3; % Πάχος υποστρώματος FR4
epsilon_r = 4.4; % Σχετική διηλεκτρική σταθερά FR4
Q = 25; % Συντελεστής ποιότητας
Z0 = 50; % Χαρακτηριστική αντίσταση γραμμής μικροταινίας

tand = 0.0371; % Εφαπτομένη απωλειών σύμφωνα με το δίκτυο στη συχνότητα 2.5 Ghz
m0 = 12.57e-7;

% Υπολογισμός πλάτους συντονιστή (χρήση των σχέσεων 5.56 και 5.57 του βιβλίου σελ.223)
A = (Z0/60) * sqrt((epsilon_r + 1) / 2) + ((epsilon_r-1)/(epsilon_r+1)) * (0.23 + 0.11/epsilon_r);
B = (60*pi*pi)/(Z0*sqrt(epsilon_r));

W_d = 0;

if A > 1.52
    W_d = 8*exp(A)/(exp(2*A) - 2);
else
    W_d = (2/pi) * (B-1-log(2*B-1) + ((epsilon_r-1)/(2*epsilon_r)) * (log(B-1) + 0.39 - 0.61/epsilon_r));
end

W = W_d * d

% Υπολογισμός ενεργούς διηλεκτρικής σταθεράς (χρήση των σχέσεων 5.52 και 5.53 σελ 222)
if W_d > 1
    F = 1 / (sqrt(1+12*d/W));
else
    F = (1 / (sqrt(1+12*d/W))) + 0.04*(1-W_d)^2;
end

epsilon_r_eff = ((epsilon_r + 1) / 2) + ((epsilon_r - 1) / 2) * F

% Υπολογισμός λ 
lambda = lambda0 / sqrt(epsilon_r_eff);

% Υπολογισμός μήκους συντονιστή
l = lambda / 2

% Υπολογισμός β
beta = (2*pi*f/c0) * sqrt(epsilon_r_eff);

% Υπολογισμός απωλείων α = αc + αd
alpha = beta / (2*Q)

alpha_d = ((2*pi*f/c0)*epsilon_r*(epsilon_r_eff-1)*tand) / (2*sqrt(epsilon_r_eff)*(epsilon_r-1))
alpha_c = alpha - alpha_d

Rs = alpha_c*Z0*W;

sigma = (pi*f*m0) / (Rs^2)
    
function fr_result = Equation_for_fr(fr)
    global l c0 epsilon_r_eff alpha
    % Υπολογισμός fr
    fr_result = tan((2*pi*fr*l)/(c0/sqrt(epsilon_r_eff))) + sqrt((alpha*c0)/(2*fr*sqrt(epsilon_r_eff)));
end

% Αρχική εκτίμηση για το fr
initial_guess = 2.5e9; 

% Λύση με χρήση της fzero
fr_solution = fzero(@Equation_for_fr, initial_guess);
disp(['fr = ', num2str(fr_solution)]);

% Υπολογισμός χωρητικότητας δικένου
C = -1 * tan((2*pi*fr_solution*l)/(c0/sqrt(epsilon_r_eff))) / (Z0 * 2*pi*fr_solution)
