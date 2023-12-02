clc
close all
clear

% Define random sequence of bits for testing of size 48k
bits = [1 0 1 0 0 1 0 0 1 1 1 1 0 0 0 1 1 0 0 0];
% bits = randi([0 1], 1, 48 * 1000);
% % Set the input values for the signal function
T = 1; % Modify as needed
f_c = 3; % Modify as needed
E = 5; % Modify as needed
M = 16;

% % Create an array to store the signal values for each bit
% signal_values = zeros(length(bits) / 4, 1);
% a = zeros(length(bits) / 4, 1);
% b = zeros(length(bits) / 4, 1);

% modulator = Modulator(ModulationTypes.QAM16);
% x = 1;
% y = 1;
% % Evaluate the signal function for each bit
% for i = 1:4:numel(bits)
%     % Set the input values ai and bi based on the current bit
%     if bits(i) == 0 && bits(i + 1) == 0
%         ai = -3;
%     elseif bits(i) == 0 && bits(i + 1) == 1
%         ai = -1;
%     elseif bits(i) == 1 && bits(i + 1) == 1
%         ai = 1;
%     else
%         ai = 3;
%     end

%     if bits(i + 2) == 0 && bits(i + 3) == 0
%         bi = 3;
%     elseif bits(i + 2) == 0 && bits(i + 3) == 1
%         bi = 1;
%     elseif bits(i + 2) == 1 && bits(i + 3) == 1
%         bi = -1;
%     else
%         bi = -3;
%     end

%     for t = 0:0.05:T
%         % Calculate the signal value for the current bit
%         signal_values(y) = modulator.signal_fn(ai, bi, t + x * T, T, f_c, E);
%         y = y + 1;
%     end

%     a(x) = ai;
%     b(x) = bi;
%     x = x + 1;
% end

% % Display the resulting signal values for each bit
% disp(signal_values);
% fig = figure();

% stairs(a, 'LineWidth', 2);
% figure();
% stairs(b, 'LineWidth', 2);
% figure();

modulator = Modulator(ModulationTypes.PSK8);
signal_values = modulator.modulate(T, f_c, E, bits);
time = linspace(0, T, length(signal_values));
plot(time, signal_values, 'LineWidth', 2);
