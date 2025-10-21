function [DV01, BPV, DV01_z] = SensSwap(setDate, fixedLegPaymentDates, fixedRate, dates, discounts, discounts_DV01)
    
    EUR_30_360 = 6;
    ACT_365 = 3;
    swapType = -1;
    bps = 1e-4;
    
    % DV01
    fixedLegDisc = interp1(dates, discounts, fixedLegPaymentDates, 'linear', 'extrap');
    npv = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDisc, fixedRate, swapType);
   
    fixedLegDiscShift = interp1(dates, discounts_DV01, fixedLegPaymentDates, 'linear', 'extrap');
    npvShift = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDiscShift, fixedRate, swapType);

    DV01 = abs(npv - npvShift);

    % BPV
    deltas = yearfrac([setDate, fixedLegPaymentDates(1:end - 1)], fixedLegPaymentDates, EUR_30_360);
    BPV = sum(deltas .* fixedLegDisc) * bps;

    % DV01 zero rates    
    fixedLegDisc = interp1(dates, discounts, fixedLegPaymentDates, 'linear', 'extrap');
    npv = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDisc, fixedRate, swapType);

    fixedLegDiscShift =  fixedLegDisc .* exp(-bps * yearfrac(setDate, fixedLegPaymentDates, ACT_365));
    npvShift = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDiscShift, fixedRate, swapType);

    DV01_z = abs(npv - npvShift);

end