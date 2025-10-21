function MacD = SensCouponBond(setDate, couponPaymentDates, fixedRate, dates, discounts)
    
    EUR_30_360 = 6;
    ACT_365 = 3;
    deltas = yearfrac([setDate, couponPaymentDates(1:end - 1)], couponPaymentDates, EUR_30_360);
    tau = yearfrac(setDate, couponPaymentDates, ACT_365);
    coupon = fixedRate * deltas;
    coupon(end) = coupon(end) + 1;
    couponDisc = interp1(dates, discounts, couponPaymentDates, 'linear', 'extrap');
    MacD = (sum(coupon .* tau .* couponDisc)) / (sum(coupon .* couponDisc));

    % IRR (solve for yield)
    f = @(y) sum(coupon .* exp(-y * tau)) - sum(coupon .* couponDisc);
    y = fzero(f, 0.03); 
    MacD = MacD / (1 + y);

end