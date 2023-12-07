%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Communications-2 Project
%% Team:
%% - Ahmed Mohamed Saad - 1190184
%% - Hazem Montasser - 2200003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all

import ModulationTypes.*;
import Modulator.*;
import DigitalMapper.*;
import demapBits.*;
import Channel.*;

%bits = [1 0 1 0 0 1 0 0 1 1 1 1 0 0 0 1 1 0 0 0];
%bits = randi([0 1], 1, 48 * 1000);

bits = randi([0 1], 1, 12000);
SNR = 10;
E = 5;

%% Add modulators
mapper = DigitalMapper();
mapper.addModulator(ModulationTypes.BPSK);
mapper.addModulator(ModulationTypes.QPSK);
mapper.addModulator(ModulationTypes.PSK8);
mapper.addModulator(ModulationTypes.QAM16);

%% Modulate all signals
modulated_signals = mapper.modulate(E, bits);
bpsk_mod = modulated_signals(char(ModulationTypes.BPSK));
qpsk_mod = modulated_signals(char(ModulationTypes.QPSK));
psk8_mod = modulated_signals(char(ModulationTypes.PSK8));
qam16_mod = modulated_signals(char(ModulationTypes.QAM16));

%% Add noise
channel = Channel(SNR);

[noisy_bpsk, bpsk_ber] = channel.addNoise(bpsk_mod, E, ModulationTypes.BPSK);
[noisy_qpsk, qpsk_ber] = channel.addNoise(qpsk_mod, E, ModulationTypes.QPSK);
[noisy_psk8, psk8_ber] = channel.addNoise(psk8_mod, E, ModulationTypes.PSK8);
[noisy_qam16, qam16_ber] = channel.addNoise(qam16_mod, E, ModulationTypes.QAM16);

%% Demodulate
psk8_demod = demapBits(noisy_psk8, E, ModulationTypes.PSK8);
qam16_demod = demapBits(noisy_qam16, E, ModulationTypes.QAM16);
bpsk_demod = demapBits(noisy_bpsk, E, ModulationTypes.BPSK);
qpsk_demod = demapBits(noisy_qpsk, E, ModulationTypes.QPSK);

%% Calculate bit loss
bpsk_bit_loss = bpsk_ber .* length(bits);
qpsk_bit_loss = qpsk_ber .* length(bits);
psk8_bit_loss = psk8_ber .* length(bits);
qam16_bit_loss = qam16_ber .* length(bits);

%% Display results
fprintf("Actual number of errors:\n")
fprintf("BPSK: %d bits,\testimated: %.5f bits\n", biterr(bits, bpsk_demod), bpsk_bit_loss)
fprintf("QPSK: %d bits,\testimated: %.5f bits\n", biterr(bits, qpsk_demod), qpsk_bit_loss)
fprintf("PSK8: %d bits,\testimated: %.5f bits\n", biterr(bits, psk8_demod), psk8_bit_loss)
fprintf("QAM16: %d bits,\testimated: %.5f bits\n", biterr(bits, qam16_demod), qam16_bit_loss)

%% Plot
scatterplot(noisy_bpsk)
title('Noisy BPSK');
scatterplot(noisy_qpsk)
title('Noisy QPSK');
scatterplot(noisy_psk8)
title('Noisy PSK8');
scatterplot(noisy_qam16)
title('Noisy QAM16');
