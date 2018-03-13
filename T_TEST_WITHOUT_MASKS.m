
%% Description:
% Automatic SPM batches creator
% General t-tests without masks (two groups)
% For Jacek's project (with two tasks), but can be customized for any other

%% File part:
% First group directories for each subject, e.g. dir_1, dir_2:
FirstGroup = {'dir_1','dir_2'};

% Second group directories for each subject, e.g. dir_3, dir_4:
SecondGroup = {'dir_3','dir_4'};

% Contrasts used (names e.g. con_1, con_2)
Contrasts = {'con_1','con_2'};

%% Automatic script part:
    for CNTN = Contrasts     
        CNTN_1 = char(CNTN);      
        
% Different files from each task saved in different directories        
        for Task = 1:2
        % In this project we had two tasks
                    
                    dict_name = sprintf('\\WYNIKI\\%d zadanie %s\\Kontrast %s',Task,CNTN_1);
                    
                    matlabbatch{1}.spm.stats.factorial_design.dir = {dict_name};

                    for number = 1:numel(FirstGroup)
                        Participant = char(FirstGroup(number));
                        dict_name = sprintf('\\Badanie%d\\%s\\%s.nii,1',Task,Participant,CNTN_1);                                 
                        matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1(number,:) = { dict_name }; 
                        clear dict_name;
                    end

                    for number = 1:numel(SecondGroup)
                        Participant = char(SecondGroup(number));
                        dict_name = sprintf('\\Badanie%d\\%s\\%s.nii,1',Task,Participant,CNTN_1);                                 
                        matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2(number,:) = { dict_name }; 
                        clear dict_name;
                    end

        matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
       
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
                
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
        matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat')); 
        matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
        matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'FirstGroup > SecondGroup';
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'FirstGroup < SecondGroup';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.delete = 0;

        Result_dict = sprintf('BATCHES\\T_TEST_BETWEEN_GROUPS_task_%d_%s.mat',Task,CNTN_1);
        save(Result_dict,'matlabbatch')
        clear matlabbatch
        end
    end