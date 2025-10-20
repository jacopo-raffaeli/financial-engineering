function [DV01, BPV, DV01_z] = SensSwap(setDate, fixedLegPaymentDates, fixedRate, dates, discounts, discounts_DV01)
    
    EUR_30_360 = 6;
    ACT_365 = 3;
    deltas = yearfrac([setDate, fixedLegPaymentDates(1:end - 1)], fixedLegPaymentDates, EUR_30_360);
    
    % DV01
    fixedLegDisc = interp1(dates, discounts, fixedLegPaymentDates, 'linear', 'extrap');
    fixedLegNPV = fixedRate * sum(deltas .* fixedLegDisc);
    floatingLegNPV = 1 - fixedLegDisc(end);
    npv = fixedLegNPV - floatingLegNPV; 

    fixedLegDiscShift = interp1(dates, discounts_DV01, fixedLegPaymentDates, 'linear', 'extrap');
    fixedLegNPVShift = fixedRate * sum(deltas .* fixedLegDiscShift);
    floatingLegNPVShift = 1 - fixedLegDiscShift(end);
    npvShift = fixedLegNPVShift - floatingLegNPVShift;

    DV01 = abs(npv - npvShift);

    % BPV
    BPV = sum(deltas .* fixedLegDisc) * 1e-4;

    % DV01 zero rates    
    fixedLegZeroRates = - log(fixedLegDisc) ./ yearfrac(setDate, fixedLegPaymentDates, ACT_365);
    fixedLegDiscShift = exp(-(fixedLegZeroRates + 1e-4) .* yearfrac(setDate, fixedLegPaymentDates, ACT_365));
    fixedLegNPVShift = fixedRate * sum(deltas .* fixedLegDiscShift);
    floatingLegNPVShift = 1 - fixedLegDiscShift(end);
    npvShift = fixedLegNPVShift - floatingLegNPVShift;

    DV01_z = abs(npv - npvShift);

end