%% 2.2 (a) Karatis Dimitrios 10775

clear;
% Δεδομένα
f = 1e9; % Συχνότητα σε Hz
c0 = 3e8; % Ταχύτητα φωτός σε m/s
lambda = c0 / f; % Μήκος κύματος σε μέτρα
I = 1; % Ρεύμα σε Α
r0 = 50; % Reference distance, assumed based on the provided code
N = 8; % Αριθμός διπόλων
k = 2*pi/lambda;

% Αποστάσεις
distances = [lambda/4, lambda/2, 3*lambda/4];

% Τιμές γωνιών για το οριζόντιο δίαγραμμα ακτινοβολίας
theta_hor = pi/2;
phi_hor = linspace(0, 2*pi-0.0001, 1000);

% Τιμές γωνιών για το κατακόρυφο δίαγραμμα ακτινοβολίας
theta_vert = linspace(0, 2*pi-0.0001, 1000);
phi_vert = 0;

for d = distances
    
    % Αρχικοποίηση συνολικών εντάσεων των 2 πεδίων
    E_total_horiz = zeros(size(phi_hor));
    E_total_vert = zeros(size(theta_vert));
    
    % Υπολογισμός έντασης ηλεκτρικού πεδίου για το οριζόντιο διάγραμμα
    for n = 1:N
        r_horiz = r0 - (N-2*n+1) * d/2 * cos(phi_hor) * sin(theta_hor);
        E_total_horiz = E_total_horiz + (60*I/r0) * exp(-1j*k*r_horiz) .* (cos((pi/2)*cos(theta_hor)) ./ sin(theta_hor));
    end

    % Υπολογισμός έντασης ηλεκτρικού πεδίου για το κατακόρυφο διάγραμμα 
    for n = 1:N
        r_vert = r0 - (N-2*n+1) * d/2 * cos(phi_vert) * sin(theta_vert);
        E_total_vert = E_total_vert + (60*I/r0) * exp(-1j*k*r_vert) .* (cos((pi/2)*cos(theta_vert)) ./ sin(theta_vert));
    end
    
    % Οριζόντιο δίαγραμμα ακτινοβολίας 
    figure;
    polarplot(phi_hor, abs(E_total_horiz), 'LineWidth', 1);
    title(['Οριζόντιο δίαγραμμα ακτινοβολίας για d = ', num2str(d/lambda), '\lambda']);
    
    % Κατακόρυφο δίαγραμμα ακτινοβολίας 
    figure;
    polarplot(theta_vert, abs(E_total_vert), 'LineWidth', 1);
    title(['Κατακόρυφο δίαγραμμα ακτινοβολίας για d = ', num2str(d/lambda), '\lambda']);
end
