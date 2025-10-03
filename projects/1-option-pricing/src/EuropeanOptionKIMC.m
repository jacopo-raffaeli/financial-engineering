function optionPrice = EuropeanOptionKIMC(S0, K, KI, r, q, T, sigma, nSim, nStep)
    % EuropeanOptionKIMC computes the price of a European knock-in call 
    % option using Monte Carlo simulation.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   KI    - Knock-in barrier level
    %   r
    %   q
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of time steps in the simulation

    % Outputs:
    %   optionPrice - The computed price of the call option

    % Time increment
    dt = T / nStep;

    B = exp(-r * T);

    % Simulate the underlying asset price at maturity path-wise (for memory limitations)
    Smax = zeros(1, nSim);
    ST = zeros(1, nSim);
    for i= 1:nSim
        Z = randn(1, nStep);
        S = S0 * exp(cumsum((r - q - 0.5 * sigma^2) * dt + sigma * sqrt(dt) * Z, 2));
        Smax(i) = max(S);
        ST(i) = S(end);
    end

    % Check if the knock-in barrier was breached
    idxKI = Smax >= KI;
    payoffs = max(ST - K, 0) .* idxKI;

    % Discount the expected payoff to present value
    optionPrice = B * mean(payoffs);

end