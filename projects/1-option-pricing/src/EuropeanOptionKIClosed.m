function optionPrice = EuropeanOptionKIClosed(S0, K, KI, r, q, T, sigma)
    % Computes the price of a European knock-in call option using the
    % closed-form solution based on the Black-Scholes model.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   KI    - Knock-in barrier level
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)

    % Outputs:
    %   optionPrice - The computed price of the call option
    
    % Dummy Settle and Maturity dates
    Settle   = datetime(0,1,1);        
    Maturity = Settle + calmonths(round(T*12));   
    
    % Rate specification
    RateSpec = intenvset('ValuationDate', Settle, ...
                         'StartDates',    Settle, ...
                         'EndDates',      Maturity, ...
                         'Rates',         r, ...
                         'Compounding',   -1, ...
                         'Basis',         0);
    
    % Stock specification
    StockSpec = stockspec(sigma, S0, 'Continuous', q);
    
    % Option specification
    OptSpec = 'call';
    BarrierSpec = 'UI';
    
    % Price the option
    optionPrice = barrierbybls(RateSpec, StockSpec, OptSpec, K, Settle, Maturity, BarrierSpec, KI);
    
end

    