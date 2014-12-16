function [ll, alpha, beta] = e_step(doc,model)
    [ll,var_gamma,log_phi] = LDA_inference(model,doc);
    
    alpha = sum(arrayfun(@(u) log_deriv_gamma(u), var_gamma));
    alpha = alpha - model.K * log_deriv_gamma(sum(var_gamma));
    beta = zeros(model.K, model.size_vocabulary);
    for n=1:doc.nb_word
        for k=1:model.K
            beta(k,doc.words(n)) = beta(k,doc.words(n)) + exp(log_phi(k,n));
        end
    end
end