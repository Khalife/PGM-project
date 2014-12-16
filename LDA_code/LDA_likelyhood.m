function ll = LDA_likelyhood(model,log_phi,var_gamma,document)
    ll = log(gamma(sum(model.alpha))) - log(gamma(sum(var_gamma)));
    
    for i=1:model.K
        diff_digamma = (log_deriv_gamma(var_gamma(i)) - log_deriv_gamma(sum(var_gamma)));
        ll = ll - log(gamma(model.alpha(i))) + (model.alpha(i) - var_gamma(i)) * diff_digamma + ...
            log(gamma(var_gamma(i)));
        for j=1:document.nb_word;
            ll = ll - exp(log_phi(i,j)) * log_phi(i,j) + exp(log_phi(i,j)) * diff_digamma + ...
                exp(log_phi(i,j)) * model.log_beta(i,document.words(j));
        end
    end
end