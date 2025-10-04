function [nSim, stdEstim] = PlotErrorMC(S0, K, r, q, T, sigma)
    % Computes the absolute pricing errors of European option prices using the 
    % MC model for increasing numbers of simulations.

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
    nSim = 2.^m;
    stdEstim = zeros(1, length(nSim));

    for i = 1:length(nSim)
        % Compute the CRR option price with M time steps
        [~, std] = EuropeanOptionMC(S0, K, r, q, T, sigma, nSim(i), 1);
        
        % Store price error
        stdEstim(i) = std;
    end    
    
end    