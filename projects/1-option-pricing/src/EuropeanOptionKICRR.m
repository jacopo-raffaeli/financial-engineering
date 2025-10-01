function optionPrice = EuropeanOptionKICRR(S0, K, KI, r, q, T, sigma, N)
    % EuropeanOptionKICRR computes the price of a European knock-in call 
    % option using Monte Carlo simulation.

    % Inputs:
    %   F0        - Current forward price of the underlying asset
    %   K         - Strike price of the option
    %   KI        - Knock-in barrier level
    %   B         - Discount factor
    %   T         - Time to maturity (in years)
    %   sigma     - Volatility of the underlying asset (annualized)
    %   nStep     - Number of time steps in the simulation

    % Outputs:
    %   optionPrice - The computed price of the call option

    % Calculate parameters for the binomial tree
    % Time step
    dt = T / N;
    % Up and down factors
    u = exp(sigma * sqrt(dt));
    d = 1 / u;
    % Risk-neutral probability
    a = exp((r - q) * dt);
    p = (a - d) / (u - d);
    
    % Compute asset prices
    tree = zeros(N+1,N+1);
    tree(1,1) = S0;
    for i = 1:N
        S = S0 * u.^(i:-2:-i);
        for j = 1:i+1
            tree(j,i+1) = S(j);
        end
    end

    % Check if the knock-out barrier was breached
    ST = tree(:, end);
    idxKI = ST <= KI;
    optionValues = max(ST - K, 0) .* idxKI;

    % Backward induction to calculate option price at the root
    for step = N:-1:1
        idxKI = tree(1:step, step) <= KI;
        optionValues = (p * optionValues(1:step) + (1 - p) * optionValues(2:step + 1));
        optionValues = optionValues .* idxKI;
    end

    B = exp(-r * T);
    optionPrice = EuropeanOptionClosed(S0*exp((r-q)*T), K, B, T, sigma, 1) - B * optionValues(1);
end