function [Qs,Qdots,idx_joint,coord_name] = get_CE_position_iliopsoas(delta_hip,side,coordinates)
% Original authors: Ellis Van Can
% Original date: November 19,2024
if strcmp(side,'r')
    other_side = 'l';
elseif strcmp(side,'l')
    other_side = 'r';
end
coord_name = 'hip_flexion';
coord_name_side = [coord_name,'_',other_side];
% joint index
idx_joint = find(strcmp(coordinates,coord_name_side));

% Create Qs (joint angles) and Qdot (angular velocity)
ROM = linspace((delta_hip-20)*pi/180,(delta_hip+20)*pi/180,25); % Range of motion
nr = length(ROM);
ncoords = length(coordinates);
Qs = zeros(nr,ncoords);
Qdots = zeros(nr,ncoords);

% QS
Qs(:,idx_joint) = ROM; 