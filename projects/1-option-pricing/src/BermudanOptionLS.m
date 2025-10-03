function optionPrice = BermudanOptionLS(S0, K, r, q, T, sigma)
    % EuropeanOptionKIClosed computes the price of a European knock-in call 
    % option using Monte Carlo simulation.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   KI    - Knock-in barrier level
    %   r
    %   q
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)

    % Outputs:
    %   optionPrice - The computed price of the call option
    
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

    % Exercise dates
    ExerciseDates = (Settle + calmonths(1:round(T * 12)));   

    % Price the option
    optionPrice = optstockbyls(RateSpec, StockSpec, OptSpec, K, Settle, ExerciseDates, 'NumTrials', 1e3, 'NumPeriods', 1e3, 'Antithetic', true);
end

    