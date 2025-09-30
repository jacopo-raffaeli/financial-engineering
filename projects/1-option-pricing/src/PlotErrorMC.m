function [M, stdEstim] = PlotErrorMC(F0, K, B, T, sigma)
    % PlotErrorMC computes the standard deviation estimates of European option prices
    % using the Monte Carlo method for increasing numbers of simulations.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   M        - Vector of number of Monte Carlo simulations 
    %   stdEstim - Vector of standard deviation estimates from Monte Carlo simulations

    % Initialize variables
    m = 1:20;
    M = 2.^m;
    stdEstim = zeros(length(M));
    optionType = 1;

    for i = 1:length(M)
        % Compute the CRR option price with M time steps
        [~, std] = EuropeanOptionMC(F0, K, B, T, sigma, M(i), optionType);
        
        % Store price error
        stdEstim(i) = std;
    end    
end    