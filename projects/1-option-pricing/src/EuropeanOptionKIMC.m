function optionPrice = EuropeanOptionKIMC(F0, K, KI, B, T, sigma, N)
    % EuropeanOptionKIMC computes the price of a European knock-in call 
    % option using Monte Carlo simulation.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   KI    - Knock-in barrier level
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of time steps in the simulation

    % Outputs:
    %   optionPrice - The computed price of the call option

    % Time increment
    dt = T / N;

    % Simulate the underlying asset price at maturity
    nSim = 1e6;
    Z = randn(nSim, N);
    F = F0 * exp(cumsum(( -0.5 * sigma^2) * dt + sigma * sqrt(dt) * Z));
    F_T = F(end, :);

    % Check if the knock-in barrier was breached
    idxKI = any(F <= KI, 1);
    payoffs = max(F_T - K, 0) .* idxKI;

    % Discount the expected payoff to present value
    optionPrice = B * mean(payoffs);

end