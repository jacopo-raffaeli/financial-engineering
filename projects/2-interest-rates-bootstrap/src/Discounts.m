function discounts = Discounts(dates, zeroRates)

    ACT_365 = 3;
    settleDate = dates(1);
    deltas = yearfrac(settleDate, dates(2:end), ACT_365);
    discounts = exp(-zeroRates(2:end) .* deltas);
    discounts = [1; discounts];