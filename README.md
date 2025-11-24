# Workshop on Predictive Simulations of Human Movement - SMALLL 2025

Welcome to the Workshop on Predictive Simulations of Human Movement repository!

This repo contains the resources used during the workshop. Below is a list of the 3 hands-on tutorials:
- S1 DMD
- S2 CP
- S2 Dropfoot

Seminar specific information can be found in the respective folders.

## Dependencies

The examples and assignments in this repo have some dependencies.

| Seminar | Windows   | MATLAB     | CasADi  | PredSim  |
|----------|:--------:|:--------:|:--------:|:--------:|
| Sx Stroke                                               | ☑️   | ☑️  | ☑️  | ☑️  |
| Sx CP                                                   | ☑️   | ☑️  | ☑️  |  ☑️ |
| Sx DMD                                                  | ☑️   | ☑️  | ☑️  | ☑️  |


Here you can find the links to the dependencies
- [CasADi](https://web.casadi.org/get/)
- [PredSim](https://github.com/KULeuvenNeuromechanics/PredSim)


## Running a reference 2D simulation with PredSim

Before going to the hands-on tutorials, the user should run a reference 2D simulation with PredSim. 

1. Open Matlab
2. Navigate to your `PredSim` folder in Matlab
3. Open the script `main.m` in Matlab by clicking on it
4. During this workshop the user will run predictive simulations with the 2D model instead of the default 3D model and the user will run Full gait cycle simulations instead of the default Half gait cycle simulations. Therefore, adjust the following lines in `main.m`:
   - Line 20 - `[S] = initializeSettings('gait1018');`
   - Line 22 - `S.misc.gaitmotion_type = 'FullGaitCycle';`
   - Line 25 - `S.subject.name = 'gait1018';`
5. Click on the green 'Run' button


   
