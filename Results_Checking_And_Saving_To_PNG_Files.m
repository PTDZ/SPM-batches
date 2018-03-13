%%
% FILE NAMES PART

% MASK NAMES (e.g. listed below)
NazwyMasek = {'Temporal_Lobe.img','Temporal_Mid_L.img','Temporal_Mid_R.img'};

% CONTRASTS & TASKS USED (e.g. listed below)
Kontrasty = {'1-2 zadanie GrupaHigh\\Kontrast con_0011','1-2 zadanie GrupaHigh\\Kontrast con_0012'};
        
% RESULTS DIRECTORIES (e.g. listed below)
Wyniki = {'Results_1','Results_2'};

%%
for wynik = Wyniki
    for mask = NazwyMasek
        for kontrast = Kontrasty
        
        wyn = char(wynik);
        kon = char(kontrast);
        mas = char(mask);
          
        nazwa_folderu = sprintf('D:\\Resting state - zad. Jacka\\NOWE\\%s\\Maska %s\\%s\\SPM.mat',wyn,mas,kon);
        ExistDir = exist(nazwa_folderu, 'file');
        
        if ExistDir == 2
            matlabbatch{1}.spm.stats.results.spmmat = {nazwa_folderu};
            matlabbatch{1}.spm.stats.results.conspec.titlestr = '';
            matlabbatch{1}.spm.stats.results.conspec.contrasts = Inf;
            matlabbatch{1}.spm.stats.results.conspec.threshdesc = 'FWE';
            matlabbatch{1}.spm.stats.results.conspec.thresh = 0.05;
            matlabbatch{1}.spm.stats.results.conspec.extent = 0;
            matlabbatch{1}.spm.stats.results.conspec.conjunction = 1;
            matlabbatch{1}.spm.stats.results.conspec.mask.none = 1;
            matlabbatch{1}.spm.stats.results.units = 1;
            matlabbatch{1}.spm.stats.results.export{1}.ps = true;
            matlabbatch{1}.spm.stats.results.export{2}.jpg = true;
                
                Kom1 = kon;
                newStr = strrep(Kom1,'\\','_');
                
                folder_wynikowy = sprintf('BATCHE_WYNIKI\\Wyniki_%s_%s_%s.mat',wyn,mas,newStr);
                save(folder_wynikowy,'matlabbatch')
                clear matlabbatch
                
        else
            continue
        end   

        end
    end
end
