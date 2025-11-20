# Modeling assistive devices in stroke

In this case study, you are going to: 
1. Model weakness of the tibialis anterior (TA), which may occur after stroke (REF). You will predict the gait pattern associated with this weakness, and compare it to a healthy gait pattern.
2. Model the effect of a passive ankle exoskeleton that delivers ankle dorsiflexion torque, thereby assisting the (weak) TA. You will predict the gait pattern associated with using this assitive device in combination with weakness, and compare it to a healthy gait pattern, and to a gait pattern with weakness but without using the assitive device

## Step 1: run a reference simulation with the 2D model
Make sure you have PredSim and associated dependencies installed (see https://github.com/KULeuvenNeuromechanics/PredSim). We will be using the 2D model called `gait1018`. Because PredSim is using the 3D model by default, we need to make a small adjustment to the main.m script. On `line 18` and `line 23` of `PredSim/main.m`, change `'Falisse_et_al_2022'` with `'gait1018'`. See the [documentation of PredSim](https://github.com/KULeuvenNeuromechanics/PredSim) for further information.

You can now run a simulation with the 2D model, simply by running the `Predsim/main.m` script. Once your simulation is done, the results are stored in `PredSimResults\gait1018`. If this is the first time you ran a simulation, the results are stored in files starting with `gait1018_v1`. The following files are created:
- `gait1018_v1.mat`: contains all the output variables that can be processed and visualized using MATLAB
- `gait1018_v1.mot`: contains the motion files of the simulation, which can be visualized using OpenSim
- `gait1018_v1_log.txt`: contains the logged information about the simulation

## Step 2: induce weakness of the tibialis anterior
The function `PredSim-workshop-smalll-2025/code/update_settings.m` may be used to update the settings. In this function, add the following lines of code:

`strength_level = .05; % specify the weakness level (0-1)` <br>
`S.subject.muscle_strength   = {{'tib_ant_r'}, strength_level};` <br>
`S.misc.gaitmotion_type = 'FullGaitCycle';`

This results in reducing the tibialis anterior strength of the right leg (`tib_ant_r`) to 5% of its default level. Next, replace `line 19` of `Predsim/main.m` (currently empty) with the following line of code:

`S = update_settings(S);`

## Step 3: run a simulation with a weak TA
  You can now run a simulation with the 2D model, simply by running the `Predsim/main.m` script. Once your simulation is done, the results are stored in `PredSimResults\gait1018`. If this is the second time you ran a simulation, the results are stored in files starting with `gait1018_v2`

## Step 4: evaluate the effect of weakness
   You can now evaluate the effect of weakness by running the `PredSim-workshop-smalll-2025/Sx Stroke/Plotting/compare_devices.m` script. 

## Step 5: add an exoskeleton
The function `PredSim-workshop-smalll-2025/code/update_settings.m` may be used to update the settings. In this function, add the following lines of code:

`exo1.ankle_stiffness = 0; % ankle stiffness in Nm/rad` <br>
`exo1.left_right = 'r'; % 'l' for left or 'r' for right` <br>
`exo1.function_name = 'ankleExoDorsi';` <br>
`S.orthosis.settings{1} = exo1;`

This adds an exoskeleton with a stiffness of 0 Nm/rad to the right foot. The mass of the exoskeleton is ignored for simplicity. Because the default stiffness is 0, the exoskeleton should not affect the gait pattern. Change the stiffness to a desired level (greater than 0). 

## Step 6: run a simulation with a weak TA and an exoskeleton
  You can now run a simulation with the 2D model, simply by running the `Predsim/main.m` script. Once your simulation is done, the results are stored in `PredSimResults\gait1018`. If this is the third time you ran a simulation, the results are stored in files starting with `gait1018_v3`

## Step 7: evaluate the effect of weakness and exoskeleton assitive
   You can now evaluate the effect of weakness by running the `PredSim-workshop-smalll-2025/Sx Stroke/Plotting/compare_devices.m` script. 

## Step 8: test different stiffness
In `PredSim-workshop-smalll-2025/code/update_settings.m`, adjust the following line of code to test the effect of an exoskeleton with a different stiffness:

`exo1.ankle_stiffness = ; % ankle stiffness in Nm/rad`

Repeat Steps 6-8 until you reach a satisfied gait pattern. You may also change the weakness level (Step 2). 
