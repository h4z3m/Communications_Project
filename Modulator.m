classdef Modulator

    properties
        M = 0
    end

    methods

        function encoded_value = encodeSymbols(obj, bits)
            k = log2(obj.M);

            if k == 0
                encoded_value = bits;
                return;
            end

            encoded_value = [];

            if mod(length(bits), k) == 0
                N = length(bits);
            else
                N = floor(length(bits) - mod(length(bits), k));
            end

            for i = 1:k:N
                encoded_value(end + 1) = bin2dec(num2str(bits(i:i + k - 1)));
            end

        end

        function obj = Modulator()

        end

    end

end
