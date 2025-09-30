function M = TuneCRR(F0, K, B, T, sigma, flag)
    % tuneCRR determines the number of time steps (M) required in the
    % Cox-Ross-Rubinstein (CRR) binomial tree model to achieve an
    % option price within a specified error tolerance (1bsp) compared to the 
    % Black-76 price.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   M - The number of time steps required in the CRR model

    % Initialize variables
    m = 0;
    M = 0; 
    tol = 1e-4;
    maxIt = 10; 
    it = 0;
    err = Inf;

    % Calculate the Black-76 price for reference
    optionPriceBLK = EuropeanOptionClosed(F0, K, B, T, sigma, flag);

    % Iterate to find the required number of time steps
    while err > tol && it < maxIt
        % Increment the number of time steps
        m = m + 1;
        M = 2^m;

        % Compute the CRR option price with M time steps
        optionPriceCRR = EuropeanOptionCRR(F0, K, B, T, sigma, M, flag);

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
    fprintf('CRR steps: %d \nBlack-76 Price: %.4f € \nCRR Price: %.4f € \nError: %.6f\n', ...
            M, optionPriceBLK, optionPriceCRR, err);

end