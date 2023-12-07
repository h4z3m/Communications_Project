classdef QPSKModulator < Modulator

    methods

        function modulated_signal = modulate(obj, E, bits)
            symbols = obj.encodeSymbols(bits)';
            theta = 2 * pi * symbols / obj.M;
            modulated_signal = exp(1i * (theta + pi / 4));
        end

        function obj = QPSKModulator()
            obj@Modulator();
            obj.M = 4;
        end

    end

end
