# DMD Case

Physics-based computer simulations that can predict the effect of underlying impairments (e.g., muscle weakness and muscle stiffness) and treatments (e.g., Achilles tendon lengthening) on gait in children with Duchenne muscular dystrophy (DMD) have the potential to improve clinical decision-making. In this section, the user will personalize muscle parameters of a neuromusculoskeletal model based on the instrumented strength assessment and the clinical examination of a case with DMD and the user will simulate an intervention, i.e. Achilles tendon lengthening. 

In this tutorial the user will (1.) personalize for a case with DMD. Next, (2.) you will simulate an Achilles tendon lengthening surgery (3.) evaluate your simulation results with experimental data of the case. The workflow you'll apply in this tutorial has been published in [Vandekerckhove et al.(2025)](https://jneuroengrehab.biomedcentral.com/articles/10.1186/s12984-025-01631-x)

## Personalize muscle parameters based on instrumented assessment and clinical exam

In this section the user will use (I.) instrumented strength scores and (II.) passive Range of Motion (ROM) scores and clinical stiffness scale scores to personalize active muscle force and passive muscle stiffness, respectively.

To this end, you will create a settings file that can later be used in PredSim. In this tuturial you will edit [default settings file](code/update_settings.m). This file can later be used to run personalized simulations in PredSim.

	Step 1. Create a copy of the update_settings file in the Code folder of this tuturial


### I. Muscle weakness
The strength was assessed with fixed dynamometry. 

**Data:** The mean moments of the case with DMD is provided in the subfolder 'Clinical Exam'/IWA_DMDcase

The user will express the individual strength scores (i.e., joint moments) as a percentage relative to the median of typically developing children, using our reference database of 153 typically developing children (aged …–…) and the corresponding percentile curves.

Go to our app and calculate the strength percentages for the values provided in 'Clinical Exam'/IWA_DMDcase.
Link to the app: https://shiny.gbiomed.kuleuven.be/Z-score_calculator_muscle_strength/

**Output:** The user will use the calculated strength percentages (calculated via the app) to model subject-specific muscle weakness via the settings parameter 'S.subject.muscle_strength' in the PredSim code. The settings file for the model is provided in 'Model'/settings_gait1018_Case_DMD.m. The user can already fill in the scaling factors for the strength in this file between 'start edit' and 'stop edit'. 

The muscles in the model are represented as Hill-type muscle–tendon units. The muscle–tendon unit consists of an active contractile element in parallel with a passive element, which is in series with a tendon. The muscle force arises from both the active contractile component and the passive elastic element. The most common parametrization of this model assumes that maximal isometric force, and passive muscle and tendon stiffness are coupled. Therefore, they all scale with maximal isometric force. However, in DMD, active and passive muscle forces do not decrease simultaneously. The loss of contractile tissue is accompanied by its replacement with fat and fibrotic tissue, resulting in a decline in active muscle force while passive muscle stiffness increases. Therefore, we modeled muscle weakness by scaling only the active force component, rather than scaling maximal isometric force that also scales the passive elements.


### II. Muscle stiffness
Muscle stiffness was evaluated through passive ROM and clinical stiffness scale. 

**Data:** The passive ROM values and clinical stiffness scale values of the case with DMD are provided in the subfolder 'Clinical Exam'/Clinical_Exam_DMDcase and The reference passive ROM values for typically developing children, matched to the case’s age, are provided in subfolder 'Clinical Exam'/Ref_ROM_TD .

In DMD, contractile tissue is not only lost but also replaced by fat and fibrotic tissue, resulting in increased muscle stiffness and eventually leading to contractures. We modeled this by shifting the passive muscle force-length relationship to shorter fiber lengths through a reduction in the fiber length at which passive muscle force begins to develop. We use the ROM measurements and clinical stiffness scale to estimate this shift. For the ROM measurements, we estimate the difference in fiber length at which the muscle starts to develop passive force between TD and DMD from the difference in joint angle at the end of ROM. The joint angle at the end of ROM of TD children was based on age-related reference data reported by Mudge et al. To estimate the corresponding difference in fiber length, we multiply the difference in measured joint angle at end ROM between TD and DMD (in radians) with the moment arm of the muscles in the anatomical position. This difference in fiber length was normalized to optimal fiber length to compute the shift of the passive force-length relationship. 
For the clinical stiffness scale, the normalized fiber length at which passive force starts to develop was assumed 1 when the clinical stiffness score was 0 (no increased resistance), 0.83 when the score was 1 (minimal increased resistance), 0.67 when the score was 2 (increased resistance), and 0.5 when the score was 3 (highly pronounced resistance) corresponding to a shift of respectively 0, 0.17, 0.33, and 0.5. 
We shifted the passive force-length relationship by the mean of the shifts estimated based on the ROM and clinical stiffness score.


**Requirements:** OpenSim.

**How to use the code:**
The code in subfolder 'Code'/Personalize_passive_muscle_stiffness_based_on_CE.m guides the users through the estimation process. Users only have to change the paths (line 19 to line 21). If the user will use this code in the future and have additional clinical measurements, the user can update the link between those measurements and the specific muscles (lines 25-60). 

**Output:** The user will use the calculated start of the passive muscle force-length curves (calculated via Personalize_passive_muscle_stiffness_based_on_CE.m) to model subject-specific muscle stiffness via the settings parameter 'S.subject.muscle_pass_stiff_shift' in the PredSim code. The settings file for the model is provided in 'Model'/settings_gait1018_Case_DMD.m. The user can already fill in the scaling factors for the passive muscle stiffness in this file between 'start edit' and 'stop edit'. 


### Running PredSim with estimated muscle parameters:

Users are now ready to run predictive simulations based on a neuromusculoskeletal model with DMD-specific impairments.
1. Use the adapted settings file for the model in 'Model'/settings_gait1018_Case_DMD.m
2. Adapt the main.m in PredSim: 
	- fill in the name of settings file on line 20 to initialize the correct settings file: [S] = initializeSettings('gait1018_Case_DMD'); 
	- fill in the name of the model on line 25: S.subject.name = 'gait1018_Case_DMD';

	
## Simulate the effect of Achilles tendon lengthening

In this section, the user will simulate an Achilles tendon release in the DMD case to predict the effect of this intervention. 
This treatment is often performed in patients with DMD who walk on their toes (tiptoeing gait).

To do this, increase the tendon slack length of the soleus and gastrocnemius muscles in the settings file 'Model'/settings_gait1018_Case_DMD.m:

S.subject.scale_MT_params = {{'soleus_l', 'soleus_r', 'gastroc_r', 'gastroc_l'}, 'lTs', 1.3};

This scales the tendon slack length (lTs) of both muscles (left and right) by 1.3, effectively modeling a lengthened Achilles tendon.

Important:
Apply this change on top of the previous DMD simulation, meaning you start from the model that already includes DMD-specific muscle weakness and increased muscle stiffness.
This ensures the simulation reflects both the underlying DMD impairments and the effect of Achilles tendon lengthening.

### Running PredSim with estimated muscle parameters:

Users are now ready to run predictive simulations based on a neuromusculoskeletal model with DMD-specific impairments and a simulated Achilles tendon lengthening.
1. Use the adapted settings file for the model in 'Model'/settings_gait1018_Case_DMD.m
2. Adapt the main.m in PredSim: 
	- fill in the name of settings file on line 20 to initialize the correct settings file: [S] = initializeSettings('gait1018_Case_DMD'); 
	- fill in the name of the model on line 25: S.subject.name = 'gait1018_Case_DMD';

## Plotting the results

Use the script in 'PlotFigure'/run_this_file_to_plot_figures_Case_DMD.m to plot your simulations results against the Experimental Data of the patient.

