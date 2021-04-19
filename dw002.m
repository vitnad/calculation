
omega = 20*pi;
phi = 0;
%Переменные
delta_omega = 0;
gamma = 0;
a = [0 2 4 6 8 10];
a_0 = {'h1', 'h2', 'h3', 'h4', 'h5', 'h6'};
specification = {'M', 'delta_omega', 'gamma', '', '', ''};
varNames = {'eps = 5', 'eps = 6', 'eps = 7', 'eps = 8', 'eps = 9', 'eps = 10', 'eps = 11', 'eps = 12', 'eps = 13', 'eps = 14', 'eps = 15', 'eps = 16', 'eps = 17', 'eps = 18', 'eps = 19', 'eps = 20', 'h', ' ', 'specification', '-'};
Table = table (a', a', a', a', a', a', a', a', a', a', a', a', a', a', a', a', a_0', a', specification', [0 0 0 0 0 0]', 'VariableNames', varNames, 'RowNames', {'P_1'; 'P_2'; 'P_3'; 'P_4'; 'P_5'; 'P_6'});
String = 'A1';
d = '1';
M = 4;

delta_omega = 0.04;

for l = 1:4 %счетчик отвечает за изменение delta_omega
    
    gamma = 0;
    
    for j = 0:4 %счетчик отвечает за изменение угла
    alpha = gamma - phi;
    beta = delta_omega * omega + alpha;
    
    %Вводим специальные поля
    
    Table (1, 20) = num2cell (M);
    Table (2, 20) = num2cell (delta_omega);
    Table (3, 20) = num2cell (gamma);

        for i = 0:5 %счетчик отвечает за параметр h
            h = 0.2 * i;
            V = (M - 1)*h;
            
            W_2 = 0;
           % W_1 = 0;
            const_1 =2*V*(sin(delta_omega*omega + gamma) - sin(gamma)) / (delta_omega * omega);
            const_2 =V^2/2 + V^2*(sin(2*delta_omega*omega + 2*gamma) - sin(2*gamma))/(delta_omega * omega*4);
            for g = 1:M/2;
                U_g = M + 1 - 2*g;
                W_2_g = U_g^2;
                W_2 = W_2 + W_2_g;
               % W_1_g = U_g^2 + U_g*const_1 + const_2;
               % W_1 = W_1 + W_1_g;
            end
            W_2 = (W_2 * 2) / M;
           
             W_1 = (10 + 4*const_1 + 2*const_2)*2/M
            
            k = W_1 / W_2;

            eps_db = [11.0956 12.6108 13.748];
            eps = 10.^(eps_db/10);
        P = ((M-1)/M)*erfc(sqrt(((3*log2(M)) / (M^2-1)) * eps*k));

            for i_1 = 1:3
                Table (i + 1, i_1) = {P(i_1)};
            end
            Table (i + 1, 18) = num2cell (h);
        end
    
    %Записываем таблицу в файл
    writetable (Table, 'aprilllll.xls', 'WriteRowNames', true, 'Range', String)
    Sub_string = String(2: my_function (str2num (d)) + 1);
    d = str2num (Sub_string) + 8;
    d = string (d);
    String = strrep (String, Sub_string, d);
    String = convertStringsToChars(String);
    
    gamma = gamma + pi/4;
    end

    gamma = -2*pi;
    


