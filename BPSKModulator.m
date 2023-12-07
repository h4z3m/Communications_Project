classdef BPSKModulator < Modulator

    methods

        function modulated_signal = modulate(obj, E, bits)
            theta = 2 * pi * bits' / obj.M;
            modulated_signal = exp(1i * theta);
        end

        function obj = BPSKModulator()
            obj@Modulator();
            obj.M = 2;
        end

    end

end
