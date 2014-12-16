function [log_beta] = init_corpus(corpus, model)
    doc = corpus{1};
    log_beta = ones(model.K, doc.nb_word);
    for i=1:doc.nb_word
        log_beta = log_beta + 1;
    end
    