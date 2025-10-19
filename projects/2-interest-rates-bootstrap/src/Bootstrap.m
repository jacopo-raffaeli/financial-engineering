function [dates, discounts] = Bootstrap(datesSet, ratesSet)

%% Year fraction conventions
% Act/365 
Act365 = 3; 
% Act/360
Act360 = 2;
% Eur 30/360
Eur360 = 6; 

%% Input data
% Settlement data
settlementDate = datesSet.settlement;
settlementRate = 1;

% Deposit data
depositDates = datesSet.deposits;
depositRates = mean(ratesSet.deposits, 2);

% STIR Futures data
futureDates = datesSet.futures;
futureRates = mean(ratesSet.futures, 2);

% Swap data
swapDates = datesSet.swaps;
swapRates = mean(ratesSet.swaps, 2);

%% Initialize curve
depositNum = sum(depositDates <= futureDates(1,1));
futureNum = sum(futureDates(:,2) <= swapDates(2));
swapNum = numel(swapDates) - 1;
curveLength = 1 + depositNum + futureNum + swapNum;

dates = NaT(curveLength, 1);
discounts = zeros(curveLength, 1);

dates(1) = settlementDate;
discounts(1) = settlementRate;

%% Short curve

% ...
for i = 1:depositNum
    T = depositDates(i);
    L = depositRates(i);
    delta = yearfrac(settlementDate, T, Act360);
    B = 1 / (1 + delta * L);
    dates(i + 1) = T;
    discounts(i + 1) = B;
end

%% Middle curve

% ...
for i = 1:futureNum
    T = futureDates(i, 1);
    S = futureDates(i, 2);
    L = futureRates(i);
    delta = yearfrac(T, S, Act360);
    B_T_S = 1 / (1 + delta * L);
    date1 = dates(i + depositNum - 1);
    date2 = dates(i + depositNum);
    zrate1 = -log(discounts(i + depositNum - 1)) / yearfrac(settlementDate, date1, Act365);
    zrate2 = -log(discounts(i + depositNum)) / yearfrac(settlementDate, date2, Act365);
    z_T = interp1([date1, date2], [zrate1, zrate2], T, 'linear', 'extrap'); 
    B_T = exp(-z_T * yearfrac(settlementDate, T, Act365));
    B_S = B_T * B_T_S;
    dates(i + 1 + depositNum) = S;
    discounts(i + 1 + depositNum) = B_S;
end

%% Long curve

% ...
for i = 2:(swapNum + 1)
    S = swapDates(i);
    c = swapRates(i);
    payDates = swapDates(1:i);
    deltas = yearfrac([settlementDate; payDates(1:end - 1)], payDates, Eur360);
    zdates = dates(2:i + depositNum + futureNum - 1);
    zrates = -log(discounts(2:i + depositNum + futureNum - 1)) ./ yearfrac(settlementDate, zdates, Act365);
    payRates = interp1(zdates, zrates, payDates(1:end - 1), 'linear', 'extrap');
    payB = exp(-payRates .* yearfrac(settlementDate, payDates(1:end - 1), Act365));
    BPV = sum(deltas(1:end - 1) .* payB);
    B_S = (1 - c * BPV) / (1 + deltas(end) * c);
    dates(i + depositNum + futureNum) = S;
    discounts(i + depositNum + futureNum) = B_S;
end

end
