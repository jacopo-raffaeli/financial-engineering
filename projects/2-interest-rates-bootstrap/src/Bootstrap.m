function [dates, discounts] = Bootstrap(datesSet, ratesSet)

% Year fraction conventions
% Act/365 
Act365 = 3; 
% Act/360
Act360 = 2;
% Eur 30/360
Eur360 = 6; 

% Settlement data
settlementDate = datesSet.settlement;

% Depoist data
depositDates = dateSet.deposits;
depositRates = ratesSet.deposits;
depositRatesMid = mean(depositRates,2);

%% Initialize curve
dates = zeros()
dates = settlementDate;
discounts = 1;

%% Short curve
for i = 1:length(depositDates)
    T = depositDates(i);
    delta = yearfrac(settlementDate, T, Act360);
    L = depositRatesMid(i);
    P = 1 / (1 + delta * L);
    dates(end + 1) = T;
    discounts(end + 1) = P;
end