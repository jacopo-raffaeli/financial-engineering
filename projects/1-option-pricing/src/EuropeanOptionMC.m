function optionPrice = EuropeanOptionMC(F0, K, B, T, sigma, N, flag) 
    % EuropeanOptionMC computes the price of a European option using Monte Carlo simulation.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Annualized continuously compounded risk-free rate of return over life of the option
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   N     - Number of simulations
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option

    % Generate N standard normal random variables
    Z = randn(N, 1);

    % Simulate the underlying asset price at maturity
    FT = F0 * exp((B - 0.5 * sigma^2) * T + sigma * sqrt(T) * Z);

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
    optionPrice = exp(-B * T) * mean(payoffs);
    
end