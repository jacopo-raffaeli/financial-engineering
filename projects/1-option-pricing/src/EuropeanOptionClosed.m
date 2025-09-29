function optionPrice = EuropeanOptionClosed(F0, K, B, T, sigma, flag)
    % EuropeanOptionClosed computes the closed-form solution for European option pricing
    % using the Black-Scholes formula.

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
    r = -log(B)/T;
    [callPrice, putPrice] = blkprice(F0, K, r, T, sigma);
    
    % Select the appropriate price based on the flag
    if flag == 1
        % Call option price
        optionPrice = callPrice;
    elseif flag == -1
        % Put option price
        optionPrice = putPrice;
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

end