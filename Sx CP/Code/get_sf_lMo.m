function [sf_lMo] = get_sf_lMo(muscle_toScale,side,sf_lMo)
% Original authors: Ellis Van Can
% Original date: November 19,2024
if strcmp(muscle_toScale, 'gastrocnemii')
    prompt = { ...
    'NOTE: If these values have not been scaled , leave them at 1.',...
    ['Enter scaling factor for soleus ',side ' :']};
    dlgtitle = 'Scaling factors for distal muscles';
    dims =  [0 70; 1 70];

        if isfield(sf_lMo.(side), 'soleus') && ~isempty(sf_lMo.(side).soleus)
            default_soleus = num2str(sf_lMo.(side).soleus);
        else
            default_soleus = '1';
        end

    definput = {'', default_soleus};  
    inputs = str2double(inputdlg(prompt, dlgtitle, dims, definput));
    sf_lMo.(side).soleus = inputs(2);

elseif strcmp(muscle_toScale, 'hamstrings')
        prompt = { ...
    'NOTE: If these values have not been scaled , leave them at 1.',...
    ['Enter scaling factor for soleus ',side ' :'],...
    ['Enter scaling factor for gastrocnemii ',side ' :']};
    dlgtitle = 'Scaling factors for distal muscles';
    dims =  [0 70; 1 70; 1 70];

        if isfield(sf_lMo.(side), 'soleus') && ~isempty(sf_lMo.(side).soleus)
            default_soleus = num2str(sf_lMo.(side).soleus);
        else
            default_soleus = '1';
        end

        if isfield(sf_lMo.(side), 'gastrocnemii') && ~isempty(sf_lMo.(side).gastrocnemii)
            default_gastrocnemii = num2str(sf_lMo.(side).gastrocnemii);
        else
            default_gastrocnemii = '1';
        end

    definput = {'', default_soleus, default_gastrocnemii}; 

    inputs = str2double(inputdlg(prompt, dlgtitle, dims, definput));
    sf_lMo.(side).soleus = inputs(2);
    sf_lMo.(side).gastrocnemii = inputs(3);
elseif  strcmp(muscle_toScale, 'iliopsoas')

        prompt = { ...
            'NOTE: If these values have not been scaled yet, leave them at 1.',...
            ['Enter scaling factor for soleus ',side ' :'], ...
             ['Enter scaling factor for gastrocnemii ',side ' :'], ...
            ['Enter scaling factor for hamstrings ',side ' :']};
        dlgtitle = 'scaling factors other muscles';
        dims =  [0 70; 1 70; 1 70; 1 70];

        if isfield(sf_lMo.(side), 'soleus') && ~isempty(sf_lMo.(side).soleus)
            default_soleus = num2str(sf_lMo.(side).soleus);
        else
            default_soleus = '1';
        end

        if isfield(sf_lMo.(side), 'gastrocnemii') && ~isempty(sf_lMo.(side).gastrocnemii)
            default_gastrocnemii = num2str(sf_lMo.(side).gastrocnemii);
        else
            default_gastrocnemii = '1';
        end

        if isfield(sf_lMo.(side), 'hamstrings') && ~isempty(sf_lMo.(side).hamstrings)
            default_hamstrings = num2str(sf_lMo.(side).hamstrings);
        else
            default_hamstrings = '1';
        end

    definput = {'', default_soleus, default_gastrocnemii,default_hamstrings};  
    % 
    inputs = str2double(inputdlg(prompt, dlgtitle, dims, definput));
    sf_lMo.(side).soleus = inputs(2);
    sf_lMo.(side).gastrocnemii = inputs(3);
    sf_lMo.(side).hamstrings = inputs(4);
end
end