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

Before going to the hands-on tutorials, the user should run a reference 2D simulation with [PredSim](https://github.com/KULeuvenNeuromechanics/PredSim). 

1. Open Matlab
2. Navigate to your `PredSim` folder in Matlab
3. Open the script `main.m` in Matlab by clicking on it
4. During this workshop the user will run predictive simulations with the 2D model instead of the default 3D model. Therefore, adjust the following lines in `main.m`:
   - Line 20 - `[S] = initializeSettings('gait1018');`
   - Line 25 - `S.subject.name = 'gait1018';`
5. Click on the green 'Run' button

Congratulations your first simulation with the 2D model is running! 

## PredSimResults
Once your simulation is done, the results are stored in `PredSimResults\gait1018` as `gait1018_v1`. Each time you run a simulation, it is saved with an incremental version number: v1, v2, v3, v4, … The most recently run simulation will always have the highest version number. If this is the first time you ran a simulation, the results are stored in files starting with `gait1018_v1`. The following files are created:
- `gait1018_v1.mat`: contains all the output variables that can be processed and visualized using MATLAB
- `gait1018_v1.mot`: contains the motion files of the simulation, which can be visualized using OpenSim
- `gait1018_v1_log.txt`: contains the logged information about the simulation

## Visualizing your simulation results in OpenSim
To visualize the simulation in OpenSim:
1. Open OpenSim
2. Click on 'File > Open Model...' and navigate to the 2D model `PredSim/Subjects/gait1018/gait1018.osim`
3. Click on 'File > Load Motion...' and navigate to the mot file of your simulation `PredSimResults/gait1018/gait1018_v1.mot`
4. Click on the 'Play forward' button to see the motion. You may also adapt the playback speed.

## Adding PredSim-workshop-smalll-2025 to path
Before starting one of the three cases, make sure that this repository is added to your Matlab path.

1. Either download or clone [the current repository](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025)
1. Open Matlab
2. Navigate to the `PredSim-workshop-smalll-2025` folder
3. Open the script called `set_up_paths.m`
5. Click on the green 'Run' button
