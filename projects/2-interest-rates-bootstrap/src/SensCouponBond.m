function macD = SensCouponBond(setDate, couponPaymentDates, fixedRate, dates, discounts)
    % Macaulay Duration for a coupon bond

    % Inputs:
    %   setDate              - valuation date (datetime)
    %   couponPaymentDates   - vector of coupon payment dates (datetime)
    %   fixedRate            - fixed coupon rate
    %   dates                - vector of discount curve dates (datetime)
    %   discounts            - vector of discount factors corresponding to 'dates'

    % Outputs:
    %   macD: Macaulay Duration

    % Year fraction conventions
    EUR_30_360 = 6;
    ACT_365 = 3;

    % Cash flows
    deltas = yearfrac([setDate, couponPaymentDates(1:end - 1)], couponPaymentDates, EUR_30_360);
    coupon = fixedRate * deltas;
    coupon(end) = coupon(end) + 1;

    % Discount factors for coupon payment dates
    couponDisc = interp1(dates, discounts, couponPaymentDates, 'linear', 'extrap');

    % Macaulay Duration
    tau = yearfrac(setDate, couponPaymentDates, ACT_365);
    pv = sum(coupon .* couponDisc); 
    macD = (sum(coupon .* tau .* couponDisc)) / pv;

end