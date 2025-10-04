function [optionPrice, std] = EuropeanOptionMC(S0, K, r, q, T, sigma, nSim, flag) 
    % EuropeanOptionMC computes the price of a European option using Monte Carlo
    % simulation.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of simulations
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option
    %   std         - The standard error of the MC estimate

    % Generate N standard normal random variables
    Z = randn(1, nSim);

    % Simulate the underlying asset price at maturity
    F0 = S0 * exp((r - q) * T);
    FT = F0 * exp(( - 0.5 * sigma^2) * T + sigma * sqrt(T) * Z);

    % Calculate the payoff for each simulation
    if flag == 1
        % Call option payoff
        payoffs = max(FT - K, 0); 
    elseif flag == -1
        % Put option payoff
        payoffs = max(K - FT, 0); 
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

    % Discount the average payoff back to present value
    B = exp(-r * T);
    optionPrice = B * mean(payoffs);

    % Compute variance and standard deviation of the payoffs
    var = (1/(nSim*(nSim-1)))*sum((payoffs - mean(payoffs)).^2);
    std = sqrt(var);

end