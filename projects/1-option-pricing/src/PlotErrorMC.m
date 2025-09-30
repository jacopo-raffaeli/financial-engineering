function [M, stdEstim] = PlotErrorMC(F0, K, B, T, sigma)
    % 

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   M        - 
    %   stdEstim -

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