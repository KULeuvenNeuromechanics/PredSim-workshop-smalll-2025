% --------------------------------------------------------------------------
% Settings for gait1018 (i.e. 2D model) that deviate from the PredSim defaults
%
% Original author: Lars D'Hondt
% Original date: 12/August/2024
% --------------------------------------------------------------------------

S.subject.name = 'gait1018_Case_DMD';

% This model has no arms
S.subject.base_joints_arms = []; 

% Achilles tendon stiffness
S.subject.tendon_stiff_scale = {{'soleus','gastroc'},0.5};

%--------------- start edit ----------------------%
% Fill in the scaling factors derived from the strength app (1 = 100%)
% muscle weakness
S.subject.muscle_strength   = {{ 'iliopsoas_r', 'iliopsoas_l'}, 1, ...
{'glut_max_r', 'glut_max_l'}, 1, ...
{'rect_fem_r', 'vasti_r', 'rect_fem_l', 'vasti_l'}, 1, ...
{'bifemsh_r',  'bifemsh_l', 'hamstrings_r', 'hamstrings_l'}, 1, ...
{'tib_ant_r', 'tib_ant_l'}, 1, ...
{'gastroc_r', 'gastroc_l', 'soleus_r', 'soleus_l'}, 1,... 
};
%--------------- stop edit -------------------------%

%--------------- start edit ------------------------%
% Fill in the shift of the passive force-length curve based on the clinical
% examination (Personalize_passive_muscle_stiffness_based_on_CE)
% muscle stiffness/contractures
S.subject.muscle_pass_stiff_shift = {{'tib_'},0.9,...
     {'gastroc_r','gastroc_l'},1,...
     {'soleus_l', 'soleus_r'}, 1,...
     {'bifemsh_r',  'bifemsh_l', 'hamstrings_r', 'hamstrings_l'},1,...
     {'iliopsoas_r', 'iliopsoas_l', 'rect_fem_r', 'rect_fem_l'}, 1,...
     }; 
%--------------- stop edit ------------------------%


%--------------- start edit ------------------------%
% Simulate Achilles tendon lengthening by lengthening the tendon slack
% length of the plantar flexors 
%S.subject.scale_MT_params = {{'soleus_l', 'soleus_r', 'gastroc_r','gastroc_l'},'lTs',1.3};
%--------------- stop edit ------------------------%