classdef QAM16Modulator < Modulator

    methods

        function modulated_signal = modulate(obj, E, bits)
            a = [];
            b = [];
            symbols = obj.encodeSymbols(bits)';

            for s = 1:length(symbols)
                symbol = dec2bin(symbols(s), 4);
                ai = 0;
                bi = 0;

                if symbol(1) == '0' && symbol(2) == '0'
                    ai = -3;
                elseif symbol(1) == '0' && symbol(2) == '1'
                    ai = -1;
                elseif symbol(1) == '1' && symbol(2) == '1'
                    ai = 1;
                else
                    ai = 3;
                end

                if symbol(3) == '0' && symbol(4) == '0'
                    bi = -3;
                elseif symbol(3) == '0' && symbol(4) == '1'
                    bi = -1;
                elseif symbol(3) == '1' && symbol(4) == '1'
                    bi = 1;
                else
                    bi = 3;
                end

                a = [a ai];
                b = [b bi];
            end

            modulated_signal = sqrt(E) .* a' + 1i .* sqrt(E) .* b';
        end

        function obj = QAM16Modulator()
            obj@Modulator();
            obj.M = 16;
        end

    end

end
