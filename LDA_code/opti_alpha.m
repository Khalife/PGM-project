function alpha = opti_alpha(suff_stat, D, K)
    threshold = 10^(-5);

    a_init = 100;
    log_a = log(a_init);
    df = 10;
    while abs(df) > threshold
        a = exp(log_a);
        
        if isnan(a)
            a_init = 10 * a_init;
            a = a_init;
            log_a = log(a);
        end
        f = D*(log(gamma(K*a) - K * log(gamma(a))) + (a-1) * suff_stat);
        df = D * (K * log_deriv_gamma(K * a) - K * log_deriv_gamma(a)) + suff_stat;
        d2f = D * (K * K * trigamma(K * a) - K * trigamma(a));
        
        log_a = log_a - df / (d2f * a + df);
    end
    alpha = exp(log_a);
end