function [DV01, BPV, DV01_z] = SensSwap(setDate, fixedLegPaymentDates, fixedRate, dates, discounts, discounts_DV01)
    % Sensitivity analysis for a swap

    % Inputs:
    %   setDate              - valuation date
    %   fixedLegPaymentDates - vector of payment dates for the fixed leg
    %   fixedRate            - fixed rate of the swap
    %   dates                - vector of dates corresponding to the discount factors
    %   discounts            - vector of discount factors
    %   discounts_DV01       - vector of discount factors shifted for DV01 calculation

    % Outputs:
    %   DV01                 - Dollar Value of a Basis Point
    %   BPV                  - Basis Point Value
    %   DV01_z               - DV01 calculated using zero rates

    % Year fraction conventions
    EUR_30_360 = 6;
    ACT_365 = 3;

    % Basis point
    bps = 0.0001;

    % Swap type: -1 for receiver swap
    swapType = -1;
    
    % DV01 using discount factors
    fixedLegDisc = interp1(dates, discounts, fixedLegPaymentDates, 'linear', 'extrap');
    npv = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDisc, fixedRate, swapType);
    fixedLegDiscShift = interp1(dates, discounts_DV01, fixedLegPaymentDates, 'linear', 'extrap');
    npvShift = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDiscShift, fixedRate, swapType);
    DV01 = abs(npv - npvShift);

    % BPV
    deltas = yearfrac([setDate, fixedLegPaymentDates(1:end - 1)], fixedLegPaymentDates, EUR_30_360);
    BPV = sum(deltas .* fixedLegDisc) * bps;

    % DV01 using zero rates
    fixedLegDisc = interp1(dates, discounts, fixedLegPaymentDates, 'linear', 'extrap');
    npv = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDisc, fixedRate, swapType);
    fixedLegDiscShift =  fixedLegDisc .* exp(-bps * yearfrac(setDate, fixedLegPaymentDates, ACT_365));
    npvShift = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDiscShift, fixedRate, swapType);
    DV01_z = abs(npv - npvShift);

end