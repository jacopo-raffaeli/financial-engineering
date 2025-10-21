function npv = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDisc, fixedRate, swapType)

    EUR_30_360 = 6;
    deltas = yearfrac([setDate, fixedLegPaymentDates(1:end - 1)], fixedLegPaymentDates, EUR_30_360);
    fixedLegNPV = fixedRate * sum(deltas .* fixedLegDisc);
    floatingLegNPV = 1 - fixedLegDisc(end);
    npv = swapType * (floatingLegNPV - fixedLegNPV); 

end

