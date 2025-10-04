function gamma = GammaKI(S0, K, KI, r, q, T, sigma, nSim, nStep, flagNum)
    % Computes the gamma of a European option with a knock-in barrier using
    % different pricing method.

    % Inputs:
    %   S0      - Current spot price of the underlying asset
    %   K       - Strike price of the option
    %   KI      - Knock-in barrier level
    %   r       - Risk-free interest rate (annualized)
    %   q       - Continuous dividend yield (annualized)
    %   T       - Time to maturity (in years)
    %   sigma   - Volatility of the underlying asset (annualized)
    %   nSim    - Number of Monte Carlo simulations (only for MC method)
    %   nStep   - Number of time steps (only for CRR tree and MC methods)
    %   flagNum - Pricing method: 1 for closed formula, 2 for CRR tree, 3 for MC

    % Outputs:
    %   gamma   - The computed gamma of the European option with knock-in barrier

    % Optimal h for finite difference
    h = sqrt(eps);

    % Perturbed spot prices
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

