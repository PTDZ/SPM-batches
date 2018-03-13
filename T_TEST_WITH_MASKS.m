%% Description:
% Automatic SPM batches creator
% General t-tests with masks (two groups)
% For Jacek's project (with two tasks), but can be customized for any other

%% File part:
% First group directories for each subject, e.g. dir_1, dir_2:
GrupaHigh = {'dir_1','dir_2'};

% Second group directories for each subject, e.g. dir_3, dir_4:
GrupaLow = {'dir_3','dir_4'};
    
% STRING - FOR SPRINTF FUNCTION; CHAR FOR LOOP
Grupa = {GrupaHigh, GrupaLow};
Grupa_Str = ["GrupaHigh","GrupaLow"];

% MASK NAMES (e.g. listed below)
NazwyMasek = {'Temp_Inf_L.img','Temp_Inf_R.img','Temporal_Lobe.img'};

% CONTRASTS USED
Kontrasty = {'con_0011','con_0012','con_0013','con_0014'};

%%
for mask = NazwyMasek
    for kontrast = Kontrasty
        
        kon = char(kontrast);
        mas = char(mask);

        for gr = Grupa
            for gr2 = Grupa_Str
            
                nazwa_folderu = sprintf('\\WYNIKI\\Maska %s\\1-2 zadanie %s\\Kontrast %s',mas,gr2,kon);
                matlabbatch{1}.spm.stats.factorial_design.dir = {nazwa_folderu};

                for number = 1:numel(gr{1})
                     badany = convertCharsToStrings(gr{1}{number});
                     nazwa_folderu1 = sprintf('Badanie1\\%s\\%s.nii,1',badany,kon);   
                     nazwa_folderu2 = sprintf('Badanie2\\%s\\%s.nii,1',badany,kon);  
                     matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(number).scans = { 
                                                                                              nazwa_folderu1 
                                                                                              nazwa_folderu2 }; 
                end

                matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
                matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
                matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
                matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
                matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
                matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;

                nazwa_folderu_maski = sprintf('\\Maski anatomiczne\\%s,1',mas);
                matlabbatch{1}.spm.stats.factorial_design.masking.em = {nazwa_folderu_maski};

                matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
                matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
                matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
                matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
                matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
                matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
                matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
                matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'B1 > B2';
                matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
                matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
                matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'B2 > B1';
                matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
                matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
                matlabbatch{3}.spm.stats.con.delete = 0;


                folder_wynikowy = sprintf('BATCHE\\T_TEST_1_2_ZAD_%s_Grupa_%s_%s.mat',mas,gr2,kon);
                save(folder_wynikowy,'matlabbatch')
                clear matlabbatch
            end
        end
        
       for zadanie = 1:2
            
                    nazwa_folderu = sprintf('\\WYNIKI\\Maska %s\\%d zadanie %s\\Kontrast %s',mas,zadanie,kon);
                    matlabbatch{1}.spm.stats.factorial_design.dir = {nazwa_folderu};


                    for number = 1:numel(GrupaHigh)
                        badany = char(GrupaHigh(number));
                        nazwa_folderu = sprintf('\\Badanie%d\\%s\\%s.nii,1',zadanie,badany,kon);                                 
                        matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1(number,:) = { nazwa_folderu }; 
                        clear nazwafolderu;
                    end

                    for number = 1:numel(GrupaLow)
                        badany = char(GrupaLow(number));
                        nazwa_folderu = sprintf('\\Badanie%d\\%s\\%s.nii,1',zadanie,badany,kon);                                 
                        matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2(number,:) = { nazwa_folderu }; 
                        clear nazwafolderu;
                    end

        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
        matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;
        
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {nazwa_folderu_maski};
                
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
        matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat')); 
        matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
        matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'High > Low';
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
        matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Low > High';
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
        matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        matlabbatch{3}.spm.stats.con.delete = 0;

        folder_wynikowy = sprintf('BATCHE\\T_TEST_HIGH_LOW_zad_%d_%s_%s.mat',zadanie,mas,kon);
        save(folder_wynikowy,'matlabbatch')
        clear matlabbatch
        end
    end
end