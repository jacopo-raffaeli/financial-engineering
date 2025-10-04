function optionPrice = EuropeanOptionKICRR(S0, K, KI, r, q, T, sigma, nStep)
    % Computes the price of a European knock-in call option using the CRR
    % binomial tree method.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   KI    - Knock-in barrier level
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   nStep - Number of time steps in the binomial tree

    % Outputs:
    %   optionPrice - The computed price of the call option

    % Calculate parameters for the binomial tree

    % Time step
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

    % Check if the knock-out barrier was breached at maturity
    ST = tree(:, end);
    idxKI = ST <= KI;
    optionValues = max(ST - K, 0) .* idxKI;

    % Backward induction to calculate the equivalent knock-out option price
    B = exp(-r * dt);
    for step = nStep:-1:1
        idxKI = tree(1:step, step) <= KI;
        optionValues = B * (p * optionValues(1:step) + (1 - p) * optionValues(2:step + 1));
        optionValues = optionValues .* idxKI;
    end

    % Price of the knock-in by In-Out parity
    optionPrice = EuropeanOptionClosed(S0, K, r, q, T, sigma, 1) - optionValues(1);

end