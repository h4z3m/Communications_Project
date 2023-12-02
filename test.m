import Modulator.*
% Define the time period
start_time = 0;
end_time = 1; % Modify this according to your desired time period
time_step = 0.01; % Adjust the time step as needed

% Create an array of time points
t = start_time:time_step:end_time;

% Create an array to store the signal values
signal_values = zeros(size(t));

% Set the input values for the signal function
ai = 0.5; % Modify as needed
bi = 0.3; % Modify as needed
T = 1; % Modify as needed
f_c = 10; % Modify as needed
E = 2; % Modify as needed

% Evaluate the signal function for each time point
for i = 1:numel(t)
    signal_values(i) = modulator.signal_fn(ai, bi, t(i), T, f_c, E);
end

% Plot the signal over the time period
plot(t, signal_values);
xlabel('Time');
ylabel('Signal');
title('Signal over Time');
testModulatorSignalFn();

function testModulatorSignalFn()
    % Create an instance of the Modulator class
    modulator = Modulator(ModulationTypes.QAM16);

    % Set input values for the signal function
    ai = 0.5;
    bi = 0.3;
    t = 0.1;
    T = 1;
    f_c = 10;
    E = 2;

    % Call the signal function
    result = modulator.signal_fn(ai, bi, t, T, f_c, E);
    disp(result);
    % Verify the output
    expected = sqrt(E) * ai * modulator.phi_1(t, T, f_c) - sqrt(E) * bi * modulator.phi_2(t, T, f_c);
    assert(isequal(result, expected), 'Signal function output is incorrect');
end
