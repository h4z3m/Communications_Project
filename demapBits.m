function bits = demapBits(y, E, type)
    bits = [];

    switch type
        case ModulationTypes.BPSK

            for i = 1:length(y)

                if real(y(i)) <= 0
                    bits = [bits 1];
                else
                    bits = [bits 0];
                end

            end

        case ModulationTypes.QPSK
            theta = 2 * pi / 4;

            for i = 1:length(y)
                a = angle(y(i));

                if a >= 0 && a < theta
                    % Gray = 00, binary = 00
                    % symbol = [0 0];
                    bits = [bits 0 0];
                elseif a >= theta && a < 2 * theta
                    % Gray = 01, binary = 01
                    % symbol = [0 1];
                    bits = [bits 0 1];
                elseif a < 0 && a > -theta
                    % Gray = 1 1, binary = 10
                    % symbol = [1 1];
                    bits = [bits 1 0];
                elseif a < -theta && a > -2 * theta
                    % Gray = 1 0, binary = 11
                    % symbol = [1 0];
                    bits = [bits 1 1];
                else
                    disp("error");
                end

                % bits = [bits decimalToBinaryVector(gray2bin(bin2dec(num2str(symbol)), 'psk', 4), 2)];

            end

        case ModulationTypes.PSK8
            theta = pi / 4;

            for i = 1:length(y)
                a = angle(y(i));

                if a <= theta / 2 && a > -theta / 2
                    %symbol = [0 0 0];
                    bits = [bits 0 0 0];
                elseif (a > theta / 2) && (a <= 3 * theta / 2)
                    %symbol = [0 0 1];
                    bits = [bits 0 0 1];
                elseif (a > 3 * theta / 2) && (a <= 5 * theta / 2)
                    %symbol = [0 1 0];
                    bits = [bits 0 1 1];
                elseif (a > 5 * theta / 2) && (a <= 7 * theta / 2)
                    % symbol = [0 1 1];
                    bits = [bits 0 1 0];
                elseif (a > 7 * theta / 2 && a <= pi) || (a >= -pi && a <= -7 * theta / 2)
                    % symbol = [1 0 0];
                    bits = [bits 1 1 1];
                elseif (a > -7 * theta / 2) && (a <= -5 * theta / 2)
                    % symbol = [1 0 1];
                    bits = [bits 1 1 0];
                elseif (a > -5 * theta / 2) && (a <= -3 * theta / 2)
                    % symbol = [1 1 0];
                    bits = [bits 1 0 0];
                elseif (a > -3 * theta / 2) && (a <= -theta / 2)
                    % symbol = [1 1 1];
                    bits = [bits 1 0 1];
                else
                    disp("error");
                end

                % bits = [bits decimalToBinaryVector(gray2bin(bin2dec(num2str(symbol)), 'psk', 8), 3)];
            end

            % bits = gray2bin(bits, 'psk', 8);

        case ModulationTypes.QAM16

            for i = 1:length(y)
                a = real(y(i)) / sqrt(E);
                b = imag(y(i)) / sqrt(E);

                if a > 0

                    if abs(a - 1) < abs(a - 3)
                        a = 1;
                    else
                        a = 3;
                    end

                else

                    if abs(a + 1) < abs(a + 3)
                        a = -1;
                    else
                        a = -3;
                    end

                end

                if b > 0

                    if abs(b - 1) < abs(b - 3)
                        b = 1;
                    else
                        b = 3;
                    end

                else

                    if abs(b + 1) < abs(b + 3)
                        b = -1;
                    else
                        b = -3;
                    end

                end

                symbol = ['0', '0', '0', '0'];

                switch a
                    case 1
                        symbol(1) = '1';
                        symbol(2) = '1';
                    case 3
                        symbol(1) = '1';
                        symbol(2) = '0';
                    case -1
                        symbol(1) = '0';
                        symbol(2) = '1';
                    case -3
                        symbol(1) = '0';
                        symbol(2) = '0';
                end

                switch b
                    case 1
                        symbol(3) = '1';
                        symbol(4) = '1';
                    case 3
                        symbol(3) = '1';
                        symbol(4) = '0';
                    case -1
                        symbol(3) = '0';
                        symbol(4) = '1';
                    case -3
                        symbol(3) = '0';
                        symbol(4) = '0';
                end

                bits = [bits decimalToBinaryVector(bin2dec(symbol), 4)];

            end

    end

end
