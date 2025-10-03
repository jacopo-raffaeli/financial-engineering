function [optionPrice, std] = EuropeanOptionMCAV(F0, K, B, T, sigma, N, flag) 
    % EuropeanOptionMC computes the price of a European option using Monte Carlo simulation.

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
    Z = randn(N, 1);

    % Simulate the underlying asset price at maturity
    FT1 = F0 * exp(( - 0.5 * sigma^2) * T + sigma * sqrt(T) * Z);
    FT2 = F0 * exp(( - 0.5 * sigma^2) * T + sigma * sqrt(T) * -Z);

    % Calculate the payoff for each simulation
    if flag == 1
        % Call option payoff
        payoffs1 = max(FT1 - K, 0); 
        payoffs2 = max(FT2 - K, 0);
    elseif flag == -1
        % Put option payoff
        payoffs1 = max(K - FT1, 0); 
        payoffs2 = max(K - FT2, 0);
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

    % Discount the average payoff back to present value
    payoffs = (payoffs1 + payoffs2) / 2;
    optionPrice = B * mean(payoffs);

    % Compute variance and standard deviation of the payoffs
    var = (1/(N*(N-1)))*sum((payoffs - mean(payoffs)).^2);
    std = sqrt(var);

end