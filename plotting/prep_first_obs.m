%% prepare for plotting
% gather data for various metrics for initial observation case
% use << prep_next_obs.m >> for subsequent observations

x = [50 100 250 500];

% for x = 50
% edit distance
D_A_MMHC =  nanmean(D_mmhc);
D_A_SCA =  nanmean(D_sca);
D_A_PC =  nanmean(D_pc);
D_A_TDPA =  nanmean(D_tdpa);
D_A_UNION =  nanmean(D_A_union);
D_A_HALF =  nanmean(D_A_half);
D_A_MAJ =  nanmean(D_A_maj);
D_A_INT =  nanmean(D_A_int);

D_ud_MMHC =  nanmean(D_ud_mmhc);
D_ud_SCA =  nanmean(D_ud_sca);
D_ud_PC =  nanmean(D_ud_pc);
D_ud_TDPA =  nanmean(D_ud_tdpa);
D_ud_UNION =  nanmean(D_ud_union);
D_ud_HALF =  nanmean(D_ud_half);
D_ud_MAJ =  nanmean(D_ud_maj);
D_ud_INT =  nanmean(D_ud_int);

% selectivity
sel_A_MMHC =  nanmean(sel_mmhc);
sel_A_SCA =  nanmean(sel_sca);
sel_A_PC =  nanmean(sel_pc);
sel_A_TDPA =  nanmean(sel_tdpa);
sel_A_UNION =  nanmean(sel_A_union);
sel_A_HALF =  nanmean(sel_A_half);
sel_A_MAJ =  nanmean(sel_A_maj);
sel_A_INT =  nanmean(sel_A_int);

sel_ud_MMHC =  nanmean(sel_ud_mmhc);
sel_ud_SCA =  nanmean(sel_ud_sca);
sel_ud_PC =  nanmean(sel_ud_pc);
sel_ud_TDPA =  nanmean(sel_ud_tdpa);
sel_ud_UNION =  nanmean(sel_ud_union);
sel_ud_HALF =  nanmean(sel_ud_half);
sel_ud_MAJ =  nanmean(sel_ud_maj);
sel_ud_INT =  nanmean(sel_ud_int);

% sensitivity 
sens_A_MMHC =  nanmean(sens_mmhc);
sens_A_SCA =  nanmean(sens_sca);
sens_A_PC =  nanmean(sens_pc);
sens_A_TDPA =  nanmean(sens_tdpa);
sens_A_UNION =  nanmean(sens_A_union);
sens_A_HALF =  nanmean(sens_A_half);
sens_A_MAJ =  nanmean(sens_A_maj);
sens_A_INT =  nanmean(sens_A_int);

sens_ud_MMHC =  nanmean(sens_ud_mmhc);
sens_ud_SCA =  nanmean(sens_ud_sca);
sens_ud_PC =  nanmean(sens_ud_pc);
sens_ud_TDPA =  nanmean(sens_ud_tdpa);
sens_ud_UNION =  nanmean(sens_ud_union);
sens_ud_HALF =  nanmean(sens_ud_half);
sens_ud_MAJ =  nanmean(sens_ud_maj);
sens_ud_INT =  nanmean(sens_ud_int);

% specificity
spec_A_MMHC =  nanmean(spec_mmhc);
spec_A_SCA =  nanmean(spec_sca);
spec_A_PC =  nanmean(spec_pc);
spec_A_TDPA =  nanmean(spec_tdpa);
spec_A_UNION =  nanmean(spec_A_union);
spec_A_HALF =  nanmean(spec_A_half);
spec_A_MAJ =  nanmean(spec_A_maj);
spec_A_INT =  nanmean(spec_A_int);

spec_ud_MMHC =  nanmean(spec_ud_mmhc);
spec_ud_SCA =  nanmean(spec_ud_sca);
spec_ud_PC =  nanmean(spec_ud_pc);
spec_ud_TDPA =  nanmean(spec_ud_tdpa);
spec_ud_UNION =  nanmean(spec_ud_union);
spec_ud_HALF =  nanmean(spec_ud_half);
spec_ud_MAJ =  nanmean(spec_ud_maj);
spec_ud_INT =  nanmean(spec_ud_int);

% true positives
tp_A_MMHC =  nanmean(tp_A_mmhc);
tp_A_SCA =  nanmean(tp_A_sca);
tp_A_PC =  nanmean(tp_A_pc);
tp_A_TDPA =  nanmean(tp_A_tdpa);
tp_A_UNION =  nanmean(tp_A_union);
tp_A_HALF =  nanmean(tp_A_half);
tp_A_MAJ =  nanmean(tp_A_maj);
tp_A_INT =  nanmean(tp_A_int);

tp_ud_MMHC =  nanmean(tp_ud_mmhc);
tp_ud_SCA =  nanmean(tp_ud_sca);
tp_ud_PC =  nanmean(tp_ud_pc);
tp_ud_TDPA =  nanmean(tp_ud_tdpa);
tp_ud_UNION =  nanmean(tp_ud_union);
tp_ud_HALF =  nanmean(tp_ud_half);
tp_ud_MAJ =  nanmean(tp_ud_maj);
tp_ud_INT =  nanmean(tp_ud_int);
