%% 2.1 (b) Karatis Dimitrios 10775

clear;

% Ορισμός της συνάρτησης από την οποία θα προκύψουν τα εr και tanδ
function F = myEquation(vars)
    f = 10e9; % Συχνότητα σε Hz
    c0 = 3e8; % Ταχύτητα του φωτός σε m/s
    a = 2.286e-2; % Πλάτος κυματοδηγού σε m
    b = 1.016e-2; % Υψος κυματοδηγού σε m
    d = 1.5e-3; % Πάχος δείγματος σε m
    L = 6e-2; % Μήκος κυματοδηγού σε m
    Zin = 4.9678 + 1j*43.9439; % Μέτρηση κυματικής αντίστασης
    hta0 = 120*pi; % Κυματική αντίσταση του μέσου

    er = vars(1);
    tand = vars(2);

    % Χωρίς διηλεκτρικό
    fc0 = c0 / (2*pi) * (pi / a); % Συχνότητα αποκοπής επικρατέστερου ρυθμού (ΤΕ10) σε Hz
    Z0 = hta0 / (sqrt(1 - (fc0 / f)^2));
    beta0 = 2 * pi * f / c0 * sqrt(1 - (fc0 / f)^2);

    ZA = Z0 * (Zin - 1j * Z0 * tan(beta0*(L-d))) / (Z0 - 1j * Zin * tan(beta0*(L-d))); % Αντίσταση εισόδου του βραχυκυκλωμένου διηλεκτρικού τμήματος μήκους d
    
    % Με διηλεκτρικό
    Z1 = hta0 / sqrt((er - er * tand * 1j) - (fc0 /f)^2);
    beta1 = 2 * pi * f / c0 * sqrt((er - er * tand * 1j) - (fc0 /f)^2);
    k1 = 2 * pi * f /c0 * sqrt(er - er * tand * 1j);

    gamma1 = (k1^2) * tand / (2 * beta1) + 1j * beta1;


    F = Z1 * tanh(gamma1 * d) - ZA;
end

% Αρχικές εκτιμήσεις
initial_guess = [4.5, 0.2];

% Επίλυση μέσω fsolve
solution = fsolve(@myEquation, initial_guess);

% Εμφάνιση λύσης
disp('Solution:')
disp(['εr = ', num2str(solution(1))])
disp(['tanδ = ', num2str(solution(2))])
