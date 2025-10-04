function optionPrice = BermudanOptionCRRExact(S0, K, r, q, T, sigma, nStep)
    % Computes the price of a Bermudan call option using the
    % Cox-Ross-Rubinstein (CRR) binomial tree model from Financial Toolbox.

    % Inputs:
    %   S0    - Current spot price of the underlying asset
    %   K     - Strike price of the option
    %   r     - Risk-free interest rate (annualized)
    %   q     - Continuous dividend yield (annualized)
    %   T     - Time to maturity (in years)
    %   sigma - Volatility of the underlying asset (annualized)
    %   nStep - Number of steps in the binomial tree

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

    % Time specification
    TimeSpec = crrtimespec(Settle, Maturity, nStep);

    % Construct CRR binomial tree
    Tree = crrtree(StockSpec, RateSpec, TimeSpec);
    
    % Option specification
    OptSpec = 'call';

    % Exercise dates
    ExerciseDates = (Settle + calmonths(1:round(T * 12)));   

    % Price the option
    optionPrice = optstockbycrr(Tree, OptSpec, K, Settle, ExerciseDates);
    
end

    