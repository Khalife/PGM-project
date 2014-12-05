load('toy_data_1.mat');

[model, ll, phi] = EM_LDA(toy_data_1.corpus);