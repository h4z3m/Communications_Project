classdef Modulator

    properties
        type = ModulationTypes.BPSK
        signal_fn = 0
        M = 0
        phi_1 = @(t, T, f_c) cos(2 * pi * f_c * t) / sqrt(T / 2);
        phi_2 = @(t, T, f_c) sin(2 * pi * f_c * t) / sqrt(T / 2);
    end

    methods

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
