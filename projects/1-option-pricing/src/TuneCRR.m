function nStep = TuneCRR(S0, K, r, q, T, sigma, flag)
    % Determines the number of time steps required in the Cox-Ross-Rubinstein 
    % binomial tree model to achieve an option price within a specified error 
    % tolerance compared to the Black-76 price.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   nStep- The number of time steps required in the CRR model

    % Initialize variables
    m = 0;
    nStep = 0; 
    tol = 1e-4;
    maxIt = 10; 
    it = 0;
    err = Inf;

    % Compute the Black-76 price for reference
    optionPriceBLK = EuropeanOptionClosed(S0, K, r, q, T, sigma, flag);

    % Iterate to find the required number of time steps
    while err > tol && it < maxIt
        % Increment the number of time steps
        m = m + 1;
        nStep = 2^m;

        % Compute the CRR option price with M time steps
        optionPriceCRR = EuropeanOptionCRR(S0, K, r, q, T, sigma, nStep, flag);

        % Calculate the absolute price difference
        err = abs(optionPriceBLK - optionPriceCRR);

        % Increment iteration counter
        it = it + 1;
    end

    % Check if maximum iterations were reached
    if it >= maxIt
        warning('Maximum iterations reached without achieving desired tolerance.\n');
    end

    % Display results
    fprintf('CRR tuned steps: %d \nBlack-76 Price: %.4f € \nCRR Price: %.4f € \nError: %.6f\n', ...
            nStep, optionPriceBLK, optionPriceCRR, err);

end