function optionPrice = BermudanOptionCRR(S0, K, r, q, T, sigma, nStepPerMonth) 
    % EuropeanOptionCRR computes the price of a European option using the 
    % Cox-Ross-Rubinstein (CRR) binomial tree model.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of time steps in the binomial tree
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option

    % Calculate parameters for the binomial tree
    % Time step
    nMonths = floor(T * 12);
    nStep = nMonths * nStepPerMonth;
    dt = T / nStep;
    % Up and down factors
    u = exp(sigma * sqrt(dt));
    d = 1 / u;
    % Risk-neutral probability
    a = exp((r - q) * dt);
    p = (a - d) / (u - d);
    
    % Compute asset prices
    tree = zeros(nStep+1,nStep+1);
    tree(1,1) = S0;
    for i = 1:nStep
        S = S0 * u.^(i:-2:-i);
        for j = 1:i+1
            tree(j,i+1) = S(j);
        end
    end

    % Compute option values at maturity
    ST = tree(:, end);
    B = exp(-r * dt);
    optionValues = max(ST - K, 0);
    exerciseSteps = round((1:nMonths) * (T/ nMonths) / dt);

    % Backward induction to calculate option price at the root
    for step = nStep:-1:1
        optionValues = B * (p * optionValues(1:step) + (1 - p) * optionValues(2:step + 1));
        if ismember(step, exerciseSteps)
            EEValues = max(tree(1:step, step) - K, 0);
            optionValues = max(optionValues, EEValues);
        end
    end

    optionPrice = optionValues(1);
end