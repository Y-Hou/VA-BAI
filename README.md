# Almost-Optimal-Variance-constrained-BAI
The code for paper ``Almost Optimal Variance-constrained Best Arm Identification''

Code list:
- VABAI Experiment: it provides the code for testing the sample complexity of VA-LUCB in 10 scenarios.
  - bpara.m
  - experiment_results.mat
  - Hindex.m
  - initialization.m
  - plot_figures.m
  - processing_3SpecialCases.m 
  - pull.m
  - VA_BAI_iteration.m
  - VA_LUCB.m
- VABAI Compare: it provides the code for comparing the sample complexity of VA-LUCB, RiskAverse-UCB-BAI and VA-Uniform.
  - bpara.m
  - compare_iterate_all.m
  - H_UCB.m
  - Hindex.m
  - initialization_compete.m
  - plot_compare_3_algs.m
  - pull.m
  - RiskAverse_UCB_BAI.m
  - VA_LUCB.m
  - RiskAverse2.mat
  - VA_Uniform.m
  - VALUCB_compete2.mat
  - VAUniform_compete2.mat
  
It takes some time to run the whole experiment. Alternatively, one may plot the figures using the dataset (ending with ``.mat'').
