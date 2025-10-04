function optionPrice = EuropeanOptionClosed(S0, K, r, q, T, sigma, flag)
    % Computes the closed-form solution for European option
    % pricing using the Black-76 formula.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   flag  - '+1' for call option, '-1' for put option

    % Outputs:
    %   optionPrice - The computed price of the European option

    % Compute forward price
    F0 = S0 * exp((r - q) * T);
    
    % Compute option price
    [callPrice, putPrice] = blkprice(F0, K, r, T, sigma);
    
    % Call option price
    if flag == 1
        optionPrice = callPrice;
    % Put option price
    elseif flag == -1
        optionPrice = putPrice; 
    % Invalid flag   
    else
        error('Invalid flag. Use +1 for call option and -1 for put option.');
    end

end