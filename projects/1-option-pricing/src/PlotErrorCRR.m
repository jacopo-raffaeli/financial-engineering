function [nStep, errorCRR] = PlotErrorCRR(S0, K, r, q, T, sigma)
    % Computes the absolute pricing errors of European option prices using the 
    % Cox-Ross-Rubinstein binomial model for increasing numbers of time steps.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)

    % Outputs:
    %   nStep    - Vector of number of time steps used in the CRR model
    %   errorCRR - Vector of absolute pricing errors 
    
    % Initialize variables
    m = 1:10;
    nStep = 2.^m;
    errorCRR = zeros(1, length(nStep));

    % Calculate the Black-76 price for reference
    optionPriceBLK = EuropeanOptionClosed(S0, K, r, q, T, sigma, optionType);

    for i = 1:length(nStep)
        % Compute the CRR option price with M time steps
        optionPriceCRR = EuropeanOptionCRR(S0, K, r, q, T, sigma, nStep(i), 1);
        
        % Store price error
        errorCRR(i) = abs(optionPriceBLK - optionPriceCRR);
    end    
    
end