classdef Channel

    properties
        SNR
    end

    methods

        function [bits, ber] = addNoise(obj, signal, E, type)

            switch type
                case ModulationTypes.BPSK
                    Eb = E;
                case ModulationTypes.QPSK
                    Eb = E / 2;
                case ModulationTypes.PSK8
                    Eb = E / 3;
                case ModulationTypes.QAM16
                    Eb = 2.5 * E;

                otherwise
                    error('Unknown modulation type');
                    return
            end

            len = length(signal);
            No = Eb / (10 ^ (obj.SNR / 10));
            fprintf('No = %f for type %s\n', No, char(type));
            noise_scale = sqrt(No / 2);
            noise = (randn(len, 1) + 1i * randn(len, 1)) .* noise_scale;

            switch type
                case ModulationTypes.BPSK
                    ber = erfc(sqrt(Eb / No));
                case ModulationTypes.QPSK
                    ber = (1/2) * erfc(sqrt(Eb / No));
                case ModulationTypes.PSK8
                    ber = (1/3) * erfc((sqrt(3 * Eb) * sin(pi / 8)) / sqrt(No));
                case ModulationTypes.QAM16
                    ber = (3/8) * erfc(sqrt(E / No));
            end

            bits = signal + noise;
        end

        function obj = Channel(SNR)
            obj.SNR = SNR;
        end

    end

end