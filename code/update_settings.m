function[S] = update_settings(S)

% Full gait cycle simulations instead of Half gait cycle (default) simulations
S.misc.gaitmotion_type = 'FullGaitCycle';

% Baseline setting for 2D model - shift the passive force-length curve of the ankle muscles to
% 0.9 of normalized muscle length 
S.subject.muscle_pass_stiff_shift = {{'tib_', 'gastroc_', 'soleus_'},0.9};

end