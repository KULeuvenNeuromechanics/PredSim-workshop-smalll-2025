# DMD Case

Physics-based computer simulations that can predict the effect of underlying impairments (e.g., muscle weakness and muscle stiffness) and treatments (e.g., Achilles tendon lengthening) on gait in children with Duchenne muscular dystrophy (DMD) have the potential to improve clinical decision-making. In this section, the user will personalize muscle parameters of a neuromusculoskeletal model based on the instrumented strength assessment and the clinical examination of a case with DMD and the user will simulate an intervention, i.e. Achilles tendon lengthening. 

In this tutorial the user will (1.) personalize for a case with DMD. Next, (2.) you will simulate an Achilles tendon lengthening surgery (3.) evaluate your simulation results with experimental data of the case. The workflow you'll apply in this tutorial has been published in [Vandekerckhove et al.(2025)](https://jneuroengrehab.biomedcentral.com/articles/10.1186/s12984-025-01631-x)

## Personalize muscle parameters based on instrumented assessment and clinical exam

In this section the user will use (I.) instrumented strength scores and (II.) passive Range of Motion (ROM) scores and clinical stiffness scale scores to personalize active muscle force and passive muscle stiffness, respectively.

To this end, you will edit the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m) This function can later be used to run personalized simulations in PredSim.

### I. Muscle weakness
The strength was assessed with fixed dynamometry. The user will scale the maximal active muscle force based on the instrumented strength scores to model subject-specific muscle weakness.

**Requirements:** [Anthropometric-related percentile curves for muscle strength of typically developing children](https://shiny.gbiomed.kuleuven.be/Z-score_calculator_muscle_strength/)

**Data:** Instrumented strength scores (mean joint torques), provided in [Clinical Exam/IWA_DMDcase.xlsx](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/SX%20DMD%20case/Clinical%20Exam/IWA_DMDcase.xlsx)

**Additional information:** The protocol of the instrumented strength assessment is provided in [Documentation](PredSim-workshop-smalll-2025/Documentation)

#### Step 1. Scaling muscle strength

1. Open the app ([Anthropometric-related percentile curves for muscle strength of typically developing children](https://shiny.gbiomed.kuleuven.be/Z-score_calculator_muscle_strength/)).
2. Open IWA_DMDcase.xlsx under Clinical Exam ([Clinical Exam/IWA_DMDcase.xlsx](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/SX%20DMD%20case/Clinical%20Exam/IWA_DMDcase.xlsx)), take the instrumented strength scores (mean joint torques)
3. In the app
 - Enter: body mass, height and mean joint torques
 - Click Calculate z-score 
   The app will automatically plot the subject-specific torques on the TD percentile curves and compute z-scores as well as percentages relative to the median of the percentile curves
 - To save the results, click Export data to download a CSV file.
 - Repeat for each joint: hip, knee, ankle
4. Add a setting S.settings.muscle_strength to the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m) for all muscles in the model:

	 	S.settings.muscle_strength = {... 
			{'iliopsoas_r', 'iliopsoas_l'}, 1, ...								% hip_flex
			{'glut_max_r', 'glut_max_l'}, 1, ...								% hip_ext
			{'rect_fem_r', 'vasti_r', 'rect_fem_l', 'vasti_l'}, 1, ...			% knee_ext
			{'bifemsh_r',  'bifemsh_l', 'hamstrings_r', 'hamstrings_l'}, 1, ...	% knee_flex
			{'tib_ant_r', 'tib_ant_l'}, 1, ...									% ankle_df
			{'gastroc_r', 'gastroc_l', 'soleus_r', 'soleus_l'}, 1,... 			% ankle_pf
			};
	  
5. Edit S.settings.muscle_strength in the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m) based on the percentages from the app (for example, 1 = 100%). 

**Background:** The muscles in the model are represented as Hill-type muscle–tendon units. The muscle–tendon unit consists of an active contractile element in parallel with a passive element, which is in series with a tendon. The muscle force arises from both the active contractile component and the passive elastic element. The most common parametrization of this model assumes that maximal isometric force, and passive muscle and tendon stiffness are coupled. Therefore, they all scale with maximal isometric force. However, in DMD, active and passive muscle forces do not decrease simultaneously. The loss of contractile tissue is accompanied by its replacement with fat and fibrotic tissue, resulting in a decline in active muscle force while passive muscle stiffness increases. Therefore, we modeled muscle weakness by scaling only the active force component, rather than scaling maximal isometric force that also scales the passive elements.


### II. Muscle stiffness
Muscle stiffness was evaluated through passive ROM and clinical stiffness scale. The user will estimate the start of the passive force-length curves of the muscles based on the passive ROM and clinical stiffness scale to model subject-specific passive muscle stiffness. 

**Requirements:** OpenSim, Matlab.

**Data:** passive ROM and clinical stiffness scale values, provided in [Clinical Exam/Clinical_Exam_DMDCase.xlsx](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/SX%20DMD%20case/Clinical%20Exam/Clinical_Exam_DMDcase.xlsx)), reference passive ROM values for typically developing children from Mudge et al., matched to the case’s age, are provided in subfolder [Clinical Exam/Ref_ROM_TD.xlsx](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/SX%20DMD%20case/Clinical%20Exam/Ref_ROM_TD.xlsx) 

**Code:** [Code/Personalize_passive_muscle_stiffness_based_on_CE.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/SX%20DMD%20case/Code/Personalize_passive_muscle_stiffness_based_on_CE.m)

**Additional information:** The protocol of the clinical examination is provided in [Documentation](PredSim-workshop-smalll-2025/Documentation)

#### Step 2. Shifting the passive force-length curvescaling muscle strength

1. Open Personalize_passive_muscle_stiffness_based_on_CE.m in matlab. This code guides users through the estimation process.
 - Users only have to change the paths (line 19 to line 21).
 - If the user will use this code in the future and have additional clinical measurements, the user can update the link between those measurements and the specific muscles (lines 25-60).
	
2. Add a setting S.settings.muscle_pass_stiff_shift to the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m) for all assessed muscles:

	 	S.subject.muscle_pass_stiff_shift = {{'tib_'},0.9,...
     		{'gastroc_r','gastroc_l'},0.9,...
     		{'soleus_l', 'soleus_r'}, 0.9,...
     		{'bifemsh_r',  'bifemsh_l', 'hamstrings_r', 'hamstrings_l'},1,...
     		{'iliopsoas_r', 'iliopsoas_l', 'rect_fem_r', 'rect_fem_l'},1,...
     		}; 	 	 
	
3. Edit S.settings.muscle_pass_stiff_shift in the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m) based on the printed average shift (outcome from Personalize_passive_muscle_stiffness_based_on_CE.m).

**Background:** In DMD, contractile tissue is not only lost but also replaced by fat and fibrotic tissue, resulting in increased muscle stiffness and eventually leading to contractures. We modeled this by shifting the passive muscle force-length relationship to shorter fiber lengths through a reduction in the fiber length at which passive muscle force begins to develop. We use the ROM measurements and clinical stiffness scale to estimate this shift. For the ROM measurements, we estimate the difference in fiber length at which the muscle starts to develop passive force between TD and DMD from the difference in joint angle at the end of ROM. The joint angle at the end of ROM of TD children was based on age-related reference data reported by Mudge et al. To estimate the corresponding difference in fiber length, we multiply the difference in measured joint angle at end ROM between TD and DMD (in radians) with the moment arm of the muscles in the anatomical position. This difference in fiber length was normalized to optimal fiber length to compute the shift of the passive force-length relationship. 
For the clinical stiffness scale, the normalized fiber length at which passive force starts to develop was assumed 1 when the clinical stiffness score was 0 (no increased resistance), 0.83 when the score was 1 (minimal increased resistance), 0.67 when the score was 2 (increased resistance), and 0.5 when the score was 3 (highly pronounced resistance) corresponding to a shift of respectively 0, 0.17, 0.33, and 0.5. 
We shifted the passive force-length relationship by the mean of the shifts estimated based on the ROM and clinical stiffness score.

#### Step 3. Running PredSim with estimated muscle parameters:

The users will use [PredSim](https://github.com/KULeuvenNeuromechanics/PredSim) to run predictive simulations. 
You will need to do some small adjustments to [PredSim/main.m](https://github.com/KULeuvenNeuromechanics/PredSim/blob/master/main.m):
1. On `line 20` and `line 25` change `Falisse_et_al_2022` to `gait1018`. We will use the 2D model instead of the default 3D model
2. Replace `line 21` with the following code:
   
	 	S = update_settings(S);
   	 
Users are now ready to run predictive simulations based on a neuromusculoskeletal model with DMD-specific impairments, by simply running the [PredSim/main.m](https://github.com/KULeuvenNeuromechanics/PredSim/blob/master/main.m) script. 

	
## Simulate the effect of Achilles tendon lengthening

In this section, the user will simulate an Achilles tendon release in the DMD case to predict the effect of this intervention. 
This treatment was often performed in patients with DMD who walk on their toes (tiptoeing gait), but may cause loss of ambulation. 

#### Step 4. Simulate an Achilles tendon lengthening surgery
	
1. Add a setting S.subject.scale_MT_params to the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m):

	 	S.subject.scale_MT_params = {{'soleus_l', 'soleus_r', 'gastroc_r', 'gastroc_l'}, 'lTs', 1.3};	
	 
2. Edit S.subject.scale_MT_params to 1.3 in the function [PredSim-workshop-smalll-2025/code/update_settings.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/code/update_settings.m) to scale the the tendon slack length (lTs) of both muscles (left and right) by 1.3, effectively modeling a lengthened Achilles tendon.

Important: Apply this change on top of the previous DMD simulation, meaning you start from the model that already includes DMD-specific muscle weakness and increased muscle stiffness.

#### Step 5. Running PredSim with estimated muscle parameters:

The users will use [PredSim](https://github.com/KULeuvenNeuromechanics/PredSim) to run predictive simulations. 
You will need to do some small adjustments to [PredSim/main.m](https://github.com/KULeuvenNeuromechanics/PredSim/blob/master/main.m):
1. On `line 20` and `line 25` change `Falisse_et_al_2022` to `gait1018`. We will use the 2D model instead of the default 3D model
2. Replace `line 21` with the following code:
   
	 	S = update_settings(S);
   	 
Users are now ready to run predictive simulations based on a neuromusculoskeletal model with DMD-specific impairments, by simply running the [PredSim/main.m](https://github.com/KULeuvenNeuromechanics/PredSim/blob/master/main.m) script. 

## Plotting the results

Use the script in [PlotFigure/run_this_file_to_plot_figures_Case_DMD.m](https://github.com/KULeuvenNeuromechanics/PredSim-workshop-smalll-2025/blob/main/SX%20DMD%20case/PlotFigure/run_this_file_to_plot_figures_Case_DMD.m) to plot your simulations results against the Experimental Data of the patient.

