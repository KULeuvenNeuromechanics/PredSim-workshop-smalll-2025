function[S] = update_settings(S)

strength_level = .05; % specify the weakness level (0-1)
S.subject.muscle_strength   = {{'tib_ant_r'}, strength_level};
S.misc.gaitmotion_type = 'FullGaitCycle';

exo1.ankle_stiffness = 0; % ankle stiffness in Nm/deg
exo1.ankle_offset = 17; % ankle angle offset (deg)
exo1.left_right = 'r'; % 'l' for left or 'r' for right
exo1.function_name = 'ankleExoDorsi';
S.orthosis.settings{1} = exo1;

end