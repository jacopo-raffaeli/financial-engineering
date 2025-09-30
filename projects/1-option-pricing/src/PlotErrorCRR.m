function [M, errorCRR] = PlotErrorCRR(F0, K, B, T, sigma)
    % PlotErrorCRR computes the absolute pricing errors of European option prices
    % using the Cox-Ross-Rubinstein (CRR) binomial model for increasing numbers of time steps.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   M        - Vector of number of time steps used in the CRR model
    %   errorCRR - Vector of absolute pricing errors between CRR and Black-76 prices
    
    % Initialize variables
    m = 1:10;
    M = 2.^m;
    errorCRR = zeros(length(M));
    optionType = 1;

    % Calculate the Black-76 price for reference
    optionPriceBLK = EuropeanOptionClosed(F0, K, B, T, sigma, optionType);

    for i = 1:length(M)
        % Compute the CRR option price with M time steps
        optionPriceCRR = EuropeanOptionCRR(F0, K, B, T, sigma, M(i), optionType);
        
        % Store price error
        errorCRR(i) = abs(optionPriceBLK - optionPriceCRR);
    end    
end