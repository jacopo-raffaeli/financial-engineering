function optionPrice = EuropeanOptionKIMC(S0, K, KI, r, q, T, sigma, N)
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
    dt = T / N;

    B = exp(-r * T);

    % Simulate the underlying asset price at maturity
    nSim = 1e5;
    Z = randn(nSim, N);
    F = S0 * exp(cumsum((r - q - 0.5 * sigma^2) * dt + sigma * sqrt(dt) * Z, 2));
    FT = F(:, end);

    % Check if the knock-in barrier was breached
    idxKI = max(F,[],2) >= KI;
    payoffs = max(FT - K, 0) .* idxKI;

    % Discount the expected payoff to present value
    optionPrice = B * mean(payoffs);

end