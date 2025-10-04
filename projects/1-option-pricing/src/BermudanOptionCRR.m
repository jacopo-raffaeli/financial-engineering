function optionPrice = BermudanOptionCRR(S0, K, r, q, T, sigma, nStepPerMonth) 
    % Computes the price of a Bermudan call option using the
    % Cox-Ross-Rubinstein (CRR) binomial tree model.

    % Inputs:
    %   S0            - Current spot price of the underlying asset
    %   K             - Strike price of the option
    %   r             - Risk-free interest rate (annualized)
    %   q             - Continuous dividend yield (annualized)
    %   T             - Time to maturity (in years)
    %   sigma         - Volatility of the underlying asset (annualized)
    %   nStepPerMonth - Number of steps per month in the binomial tree

    % Outputs:
    %   optionPrice - The computed price of the call option

    % Calculate parameters for the binomial tree

    % Time step
    nMonths = floor(T * 12);
    nStep = nMonths * nStepPerMonth;
    dt = T / nStep;

    % Up and down factors
    u = exp(sigma * sqrt(dt));
    d = 1 / u;
    
    % Risk-neutral up probability
    a = exp((r - q) * dt);
    p = (a - d) / (u - d);
    
    % Compute forward tree
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
    optionValues = max(ST - K, 0);

    % Discount factor
    B = exp(-r * dt);

    % Determine exercise steps (monthly)
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