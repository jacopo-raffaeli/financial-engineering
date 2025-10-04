function optionPrice = EuropeanOptionCRR(S0, K, r, q, T, sigma, nStep, flag) 
    % EuropeanOptionCRR computes the price of a European option using the 
    % Cox-Ross-Rubinstein (CRR) binomial tree model.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   nSim  - Number of time steps in the binomial tree
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option

    % Compute parameters for the binomial tree

    % Time step
    dt = T / nStep;

    % Up and down factors
    u = exp(sigma * sqrt(dt));
    d = 1 / u;

    % Risk-neutral up probability
    p = (1 - d) / (u - d);
    
    % Compute forward price
    F0 = S0 * exp((r - q) * T);

    % Compute asset prices at maturity
    FT = F0 * u.^(nStep:-2:-nStep);

    % Compute option values at maturity
    % Call option payoff
    if flag == 1
        optionValues = max(FT - K, 0);
    % Put option payoff
    elseif flag == -1
        optionValues = max(K - FT, 0);
    % Invalid flag
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

    % Discount factor
    B = exp(-r * dt);

    % Backward induction to get option price at time 0
    for step = nStep:-1:1
        optionValues = B * (p * optionValues(1:step) + (1 - p) * optionValues(2:step + 1));
    end
    optionPrice = optionValues(1);

end