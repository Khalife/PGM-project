function  [model, ll, log_beta] = EM_LDA(corpus)
    %% Initialise LDA model
    
    
    %% EM part
    ll = 10;
    old_ll = 0;
    iter = 1;
    epsilon = 10^(-10);
    
    %% Initialize model from corpus
    
    model.K = 4;
    model.size_vocabulary = 4;
    model.alpha = zeros(model.K,1);
    model.log_beta = zeros(model.K, corpus{1}.nb_word);
    
    [log_beta] = init_corpus(corpus, model);
    model = LDA_MLE(model, alpha, log_beta, length(corpus));
    
    
    while (abs((old_ll - ll)/old_ll) > epsilon) %&& (iter < MAX_ITER)
       %% Expectation
       old_ll = ll;       
       alpha = zeros(model.K,1);
       log_beta = zeros(model.K, model.size_vocabulary);
       for d=1:length(corpus)
           [temp_ll, temp_alpha, temp_beta] = e_step(corpus{d},model) ;
           alpha = alpha + temp_alpha;
           log_beta = log_beta + temp_beta;
           ll = ll + temp_ll;
       end
       log_beta = log(log_beta);
       %% Maximization 
       model = LDA_MLE(model, alpha, log_beta, length(corpus));
       iter = iter + 1;
       

    end
    iter
    old_ll
    ll
end