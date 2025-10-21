function npv = SwapNPV(setDate, fixedLegPaymentDates, fixedLegDisc, fixedRate, swapType)
    % SwapNPV computes the NPV of a plain vanilla interest rate swap

    % Inputs:
    %   setDate              - valuation date (datetime)
    %   fixedLegPaymentDates - vector of datetime objects for fixed leg payment dates
    %   fixedLegDisc         - vector of discount factors corresponding to fixed leg payment dates
    %   fixedRate            - fixed interest rate of the swap
    %   swapType             - +1 for payer swap, -1 for receiver swap

    % Outputs:
    %   npv                  - net present value of the swap

    % Year fraction conventions
    EUR_30_360 = 6;

    % Compute the NPV
    deltas = yearfrac([setDate, fixedLegPaymentDates(1:end - 1)], fixedLegPaymentDates, EUR_30_360);
    fixedLegNPV = fixedRate * sum(deltas .* fixedLegDisc);
    floatingLegNPV = 1 - fixedLegDisc(end);
    npv = swapType * (floatingLegNPV - fixedLegNPV); 

end

