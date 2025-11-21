clear all; close all; clc

% change this to your own paths
pathRepo = 'C:\GBW_MyPrograms\PredSim';
pathResults = 'C:\GBW_MyPrograms\PredSimResults';

% versions that we want to plot
vs = [1 7];

figure(1)
plot_data();

% plot all versions
for k = 1:length(vs)
    
    result_paths = fullfile(pathResults,['gait1018\gait1018_v', num2str(vs(k)), '.mat']);
    legend_name = ['gait1018_v', num2str(vs(k)), '.mat'];

    load(result_paths,'R','model_info');
    
    % get orthosis stiffness
    if ~isempty(R.S.orthosis.settings)
        k_ankle = R.S.orthosis.settings{1}.ankle_stiffness;
    else
        k_ankle = 0;
    end
    
    % get TA strength
    TA_strength = model_info.muscle_info.parameters(9).muscle_strength;
    txt = ['k = ', num2str(k_ankle), ' - S = ', num2str(TA_strength)];
    
    is = [8 6 4 9 7 5];
    
    figure(1)
    for i = 1:6
        subplot(2,3,i)
        plot(R.kinematics.Qs(:,is(i)),'DisplayName',txt, 'linewidth', 1.5); hold on
        title(strrep(R.colheaders.coordinates{is(i)}, '_', '-')); hold on
        ylim([-70 50])
        box off
        ylabel('Angle (deg)')
        xlabel('Gait cycle (%)')
    end
    
    legend show
    legend('location', 'best')
    legend boxoff
    
end

%%
figure(1)
set(gcf, 'units', 'centimeters', 'position', [10 10 20 15])

filename = which('compare_devices');
folder = filename(1:end-18);
cd(folder);

% exportgraphics(gcf,'Fig.png')


