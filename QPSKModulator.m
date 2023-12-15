classdef QPSKModulator < Modulator

    methods

        function modulated_signal = modulate(obj, E, bits)
            symbols = obj.encodeSymbols(bits)';
            symbols = bin2gray(symbols, 'psk', 4);
            theta = 2 * pi * symbols / obj.M;
            modulated_signal = sqrt(E) .* exp(1i * (theta + (pi / 4)));
        end

        function obj = QPSKModulator()
            obj@Modulator();
            obj.M = 4;
        end

    end

end
