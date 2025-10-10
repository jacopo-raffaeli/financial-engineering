function [dates, rates] = readExcelData(filename, dateFormat)
% Reads financial market data from an Excel file using modern MATLAB functions.
% All input rates are expressed in percentage units.

% INPUTS:
%   filename   - Excel file name where data are stored
%   dateFormat - date format used in Excel (e.g., 'dd/MM/yyyy')

% OUTPUTS:
%   dates - struct with fields:
%       settlement   : settlement date
%       deposits     : deposit end dates
%       futures      : [n x 2] matrix of futures start and end dates
%       swaps        : swap expiry dates
%   rates - struct with fields:
%       deposits     : deposit bid/ask rates
%       futures      : futures bid/ask implied rates
%       swaps        : swap bid/ask rates

% Dates from Excel

% Settlement date
settlementCell = readcell(filename, 'Sheet', 1, 'Range', 'E8');
dates.settlement = datetime(settlementCell{1}, 'InputFormat', dateFormat);

% Deposit dates
depositDatesCell = readcell(filename, 'Sheet', 1, 'Range', 'D11:D18');
dates.deposits = datetime([depositDatesCell{:}], 'InputFormat', dateFormat);

% Futures start and end dates
futuresDatesCell = readcell(filename, 'Sheet', 1, 'Range', 'Q12:R20');
numFutures = size(futuresDatesCell, 1);
dates.futures = NaT(numFutures, 2);
for i = 1:numFutures
    dates.futures(i, 1) = datetime(futuresDatesCell{i, 1}, 'InputFormat', dateFormat);
    dates.futures(i, 2) = datetime(futuresDatesCell{i, 2}, 'InputFormat', dateFormat);
end

% Swap expiry dates
swapDatesCell = readcell(filename, 'Sheet', 1, 'Range', 'D39:D88');
dates.swaps = datetime([swapDatesCell{:}], 'InputFormat', dateFormat);

% Rates from Excel (Bids & Asks)

% Deposit rates
depositRates = readmatrix(filename, 'Sheet', 1, 'Range', 'E11:F18');
rates.deposits = depositRates / 100;

% Futures implied rates
futuresRates = readmatrix(filename, 'Sheet', 1, 'Range', 'E28:F36');
futuresRates = 100 - futuresRates;
rates.futures = futuresRates / 100;

% Swap rates
swapRates = readmatrix(filename, 'Sheet', 1, 'Range', 'E39:F88');
rates.swaps = swapRates / 100;

end
