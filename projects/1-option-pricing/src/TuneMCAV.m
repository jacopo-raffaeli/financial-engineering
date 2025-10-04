function nSim = TuneMCAV(S0, K, r, q, T, sigma, flag)
    % tuneMC determines the number of simulations (M) required in the
    % MC model to achieve an option price within a specified error 
    % tolerance (1bsp) measuered as the standard error of the MC estimate.
    
    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   M - The number of simulations required in the MC model

    % Initialize variables
    m = 0;
    nSim = 0; 
    tol = 1e-4;
    maxIt = 20; 
    it = 0;
    err = Inf;

    % Calculate the Black-76 price for reference
    optionPriceBLK = EuropeanOptionClosed(S0, K, r, q, T, sigma, flag);

    % Iterate to find the required number of time steps
    while err > tol && it < maxIt
        % Increment the number of time steps
        m = m + 1;
        nSim = 2^m;

        % Compute the MC option price with M simulations and its standard error
        [optionPriceMC, err] = EuropeanOptionMCAV(S0, K, r, q, T, sigma, nSim, flag);        

        % Increment iteration counter
        it = it + 1;
    end

    % Check if maximum iterations were reached
    if it >= maxIt
        warning('Maximum iterations reached without achieving desired tolerance.\n');
    end

    % Display results
    fprintf('MC AV steps: %d \nBlack-76 Price: %.4f € \nMC AV Price: %.4f € \nError: %.6f\n', ...
            nSim, optionPriceBLK, optionPriceMC, err);

end