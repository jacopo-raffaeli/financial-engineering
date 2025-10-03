function gamma = GammaKI(S0, K, KI, r, q, T, sigma, nSim, nStep, flagNum)

% Compute variations
h = sqrt(eps);
S0mh = S0 - h;
S0ph = S0 + h;

% Compute option prices
switch flagNum
    % Closed formula
    case 1
        for i = 1:length(S0)
            fmh = EuropeanOptionKIClosed(S0mh, K, KI, r, q, T, sigma);
            fph = EuropeanOptionKIClosed(S0ph, K, KI, r, q, T, sigma);
        end

    % CRR tree
    case 2
        for i = 1:length(S0)
            fmh = EuropeanOptionKICRR(S0mh, K, KI, r, q, T, sigma, nStep);            
            fph = EuropeanOptionKICRR(S0ph, K, KI, r, q, T, sigma, nStep);
        end

    % MC
    case 3
        for i = 1:length(S0)
            fmh = EuropeanOptionKIMC(S0mh, K, KI, r, q, T, sigma, nStep, nSim);            
            fph = EuropeanOptionKIMC(S0ph, K, KI, r, q, T, sigma, nStep, nSim);
        end
end

% Compute gamma
gamma = (fph - fmh) / (2 * h);

end

