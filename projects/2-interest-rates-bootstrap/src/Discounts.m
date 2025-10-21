function discounts = Discounts(dates, zeroRates)
    % Discounts calculates the discount factors for a given set of dates
    % and corresponding zero rates.

    % Inputs:
    %   dates     - A vector of dates (datetime)
    %   zeroRates - A vector of zero rates (numeric)

    % Outputs:
    %   discounts - A vector of discount factors (numeric)

    % Year fraction convention
    ACT_365 = 3;

    % Calculate discount factors
    settleDate = dates(1);
    deltas = yearfrac(settleDate, dates(2:end), ACT_365);
    discounts = exp(-zeroRates(2:end) .* deltas);
    discounts = [1; discounts];