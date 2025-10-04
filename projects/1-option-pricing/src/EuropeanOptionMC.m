function [optionPrice, std] = EuropeanOptionMC(S0, K, r, q, T, sigma, nSim, flag) 
    % Computes the price of a European option using Monte Carlo simulation.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of simulations
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option
    %   std         - The standard error of the MC estimate

    % Generate N standard normal random variables
    Z = randn(nSim, 1);

    % Compute forward price
    F0 = S0 * exp((r - q) * T);

    % Simulate the underlying asset price at maturity
    FT = F0 * exp(( - 0.5 * sigma^2) * T + sigma * sqrt(T) * Z);

    % Compute the payoffs
    % Call option payoff
    if flag == 1
        payoffs = max(FT - K, 0);
    % Put option payoff 
    elseif flag == -1
        payoffs = max(K - FT, 0);
    % Invalid flag 
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

    % Discount factor
    B = exp(-r * T);

    % Discount the average payoff back to present value
    optionPrice = B * mean(payoffs);

    % Compute variance and standard deviation of the payoffs
    var = (1/(nSim*(nSim-1)))*sum((payoffs - mean(payoffs)).^2);
    std = sqrt(var);

end