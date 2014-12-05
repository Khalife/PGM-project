function model = LDA_MLE(model, alpha, log_beta, size_corpus)
    model.log_beta = log_beta - repmat(log_sum_mat(log_beta),[1 model.size_vocabulary]);
    model.alpha = arrayfun(@(u) opti_alpha(u, size_corpus, model.K), alpha);
end