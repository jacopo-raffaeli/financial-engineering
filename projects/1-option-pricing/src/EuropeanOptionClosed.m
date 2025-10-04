function optionPrice = EuropeanOptionClosed(S0, K, r, q, T, sigma, flag)
    % EuropeanOptionClosed computes the closed-form solution for European option
    % pricing using the Black-76 formula.

    % Inputs:
    %   F0    - Current forward price of the underlying asset
    %   K     - Strike price of the option
    %   B     - Discount factor
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option

    % Compute option price
    F0 = S0 * exp((r - q) * T);
    [callPrice, putPrice] = blkprice(F0, K, r, T, sigma);
    
    % Call option price
    if flag == 1
        optionPrice = callPrice;
    % Put option price
    elseif flag == -1
        optionPrice = putPrice;    
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

end