function [ll, gamma, log_phi] = LDA_inference(model, document)

    epsilon = 10^(-3);
    %% Initialize
    log_phi = ones(model.K,document.nb_word) / model.K;
    gamma = model.alpha + document.nb_word * ones(model.K,1) / model.K;
    
    %% convergence loop
    ll = 10;
    old_ll = 0;
    while abs(ll - old_ll)/ll > epsilon
        log_phi = model.log_beta(:,document.words) + repmat(log_deriv_gamma(gamma), [1 document.nb_word]) ...
            - repmat(sum(gamma) , [model.K document.nb_word]);
        log_phi = log_phi - repmat(log_sum_mat(log_phi')',[model.K 1]);
        gamma = model.alpha + exp(log_sum_mat(log_phi));
        
        old_ll = ll;
        ll = LDA_likelyhood(model, log_phi, gamma, document);
    end
end