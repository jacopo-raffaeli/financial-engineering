function zRates = ZeroRates(dates, discounts)
    % Compute zero rates from discount factors

    % Inputs:
    %   dates     - vector of dates (datetime)
    %   discounts - vector of discount factors corresponding to the dates

    % Outputs:
    %   zRates    - vector of zero rates corresponding to the dates

    % Year fraction conventions
    ACT_365 = 3;

    % Compute zero rates
    settleDate = dates(1);
    deltas = yearfrac(settleDate, dates(2:end), ACT_365);
    zRates = -log(discounts(2:end)) ./ deltas;
    zRates = [0; zRates];

end