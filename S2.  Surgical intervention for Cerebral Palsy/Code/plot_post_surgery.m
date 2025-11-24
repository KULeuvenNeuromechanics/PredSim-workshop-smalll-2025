function [] = plot_post_surgery(result_paths)
%%% plot results SMALLL
%%% pre surgery
% Original authors: Ellis Van Can
% Original date: November 23,2025
clear figure_settings
%% General settings
% These settings will apply to all figures
%%%%% IK
% Sequences
IKseq_pelvis = [{'pelvis_list'} {'pelvis_tx'} {'pelvis_ty'} {'lumbar_extension'} ];
IKseq_right = [{'hip_flexion_r'} {'knee_angle_r'} {'ankle_angle_r'}];
IKseq_left = [{'hip_flexion_l'} {'knee_angle_l'} {'ankle_angle_l'} ];

% Colors
colors_torso_pelvis = ([1, 35, 60;22, 73, 106;42, 111, 151;70, 138, 173;104, 163, 191;136, 184, 206;167, 205, 221]/255);
colors_left = ([38, 23, 26; 78, 36, 35;118, 48, 43;157, 64, 56;196, 80, 69;206, 110, 100;216, 139, 131]/255);
colors_right = ([8, 28, 21; 35, 67, 50;61, 106, 79;94, 145, 108;132, 172, 143;175, 202, 182;218, 231, 221]/255);

colors_PredSim = [247, 185, 61; 72, 205, 134; 70, 79, 240] / 255;
% colors_other_pelvis =([34,34,34; 72,96,173;128,82,134;177,129,177]/255);
% colors_other_right = ([34,34,34; 73,184,0;128,82,134;177,129,177]/255); % 53,134,0
% colors_other_left = ([34,34,34; 230,107,76;128,82,134;177,129,177]/255); % 199,62,29 als 2e
colors_other_pelvis =([34,34,34; 128,82,134;72,96,173;177,129,177]/255);
colors_other_right = ([34,34,34; 128,82,134;73,184,0;177,129,177]/255); % 53,134,0
colors_other_left = ([34,34,34; 128,82,134;230,107,76;177,129,177]/255); % 199,62,29 als 2e
%% pre
% Construct a cell array with full paths to files with saved results for
% which you want to appear on the plotted figures.


legend_names = {'Inverse Kinematics','Post-surgery'};


%% IK files
IKResultsFolder = fullfile('C:\GBW_MyPrograms\PredSim-workshop-smalll-2025\S2.  Surgical intervention for Cerebral Palsy\IK');
FilePath.IK.trial1 = [fullfile(IKResultsFolder,'CP_SMALLL_IK_post_1'),'.mot'];
IK.trial1 = ReadMotFile(FilePath.IK.trial1);

%%%%% trial 1 
GC.trial1{1} = [1460:2503];
GC.trial1{2} = [2503:3747];
GC.trial1{3} = [3747:4933];

% find indices in time vector that match FC instances
GC_IK.trial1{1} = [find(IK.trial1.data(:,1)==round((GC.trial1{1}(1)/1000),2)):find(IK.trial1.data(:,1)==round((GC.trial1{1}(end)/1000),2))];
GC_IK.trial1{2} = [find(IK.trial1.data(:,1)==round((GC.trial1{2}(1)/1000),2)):find(IK.trial1.data(:,1)==round((GC.trial1{2}(end)/1000),2))];
GC_IK.trial1{3} = [find(IK.trial1.data(:,1)==round((GC.trial1{3}(1)/1000),2)):find(IK.trial1.data(:,1)==round((GC.trial1{3}(end)/1000),2))];

IK.trial1.GC{1} = IK.trial1.data(GC_IK.trial1{1},2:end);
IK.trial1.GC{2} = IK.trial1.data(GC_IK.trial1{2},2:end);
IK.trial1.GC{3} = IK.trial1.data(GC_IK.trial1{3},2:end);

%%%%% trial 2
FilePath.IK.trial2 = [fullfile(IKResultsFolder,'CP_SMALLL_IK_post_2'),'.mot'];
IK.trial2 = ReadMotFile(FilePath.IK.trial2);

GC.trial2{1} = [2383:3531];
GC.trial2{2} = [3531:4692];


% find indices in time vector that match FC instances
GC_IK.trial2{1} = [find(IK.trial2.data(:,1)==round((GC.trial2{1}(1)/1000),2)):find(IK.trial2.data(:,1)==round((GC.trial2{1}(end)/1000),2))];
GC_IK.trial2{2} = [find(IK.trial2.data(:,1)==round((GC.trial2{2}(1)/1000),2)):find(IK.trial2.data(:,1)==round((GC.trial2{2}(end)/1000),2))];

%IK
IK.trial2.GC{1} = IK.trial2.data(GC_IK.trial2{1},2:end);
IK.trial2.GC{2} = IK.trial2.data(GC_IK.trial2{2},2:end);

%%%% trial 3
FilePath.IK.trial3 = [fullfile(IKResultsFolder,'CP_SMALLL_IK_post_3'),'.mot'];
IK.trial3 = ReadMotFile(FilePath.IK.trial3);

GC.trial3{1} = [2469:3603];
GC.trial3{2} = [3603:4758];


% find indices in time vector that match FC instances
GC_IK.trial3{1} = [find(IK.trial3.data(:,1)==round((GC.trial3{1}(1)/1000),2)):find(IK.trial3.data(:,1)==round((GC.trial3{1}(end)/1000),2))];
GC_IK.trial3{2} = [find(IK.trial3.data(:,1)==round((GC.trial3{2}(1)/1000),2)):find(IK.trial3.data(:,1)==round((GC.trial3{2}(end)/1000),2))];

% IK
IK.trial3.GC{1} = IK.trial3.data(GC_IK.trial3{1},2:end);
IK.trial3.GC{2} = IK.trial3.data(GC_IK.trial3{2},2:end);

% %% check IK
% figure
% for trialNum = [1 2 3]
%     for j = 1:length(IK.(sprintf('trial%d', trialNum)).GC)
%         for i = 1:size(IK.trial2.GC{1},2)
%         subplot(8,4,i)
%         hold on
%         plot(IK.(sprintf('trial%d', trialNum)).GC{j}(:,i)*1000)
%         title(IK.trial2.names(i+1))
%         end
%     end
% end
% legend()
%% IK
%% mean and sd
IK_names =  {'pelvis_tilt',  'pelvis_tx', 'pelvis_ty',...
    'hip_flexion_r',  'knee_angle_r', 'ankle_angle_r',...
    'hip_flexion_l',...
    'knee_angle_l', 'ankle_angle_l', 'lumbar_extension'};
 [~, idx_IK_angles] = ismember(IK_names,IK.trial1.names);
 
for i_Angle = idx_IK_angles-1
    AngleName = cell2mat(IK.trial1.names(i_Angle+1));
    i_resampled = 1;
    for trialNum = [1 2]
        for  j = 1:length(IK.(sprintf('trial%d', trialNum)).GC)
        IK.(sprintf('trial%d', trialNum)).Resampled{j}(:,i_Angle) = ResampleNoEdgeEffects(IK.(sprintf('trial%d', trialNum)).GC{j}(:,i_Angle),100);
        IK.(sprintf(AngleName))(:,i_resampled) = IK.(sprintf('trial%d', trialNum)).Resampled{j}(:,i_Angle);
        i_resampled = i_resampled + 1;
        end
    end

end
IK.names = IK.trial1.names(idx_IK_angles);

for idx_AngleIK = 1:length(IK.names)
    AngleName = IK.names{idx_AngleIK};
    IK.(sprintf(AngleName)) = IK.(sprintf(AngleName))(:,2:end);
    for k = 1:100
        IK.mean.(sprintf(AngleName))(k,:) = mean(IK.(sprintf(AngleName))(k,:))*1000;
        IK.stdev.(sprintf(AngleName))(k,:) = std(IK.(sprintf(AngleName))(k,:))*1000;
    end
end


fig4 = figure;
colororder({'k','k'});
for idx_AngleIK = 1:length(IK.names)
    AngleName = IK.names{idx_AngleIK};
    subplot(4,3,idx_AngleIK)
    hold on
    % plot(IK.(sprintf(MuscleName)))
    % plot(IK.mean.(sprintf(MuscleName)),'LineWidth',5)
    plus_stdev.(sprintf(AngleName)) = (IK.mean.(sprintf(AngleName)) + (IK.stdev.(sprintf(AngleName))))/1000;
    min_stdev.(sprintf(AngleName)) = (IK.mean.(sprintf(AngleName)) - (IK.stdev.(sprintf(AngleName))))/1000;

    fill([1:length(IK.mean.(sprintf(AngleName))), fliplr(1:length(IK.mean.(sprintf(AngleName))))], ...
    [min_stdev.(sprintf(AngleName))', fliplr(plus_stdev.(sprintf(AngleName))')], ...
    [140, 128, 128]/255,'FaceAlpha',0.5,'EdgeAlpha',0.75,'EdgeColor',[140, 128, 128]/255)

    title(IK_names(idx_AngleIK),interpreter="none")
end
%% plot results in it
% fig4 = figure;
hold on
colororder({'k','k'});

% [~, idx_results_order] = ismember(IK_names,IK.trial1.names);
% determine subplot size
n_rows = 4;
n_cols = 3;

figure_settings.name = 'all_angles';
figure_settings.dofs = {'all_coords'};
figure_settings.variables = {'Qs'};

load(result_paths,'R','model_info');


% kinematics/kinetics
for idx_AngleIK = 1:length(IK.names)
    AngleName = IK.names{idx_AngleIK};
    find(strcmp(R.colheaders.coordinates,AngleName))

     ydata= R.kinematics.(figure_settings.variables{1});


        idx_coordinate = strcmp(R.colheaders.coordinates,AngleName);
        y_i = ydata(:,idx_coordinate);  
        x_i = linspace(1,100,length(y_i));
        subplot(n_rows,n_cols,idx_AngleIK)
       
        plot(x_i,y_i,'-',LineWidth=2)
end
legend1 = legend(legend_names);
set(legend1,...
    'Position',[0.677123632983556 0.103763141299236 0.236785717759814 0.118925488587332]);
sgtitle('Post-surgery: simulation results vs. experimental kinematics')
end