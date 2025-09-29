function optionPrice = EuropeanOptionCRR(F0, K, B, T, sigma, N, flag) 
    % EuropeanOptionCRR computes the price of a European option using the Cox-Ross-Rubinstein (CRR) binomial tree model.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Annualized continuously compounded risk-free rate of return over life of the option
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of time steps in the binomial tree
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option

    % Calculate parameters for the binomial tree
    % Time step
    dt = T / N;
    % Up and down factors
    u = exp(sigma * sqrt(dt));
    d = 1 / u;
    % Risk-neutral probability
    a = exp(B * dt);
    p = (a - d) / (u - d);
    
    % Compute asset prices at maturity
    assetPrices = zeros(N + 1, 1);
    for i = 0:N
        assetPrices(i + 1) = F0 * (u^i) * (d^(N - i));
    end

    % Compute option values at maturity
    if flag == 1
        % Call option payoff
        optionValues = max(assetPrices - K, 0);
    elseif flag == -1
        % Put option payoff
        optionValues = max(K - assetPrices, 0);
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

    % Backward induction to calculate option price at the root
    for step = N:-1:1
        optionValues = exp(-B * dt) * (p * optionValues(2:step + 1) + (1 - p) * optionValues(1:step));
    end
    optionPrice = optionValues(1);