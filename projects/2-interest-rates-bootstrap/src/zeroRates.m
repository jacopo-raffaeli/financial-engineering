function zRates = ZeroRates(dates, discounts)

    ACT_365 = 3;
    settleDate = dates(1);
    deltas = yearfrac(settleDate, dates(2:end), ACT_365);
    zRates = -log(discounts(2:end)) ./ deltas;
    zRates = [0; zRates];