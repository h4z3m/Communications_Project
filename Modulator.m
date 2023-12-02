classdef Modulator

    properties
        type = ModulationTypes.BPSK
        signal_fn = 0
        M = 0
        phi_1 = @(t, T, f_c) cos(2 * pi * f_c * t) / sqrt(T / 2);
        phi_2 = @(t, T, f_c) sin(2 * pi * f_c * t) / sqrt(T / 2);
    end

    methods

        function decoded_value = decode(obj, T, f_c, E, symbol, t, x)

            if obj.type == ModulationTypes.QAM16
                % Set the input values ai and bi based on the current bit
                if symbol(1) == 0 && symbol(2) == 0
                    ai = -3;
                elseif symbol(1) == 0 && symbol(2) == 1
                    ai = -1;
                elseif symbol(1) == 1 && symbol(2) == 1
                    ai = 1;
                else
                    ai = 3;
                end

                if symbol(3) == 0 && symbol(4) == 0
                    bi = 3;
                elseif symbol(3) == 0 && symbol(4) == 1
                    bi = 1;
                elseif symbol(3) == 1 && symbol(4) == 1
                    bi = -1;
                else
                    bi = -3;
                end

                decoded_value = obj.signal_fn(ai, bi, t + x * T, T, f_c, E);
            else

                bitsString = char(symbol + '0');
                integer = bin2dec(bitsString);
                decoded_value = obj.signal_fn(integer, t, T, f_c, E, obj.M);
            end

        end

        function modulated_bits = modulate(obj, T, f_c, E, bits)

            k = log2(obj.M); % Number of bits per symbol

            modulated_bits = zeros(floor(length(bits) / k), 1);
            x = 1;
            y = 1;

            for i = 1:k:(length(bits) - mod(length(bits), k))
                %% Decode the bits
                for t = 0:0.05:T
                    % Calculate the signal value for the current bit
                    modulated_bits(y) = obj.decode(T, f_c, E, bits(i:i + k - 1), t, x);
                    y = y + 1;
                end

                x = x + 1;
            end

        end

        function obj = Modulator(type)
            obj.type = type;

            switch type
                case ModulationTypes.BPSK
                    obj.M = 2;
                case ModulationTypes.QPSK
                    obj.M = 4;
                case ModulationTypes.PSK8
                    obj.M = 8;
                case ModulationTypes.QAM16
                    obj.M = 16;
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%         Signal Function (S_i(t))      %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            phi_1 = obj.phi_1;
            phi_2 = obj.phi_2;

            if obj.type == ModulationTypes.QAM16
                obj.signal_fn = @(ai, bi, t, T, f_c, E) sqrt(E) * ai * phi_1(t, T, f_c) - sqrt(E) * bi * phi_2(t, T, f_c);
            else
                obj.signal_fn = @(i, t, T, f_c, E, M) sqrt(E) * cos((2 * i - 1) * (pi / M)) * phi_1(t, T, f_c) ...
                    - sqrt(E) * sin((2 * i - 1) * (pi / M)) * phi_2(t, T, f_c);
            end

        end

    end

end
