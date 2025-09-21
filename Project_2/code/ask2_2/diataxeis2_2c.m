%% 2.2 (c) Karatis Dimitrios 10775

clear;
function Pr = Pr_func(theta, phi, d)
    % Δεδομένα
    f = 1e9; % Συχνότητα σε Hz
    c = 3e8; % Ταχύτητα του φωτός σε m/s
    lambda = c / f; % Μήκος κύματος σε m
    I = 1; % Ρεύμα σε A
    N = 8; % Αριθμός δίπολων
    r0 = 1;
    k = 2*pi / lambda;
    
    E_total = 0;

    % Υπολογισμός έντασης ηλεκτρικού πεδίου
    for n = 1:N
        r = r0 - (N-2*n+1) .* d/2 .* cos(phi) .* sin(theta);
        E_total = E_total + (60*I/r0) * exp(-1j*k*r) .* (cos((pi/2)*cos(theta)) ./ sin(theta));
    end
    Pr = (abs(E_total).^2 ) / (2*120*pi);
end


% Δεδομένα
f = 1e9; % Συχνότητα σε Hz
c = 3e8; % Ταχύτητα του φωτός σε m/s
lambda = c / f; % Μήκος κύματος σε m
I = 1; % Ρεύμα σε A
N = 8; % Αριθμός δίπολων
r0 = 1;
k = 2*pi / lambda;
d_values = [lambda/4, lambda/2, 3*lambda/4]; % Αποστάσεις

% Κατευθυντικότητα για κάθε απόσταση d
for d = d_values
    % Ορισμός της συνάρτησης
    f = @(theta, phi) sin(theta)*Pr_func(theta, phi, d);

    % Ορισμός των ορίων ολοκλήρωσης
    a = 0;       % Κάτω όριο για το θ
    b = pi;      % Άνω όριο για θ
    c = 0;       % Κάτω όριο για φ
    dd = 2*pi;    % Άνω όριο για φ

    % Ορισμός του αριθμού των υποδιαιρέσεων
    n = 100; % Αριθμός υποδιαιρέσεων σε κάθε διάσταση

    % Υπολογισμός του μεγέθους κάθε υποδιαίρεσης
    dtheta = (b - a) / n;
    dphi = (dd - c) / n;
    
    % Υπολογισμός του διπλού αθροίσματος Riemann
    sumRiemann = 0;
    for i = 1:n
        for j = 1:n
            % Υπολογισμός του κέντρου κάθε υποδιαίρεσης
            theta = a + (i - 0.5) * dtheta;
            phi = c + (j - 0.5) * dphi;
        
            % Προσθήκη της συνεισφοράς κάθε υποδιαίρεσης στο άθροισμα
            sumRiemann = sumRiemann + f(theta, phi) * dtheta * dphi;
       end
    end
    
    max_E_total = 8 * (60*I*r0);
    max_Pr = max_E_total^2 / (2*120*pi);

    D = 4 * pi * max_Pr / sumRiemann;
    D_theorias = 2*N*d/lambda;

    if d == (lambda/4)
        string='d = λ/4';
    elseif d == (lambda/2)
        string='d = λ/2';
    elseif d == (3*lambda/4)
        string='d = 3λ/4';
    end
    
    disp(['Κατευθυντικότητα με επαλληλία για ', string, ': D = ', num2str(D)])
    disp(['Κατευθυντικότητα με χρήση θεωρίας στοιχειοκεραιών για ', string, ': D_theorias = ', num2str(D_theorias)])
    disp(newline)

end