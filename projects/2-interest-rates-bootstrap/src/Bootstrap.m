function [dates, discounts] = Bootstrap(datesSet, ratesSet)
    % Bootstrap constructs a discount curve using deposits, futures, and swaps.

    % Inputs:
    %   datesSet  - A structure containing date vectors for settlement, deposits,
    %                futures, and swaps.
    %   ratesSet  - A structure containing rate matrices for deposits, futures,
    %                and swaps.

    % Outputs:
    %   dates     - A vector of dates for the discount curve
    %   discounts - A vector of discount factors corresponding to the dates

    %% Year fraction conventions
    ACT_365 = 3; 
    ACT_360 = 2;
    EUR_30_360 = 6; 

    %% Input data
    % Settlement
    settleDate = datesSet.settlement;
    settleDF = 1;

    % Deposits
    depoDates = datesSet.deposits;
    depoRates = mean(ratesSet.deposits, 2);

    % STIR Futures
    futDates = datesSet.futures;
    futRates = mean(ratesSet.futures, 2);

    % Swaps
    swapDates = datesSet.swaps;
    swapRates = mean(ratesSet.swaps, 2);

    % Instrument counts
    % Consider deposits up to the first future start date
    numDepo = sum(depoDates <= futDates(1,1));
    % Consider first 7 futures only (most liquid ones)
    numFut  = 7;
    % Consider swaps from last future end date onwards
    numSwap = sum(swapDates >= futDates(numFut,2));

    %% Initialize curve
    curveLength = 1 + numDepo + numFut + numSwap;

    dates = NaT(curveLength, 1);
    discounts = zeros(curveLength, 1);

    dates(1) = settleDate;
    discounts(1) = settleDF;

    %% Short end (Deposits)
    for i = 1:numDepo
        endDate = depoDates(i);
        depoRate = depoRates(i);
        delta = yearfrac(settleDate, endDate, ACT_360);
        df = 1 / (1 + delta * depoRate);
        dates(i + 1) = endDate;
        discounts(i + 1) = df;
    end

    %% Middle end (STIR Futures)
    for i = 1:numFut
        startDate = futDates(i, 1);
        endDate = futDates(i, 2);
        futRate = futRates(i);
        delta = yearfrac(startDate, endDate, ACT_360);
        dfForward = 1 / (1 + delta * futRate);

        knownDates = dates(2:i + numDepo);
        knownRates = -log(discounts(2:i + numDepo)) ./ yearfrac(settleDate, knownDates, ACT_365);
        zStart = interp1(knownDates, knownRates, startDate, 'linear', 'extrap');
        dfStart = exp(-zStart * yearfrac(settleDate, startDate, ACT_365));

        dfEnd = dfStart * dfForward;
        dates(i + 1 + numDepo) = endDate;
        discounts(i + 1 + numDepo) = dfEnd;
    end

    %% Long end (Swaps)
    for i = 2:(numSwap + 1)
        swapMat = swapDates(i);
        swapRate = swapRates(i);

        payDates = swapDates(1:i);
        deltaPay = yearfrac([settleDate; payDates(1:end - 1)], payDates, EUR_30_360);

        knownDates = dates(2:i + numDepo + numFut - 1);
        knownRates = -log(discounts(2:i + numDepo + numFut - 1)) ./ yearfrac(settleDate, knownDates, ACT_365);

        interpRates = interp1(knownDates, knownRates, payDates(1:end - 1), 'linear', 'extrap');
        payDF = exp(-interpRates .* yearfrac(settleDate, payDates(1:end - 1), ACT_365));

        bpv = sum(deltaPay(1:end - 1) .* payDF);
        dfMat = (1 - swapRate * bpv) / (1 + deltaPay(end) * swapRate);

        dates(i + numDepo + numFut) = swapMat;
        discounts(i + numDepo + numFut) = dfMat;
    end

end
