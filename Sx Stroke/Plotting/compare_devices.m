clear all; close all; clc

pathRepo = 'C:\GBW_MyPrograms\PredSim';
pathResults = 'C:\GBW_MyPrograms\PredSimResults';

ks = [1 13 14 15 16 17 18 19 20];

for k = 1:length(ks)
    result_paths{k} = fullfile(S.misc.save_folder,['gait1018_v', num2str(ks(k)), '.mat']);
    legend_names{k} = ['gait1018_v', num2str(ks(k)), '.mat'];
end

% add path to subfolder with plotting functions
addpath(fullfile(pathRepo,'PlotFigures'))

figure_settings(1).name = 'all_angles';
figure_settings(1).dofs = {'all_coords'};
figure_settings(1).variables = {'Qs'};
figure_settings(1).savepath = [];
figure_settings(1).filetype = {};

% call plotting function
plot_figures(result_paths, legend_names, figure_settings);
