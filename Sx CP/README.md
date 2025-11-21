# Surgical intervention for Cerebral Palsy

Physics-based computer simulations, that can predict the effect of treatments (e.g., bony and soft tissue correction, ankle-foot-orthoses) on gait in children with cerebral palsy (CP), have the potential to improve clinical decision-making. To this end, an important challenge is to accurately estimate patient-specific neuromusculoskeletal models.

In this tutorial you'll (1.) personalize for a CP case. Next, (2.) you will model the effect of surgery and (3.) evaluate your simulation results. The workflow you'll apply in this tutorial has been published in [Van Den Bosch et al. (2025)](https://jneuroengrehab.biomedcentral.com/articles/10.1186/s12984-025-01767-w)

# I. Personalizing the musculoskeletal model
In this part you will personalize a model for a child with CP based on a clinical exam. The clinical exam is part of children's usual clinical care and is a comprehensive assesment of musculoskeletal functioning. In example 1. you will use (I.1) manual muscle testing strength scores to personalize optimal muscle force and (I.2) passive Range of Motion (ROM) scores  to personalize optimal muscle force and optimal muscle fiber length and coordinate limit torques.

To this end, you will create a settings file that can later be used in PredSim. In this tutorial you will edit You can change the model inputs in the [default settings file](../code/update_settings.m). This file can later be used to run personalized simulations in PredSim.

### Step 1. Create a copy of the update_settings file in the Code folder of this tutorial

## I.1 Strength
The strength is evaluated for the full active range of motion by manual muscle testing (MMT). The user will scale the maximal (active) muscle force based on the strength scores in the Clinical Exam

**Requirements:** Matlab.   
**Data:** MMT scores, provided in the [Clinical Exam](ClinicalExam). T0 refers to pre intervention and T1 to post intervention.       
**Additional information:** The protocol of the clinical exam, and normative values are provided in [Documentation](../Documentation)   

### Step 2. Scaling muscle strength
Add a setting S.settings.muscle_strength to your update_settings file for all muscles in the model:

	S.settings.muscle_strength = {...       
		 {'glut_max_r'},1,...                % R_hip_ext   
		 {'iliopsoas_r'},1,...               % R_hip_flex        
		 {'rect_fem_r' 'vasti_r'},1,...      % R_knee_ext  
		 {'hamstrings_r' 'bifemsh_r'},1,...  % R_knee_bend    
		 {'gastroc_r' 'soleus_r'},1,...      % R_ankle_pf  
		 {'tib_ant_r'},1,...                 % R_ankle_df  
		 {'glut_max_l'},1,...                % L_hip_ext  
		 {'iliopsoas_l'},1,...               % L_hip_flex      
		 {'rect_fem_l' 'vasti_l'},1,...      % L_knee_ext  
		 {'hamstrings_l' 'bifemsh_l'},1,...  % L_knee_bend  
		 {'gastroc_l' 'soleus_l'},1,...      % L_ankle_pf  
		 {'tib_ant_l'},1};                   % L_ankle_df  
	  
Edit S.settings.muscle_strength in the settings file based on the strength scores in the clinical exam. A lower MMT score refers to decreased strength. To represent muscle weakness in the model, maximal active fiber force of a muscle have to be scaled.
	
	Clinical Exam to strength scaling factor reference
		 CE        scaling factor
		 1           0.05
		 2           0.1
		 3           0.3
		 4           0.5
		 5           0.7

	 EXAMPLE: 
	 CE score 'strength_Hpext_R' = 3 
	 In setting: S.settings.muscle_strength = {{'glut_max_r'},0.3}

## I.2 Passive range of motion (pROM)
During a standardized clinical examination, goniometry is used to measure the passive range of motion (ROM). The ROM represents the maximum amplitude of the joint motion and is therefore an indication for muscle
length. Therefore, when the pROM is smaller than normative values, there is a clinical indication for a contracture. Contractures are modelled by reducing optimal fiber length. When optimal fiber length is reduced, muscle fibers will be stretched more at the same muscle-tendon length resulting in higher passive forces. 

To determine the optimal fiber length for contracted muscles, the musculoskeletal model will be put in the same position as during the passive range of motion assessment. The optimal fiber length will then be adjusted so that the modeled net joint torque reaches 15 Nm at the end of the range of motion, matching the clinician’s measured resistance.

**Requirements:** Matlab, OpenSim, CasADi.   
**Data:** pROM scores, provided in the [Clinical Exam](ClinicalExam). T0 refers to pre intervention and T1 to post intervention.   
**Additional information:** The protocol of the clinical exam, and normative values are provided in [Documentation](../Documentation)      
**Code:**  [main_scale_lMo_sol_gas_hams](Code/main_scale_lMo_sol_gas_hams.m) and [main_scale_lMo_iliopsoas](Code/main_scale_lMo_illiopsoas.m)      

### Step 3. Scaling muscle fiber length of soleus, gastrocnemii and hamstrings
Add a setting S.settings.scale_MT_params to your update_settings file for all muscles in the model, and define that you want to scale the optimal fiber length parameter ('lMo'):

	S.subject.scale_MT_params = {{'soleus_r'},'lMo',1,...
	                             {'gastroc_r'},'lMo',1,...
	                             {'hamstrings_r'},'lMo',1,...
	                             {'iliopsoas_r'},'lMo',1,...
	                             {'soleus_l'},'lMo',1,...
	                             {'gastroc_l'},'lMo',1,...
	                             {'hamstrings_l'},'lMo',1,...
	                             {'iliopsoas_l'},'lMo',1};
	  
Open [main_scale_lMo_sol_gas_hams](/Code/main_scale_lMo_sol_gas_hams.m) and calculate scaling factors for the soleus, gastrocnemii and hamstrings that have a clinical indication for a contraction in the Clinical exam. The code guides you through the estimation process and you only have to edit the lines of code that are inbetween. Run the code for each muscle and leg.  
% ------ start edit -----    
            and   
% ----- end edit -----

Add the computed scaling factors to S.subject.scale_MT_params. 

### Step 4. Scaling muscle fiber length of iliopsoas
Because the evaluation of iliopsoas contractures is more detailed, the iliopsoas will require a different modeling approach. Iliopsoas contractures will lead to a different unilateral ($\theta_{\text{uni}}$). and bilateral ($\theta_{\text{bi}}$) popliteal angle. When assessing the unilateral popliteal angle, the contralateral leg is laying down. Iliopsoas contractures will cause flexion of the contralateral hip and this will be compensated for by anterior pelvis tilt, which in turn will lead to increased hip flexion to position the thigh of the evaluated leg vertically. Increased hip flexion will in turn increase bi-articular hamstrings length and will thus lead to a larger knee extension deficit. The increase in hip flexion angle was determined based on the difference in popliteal angles and the ratio of the average moment arms of all bi-articular hamstrings with respect to the knee and hip:

$$
\Delta \theta_{\text{hip}} =
\left( \theta_{\text{bi}} - \theta_{\text{uni}} \right)
\cdot
\frac{
\sum_{i=1}^{n} \frac{ma_{\text{knee},i}}{ma_{\text{hip},i}}
}{
n
}
$$

with _n_ the number of bi-articular hamstrings, $ma_{\text{hip}, i}$ and $ma_{\text{knee}, i}$ the moment arm of muscle _i_ around knee and hip when in the position of the bilateral popliteal angle. The contracture of the contralateral iliopsoas is determined by solving for the scaling factor that led to passive torque when the contralateral hip is extended beyond $\Delta \theta_{\text{hip}}$.

Open [main_scale_lMo_illiopsoas](Code/main_scale_lMo_iliiopsoas.m) and calculate scaling factors for the illiopsoas that have a clinical indication for a contraction in the Clinical exam. Again, the code guides you through the estimation process and you only have to edit the lines of code that are inbetween  
% ------ start edit -----    
            and   
% ----- end edit -----

Add the computed scaling factors to S.subject.scale_MT_params. 

### Step 5. Adjusting coordinate limit torques
Observed knee extension and plantar flexion deficits were modeled by shifting the coordinate limit torques that model the stiffness of the non-muscle soft tissues around the joint.

Add a setting S.subject.set_limit_torque_coefficients_selected_dofs to your update_settings file for all dofs in the model, and define that you want to scale the optimal fiber length parameter ('lMo'):

	S.subject.set_limit_torque_coefficients_selected_dofs = 
		{{'lumbar_extension'},[-0.7644,11.2154,1.2788,-7.2704], [-0.3716,0.1068],...
             {'hip_flexion_r','hip_flexion_l'},[-2.44,5.05,1.51,-21.88],[-0.6981,1.81],...
            {'knee_angle_r','knee_angle_l'},[-6.09,33.94,11.03,-11.33],[-2.4,0.13],... 
             {'ankle_angle_r','ankle_angle_l'},[-2.03,38.11,0.18,-12.12],[-0.74,0.52]};

See the [PredSim documentation](https://github.com/KULeuvenNeuromechanics/PredSim/blob/master/Documentation/SettingsOverview.md) for an extensive description of these parameters. You'll only change the last two values in each line as they represent rotational limits in radians. 

	{'knee_angle_r','knee_angle_l'},[... ... ... ...],[flexion, extension]
	{'ankle_angle_r','ankle_angle_l'},[... ... ... ...],[plantarflexion, dorsiflexion]

Shift the limits such that they represent the observed end ROM angle from the clinical exam for knee extension minus two degrees to obtain around 15 Nm torque at end range of motion. 
Shift the limits for plantar flexion deficits based on the reported range of motion for the ankle towards plantar flexion. The onset of the coordinate limit torques was changed to 25° plantar flexion or 0° when the score was respectively ‘discrete’ or ‘severe’.

**⚠️ Note:** All joint limit values below are reported in **radians**, not degrees. 
	
	1 rad = 180/pi 
	
	EXAMPLE
	angle in degrees = 30
	angle in radians = 30 *pi/180 = 0.5236
	
	angle in radians = 0.5236
	angle in degrees = 0.5236 *180/pi = 30
	

# II. Simulate the effect of a surgical intervention
This patient underwent a bilateral distal femur extension osteotomy, a surgical procedure performed on both thighs to correct a knee extension deficit. In this operation, the surgeon removes a wedge-shaped piece of bone from the lower (distal) part of the femur (thigh bone). This wedge is taken from the anterior part of the distal femur. When the remaining bone ends are stabilised, the femur straightens, allowing the knee to move from a bent position toward a more normal extended position.    
In the model, this surgical correction shifts the knee geometry, meaning that passive extension torques will begin to act at a more extended (later) knee angle.

**Requirements:** Matlab.   
**Data:** pROM scores, provided in the [Clinical Exam](ClinicalExam). T0 refers to pre intervention and T1 to post intervention.   
**Additional information:** The protocol of the clinical exam, and normative values are provided in [Documentation](../Documentation)   

Evaluate in CE_CP_T1 the knee extension pROM post surgery and change S.subject.set_limit_torque_coefficients_selected_dofs = ...{'knee_angle_r','knee_angle_l'}, accordingly. 

# III. Running PredSim with estimated muscle-tendon parameters:**

	
