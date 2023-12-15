classdef PSK8Modulator < Modulator

    methods

        function modulated_signal = modulate(obj, E, bits)
            symbols = obj.encodeSymbols(bits)';
            symbols = bin2gray(symbols, 'psk', 8);
            theta = 2 * pi * symbols / obj.M;
            modulated_signal = sqrt(E) .* exp(1i * (theta));
        end

        function obj = PSK8Modulator()
            obj@Modulator();
            obj.M = 8;
        end

    end

end
