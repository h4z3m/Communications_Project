classdef DigitalMapper

    properties
        modulators = containers.Map();
    end

    methods

        function err = addModulator(obj, type)
            err = "";

            switch type
                case ModulationTypes.BPSK
                    obj.modulators(char(ModulationTypes.BPSK)) = BPSKModulator();
                case ModulationTypes.QPSK
                    obj.modulators(char(ModulationTypes.QPSK)) = QPSKModulator();
                case ModulationTypes.PSK8
                    obj.modulators(char(ModulationTypes.PSK8)) = PSK8Modulator();
                case ModulationTypes.QAM16
                    obj.modulators(char(ModulationTypes.QAM16)) = QAM16Modulator();
                otherwise
                    err = "Unknown modulation type";
            end

        end

        function modulated_bits = modulate(obj, E, bits)
            modulated_bits = containers.Map();

            for key = keys(obj.modulators)
                modulated_bits(char(key)) = obj.modulators(char(key)).modulate(E, bits);
            end

        end

        function obj = DigitalMapper
        end

    end

end
