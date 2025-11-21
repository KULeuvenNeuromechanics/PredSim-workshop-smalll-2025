function [Qs,Qdots,idx_joint,coord_name] = get_CE_position(CE_angle,muscle_toScale,side,coordinates)
% Original authors: Ellis Van Can
% Original date: November 19,2024

if strcmp(side,'r')
    other_side = 'l';
elseif strcmp(side,'l')
    other_side = 'r';
end
if strcmp(muscle_toScale,'soleus')
            coord_name = 'ankle_angle';
            model_toDiffPos = 1;
            model_changeAngle = ['knee_angle_',side];
            model_changeDeg = -90;
elseif strcmp(muscle_toScale,'gastrocnemii')
            coord_name = ['ankle_angle'];
            model_toDiffPos = 0;
elseif strcmp(muscle_toScale,'hamstrings')
            coord_name = ['knee_angle'];
            model_toDiffPos = 1;
            model_changeAngle = ['hip_flexion_',side];
            model_changeDeg = 90;    
end
coord_name_side = [coord_name,'_',other_side];

% Find joint index in coordinates
idx_joint = find(strcmp(coordinates,coord_name_side));

% Create Qs (joint angles) and Qdot (angular velocity)
ROM = linspace((CE_angle-20)*pi/180,(CE_angle+20)*pi/180,25); % Range of motion
n = length(ROM);

Qs = zeros(n,length(coordinates));
Qdots = zeros(n,length(coordinates));
Qs(:,idx_joint) = ROM; 

if model_toDiffPos
Qs(:,strcmp(coordinates,model_changeAngle)) = ones(n,1)*(model_changeDeg*pi/180); %knee_angle_r 90°
end