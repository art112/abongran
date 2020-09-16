#!/usr/bin/env bash

# Pour specifier 10 minutes de 'wallclock time'
#$ -l h_rt=12:00:00

# Pour demander 1 gigabyte de mémoire
#$ -l s_rss=4G

# Pour nommer le job
#$ -N NaonedeBreizh

# Pour déclarer votre projet sous lequel le job sera exécuté
#$ -P P_nantes

# Pour fusionner les sorties stdout et stderr dans un seul fichier
#$ -j y

# Les sorties stdout et stderr se trouveront par défaut dans votre HOME
# pour les placer ailleurs par ex. sous votre HOME :
#$ -o $HOME/.


## A lancer sur la ferme !!!
## Permet de lancer en multi ou non tous les projets disponilbe sur la ferme


Test_FARM=0 # 0 or 1
Dossier_Test="45976979.1.interactive" # cd /scratch || fichier crée automatiquement

FichierdeRenvoi=Resultat.txt

Throng="/pbs/throng/nantes/PRISMA/abongran"
Sps="/sps/hep/nantes/PRISMA/abongran"

PathLaunchingFile=${Sps}

# echo Running on host `hostname` >> ${FichierdeRenvoi} # Done le nom du system
HOSTNAME=`hostname`

# Avail gate ccin2p3:
#     - 8.1.p01
#     - 8.2
#     - 9.0

# V_GATE="8.1.p01"

# optionVersion=(8.2 9.0) 
optionenesigma=(0 0.68 1)

# optionenesigma=(0)

# optionenesigma=(2)

# optionenesigma=(0 0.30 0.68 1)

# optionenesigma=(0 0.35 0.68)

# optionenesigma=(0.68)
optionVersion=(9.0) 
#  optionenesigma=(0)


lenoptionVersion=${#optionVersion[@]}  # nombre d'éléments dans le tableau
lenoptionenesigma=${#optionenesigma[@]}  # nombre d'éléments dans le tableau


for ((ov=0; ov<$lenoptionVersion; ov++)); do

for ((oes=0; oes<$lenoptionenesigma; oes++)); do

V_GATE=${optionVersion[ov]}

#energie
Beam_ene_mono="68"
Beam_ene_mono_Unit="MeV"

Beam_ene_type="Gauss"
Beam_ene_sigma=${optionenesigma[oes]}
Beam_ene_sigma_Unit="MeV"

# Unit M : million k : mille | nothing
Coef_EVENT_NB="150"
EVENT_NB_Unit="M"

# P2 30 M

### If avaible check***
# Launch multi


    ### P1
    z_Projet_Arronax_Compensator_design=1
    
    TypeSpaceDIskForSave_P1="Sps"
    
    ## VOIR DIRECTEMENT DANS LA MACRO
    
    # ACDv2 Correction des volume mere fille pour le z_Projet_Collimateur
    # ACDv3 Ajout de l'énergie cinétique dans le volume cube after
    # ACDv4 Correction de v2T -> volume support tungsten en G4_AIR
    # ACDv4.2.1 : Remplacement du cax REF 0.68 MeV
    #4.3 COrrection PhaseSpace Cuivre augmentation taille cylindre /!\ diminue la dose totale
    
#     ACDv4.3.1mm_verif
    
    ## Pour l'article 
#     vACDv5_a_200m_Article_Manip_ZebraFish_110320_v1_BIC_G4_WATER
    # ManipZebra vACDv5_a_200m_Article_Manip_ZebraFish_110320_v1_BIC_G4_WATER 20M
    # WColi vACDv5_a_200m_2_Article_Ligne_ICO_v2T_WColli_BIC_G4_WATER 50M
    
#     vACDv5_a_200m_2_Article_Ligne_ICO_v2T_WColli_BIC_G4_WATER
    
    VersionConfig_P1="ACDv5_a_200m_5_Article"
    
#     VersionConfig_P1="ACDv5_a_200m_Article"
    
    Create_Phase_Space_P1=0
#     UsePhaseSpace_P1=0
    
    WALLCLOCKTIME_P1="72:00:00"
    RAM_P1="4G"
    
    Geometrie_Folder_P1="Ligne_ICO"
    # v2 v2T v2WT whithout tungsten v2T_WColli pas de variation de l'epaisseur du colli 
    Geometrie_Version_P1="v2T_WColli"
    
#     Geometrie_Folder_P1="Ligne_Seule"
    # v2 v2T v2WT whithout tungsten v2T_WColli pas de variation de l'epaisseur du colli 
#     Geometrie_Version_P1="v2T"
    
    
#     Geometrie_Folder_P1="Manip_ZebraFish_110320"
#     Geometrie_Version_P1="v1"
    
    Physics_List_P1="BIC" # BIC or BIC_HP
    Cube_After_Matter_P1="G4_WATER"
    # G4_PLEXIGLASS G4_WATER
    
    Pourcentage_Resolution_Epaisseur=5 # % only for 1 2 
    
    ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
    if [ ${Create_Phase_Space_P1} = "1" ]
    then
    option=(0) 
    else
#     option=(0 1 2 3 4) 
     option=(0 1 2 3 4 5 6 7 8 9 10 11) 
#      option=(9 10) 
#      option=(11) 
#      option=(7 8) 
     
#      option=(0)
     
#     option=(0 5 6) 
    fi 
    
    len3=${#option[@]}  # nombre d'éléments dans le tableau


    ### P2    
    z_Projet_Souris=0

    TypeSpaceDIskForSave_P2="Sps"
    
    ## VOIR DIRECTEMENT DANS LA MACRO
    
    # Sourisv4 Utilisation de la géométrie corrigée v2T
    
    VersionConfig_P2="Sv5.2"
    # Sv5.0 Add option Physics List | Add PhaseSpace souris | Dose actor .hdr | Integration de cubeAftetr
    # 5.1 /gate/physics/SetMaxStepSizeInRegion InputImageOfProtocol 0.1 mm 
    #     /gate/physics/Proton/SetCutInRegion InputImageOfProtocol 0.01 mm
    
    ## false or text version v1
    Type_Image_Input="Crop_v1" # CT2 Crop_v1 Crop_crane_v1 Crop_abdomen_v1 Crop_abdomen_anterieur_v1
    
    Physics_List="BIC" # BIC or BIC_HP
    
    ## Permet de sauver toutes les step dans phase space actor utilise pour le graph Ekin fct Z
    Authorize_AllStepAndZ_Souris="false"
    Authorize_AllStepAndZ_Cube_After="false"
    
    Add_PhaseSpace_Kapton_Colli="#" ## Pour le test Par defaut input souris || activer en laissant un espace
    # if needed todo Add_PhaseSpace_BetaPlus="#"
    
    Add_Actor_Neutron_souris="#" # Actor neutron only with BIC_HP
    
    Cube_After_Matter="G4_WATER"
    
#     Create_Phase_Space_P2=1
    Distribute_Sim_P2=1
    Distribute_Nb=17
    
#     Distribute_Nb=17
    
    UsePhaseSpace_P2=0
    
    WALLCLOCKTIME_P2="50:00:00"
    RAM_P2="6G"
    
    Geometrie_Folder_P2="Ligne_ICO"
    Geometrie_Version_P2="v2T" # v1 v1T v2 v2T
    
    ##
    Collimator_Diameter_P2=1 #cm # Ref 1 cm
    
    
    ## For 5 6 Pos 
    Shift_Position_InputImageOfProtocol_P2="0.5" # cm
    
    ## For 7 & 8
    Incertitude_Ivalue_P2=4 # % 4, 6 avail
    
    
#     Pourcentage_Resolution_Epaisseur=(5 4 3 2 1)
#     len_PRE=${#Pourcentage_Resolution_Epaisseur[@]}
    
    ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
#    option_P2=(0 1 2 3 4) 
    option_P2=(7 8) 
#     option_P2=(0) 
    
#     option_P2=(5 6) 
    
    len3_P2=${#option_P2[@]}  # nombre d'éléments dans le tableau

    
    ### P3
    z_Projet_Manip_ZebraFish_11_03_20=0
    
    TypeSpaceDIskForSave_P3="Sps"
    
    ## VOIR DIRECTEMENT DANS LA MACRO "MZfv3_0.1"
    # v4 
    VersionConfig_P3="ROOS_v1_0.1_SV12"
    ### 4.2 X Y 100 micro
    Create_Phase_Space_P3=0
    
    WALLCLOCKTIME_P3="48:00:00"
    RAM_P3="4G"
    
#     Ligne_Seule_CI/Config1_v1
    
    Geometrie_Folder_P3="Ligne_Seule_CI"
    # v1 v1_XS v1_Target
    
    Vconfig=2
    
    Geometrie_Version_P3="Config${Vconfig}_v1"
    
#     /home/gate/nantes_sps/abongran/All_Simulation/geometry/Manip_ZebraFish_110320/v1/Actor_Ligne.mac
    
    # G4_POLYVINYL_CHLORIDE (PMMA) || G4_WATER
    Material_Target_P3="G4_WATER"
    
    # If avaible 
    StackName="Stack_Manip_13_08_20_config${Vconfig}"
    
    ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
    if [ ${Create_Phase_Space_P3} = "1" ]
    then
    option_P3=(0) 
    else
#     option=(0 1 2 3 4) 
    option_P3=(0) 
    fi 
    len3_P3=${#option_P3[@]}  # nombre d'éléments dans le tableau
    
    
#     z_Projet_Manip_ZebraFish_11_03_20=0
#     
#     TypeSpaceDIskForSave_P3="Sps"
#     
#     ## VOIR DIRECTEMENT DANS LA MACRO "MZfv3_0.1"
#     # v4 
#     VersionConfig_P3="MZfv4.3"
#     ### 4.2 X Y 100 micro
#     Create_Phase_Space_P3=0
#     
#     WALLCLOCKTIME_P3="48:00:00"
#     RAM_P3="4G"
#     
#     Geometrie_Folder_P3="Manip_ZebraFish_110320"
#     # v1 v1_XS v1_Target
#     Geometrie_Version_P3="v1"
#     
# #     /home/gate/nantes_sps/abongran/All_Simulation/geometry/Manip_ZebraFish_110320/v1/Actor_Ligne.mac
#     
#     # G4_POLYVINYL_CHLORIDE (PMMA) || G4_WATER
#     Material_Target_P3="G4_PLEXIGLASS"
#     
#     # If avaible 
#     StackName="Stack_ManipZebra_28_05_20_v2"
#     
#     ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
#     if [ ${Create_Phase_Space_P3} = "1" ]
#     then
#     option_P3=(0) 
#     else
# #     option=(0 1 2 3 4) 
#     option_P3=(0) 
#     fi 
#     len3_P3=${#option_P3[@]}  # nombre d'éléments dans le tableau
    
    ### P4
    z_Projet_Collimateur=0
    
    TypeSpaceDIskForSave_P4="Sps"
    
    ## VOIR DIRECTEMENT DANS LA MACRO MZfv2 MZfv2_cut1_Air MZfv2_cut0.1
    VersionConfig_P4="MZfv2_cut0.1"
    
    Create_Phase_Space_P4=0
    
    WALLCLOCKTIME_P4="30:00:00"
    RAM_P4="4G"
    
    Geometrie_Folder_P4="Ligne_ICO"
    # v1 v1_XS v1_Target v2T_colli v2T_WTColli (without tungsten)
    Geometrie_Version_P4="v2T_colli"
    
#     /home/gate/nantes_sps/abongran/All_Simulation/geometry/Manip_ZebraFish_110320/v1/Actor_Ligne.mac
    
    # G4_POLYVINYL_CHLORIDE (PMMA) || G4_WATER
#     Material_Target_P4="G4_POLYVINYL_CHLORIDE"
    
    
    ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
    if [ ${Create_Phase_Space_P4} = "1" ]
    then
    option_P4=(0) 
    else
#      option_P4=(0 1 2 3 4 5) 
     option_P4=(0 2 3 4 5) 
#      option_P4=(4 5) 
#     option_P4=(0) 
    fi 
    len3_P4=${#option_P4[@]}  # nombre d'éléments dans le tableau
    
    ### P5 TODO
    z_Projet_Instrumentation=0
    
    TypeSpaceDIskForSave_P5="Sps"
    
    VersionConfig_P5="Instru1"
    
    Create_Phase_Space_P5=0
#     UsePhaseSpace_P5=0
    
    WALLCLOCKTIME_P5="47:00:00"
    RAM_P5="4G"
    
    Geometrie_Folder_P5="Ligne_ICO"
    # v2 v2T v2WT whithout tungsten v2T_WColli pas de variation de l'epaisseur du colli 
    Geometrie_Version_P5="v2T_WColli"
    
    Physics_List_P5="BIC" # BIC or BIC_HP

    
    ## Detecteur dispo Silicium Film Stack Cube_After ....
    
    Detector_1_P5="Silicium"
    Detector_1_P5_Position="10" ; Detector_1_P5_Unit="mm"
    Detector_2_P5="Film"
    Detector_2_P5_Position="10" ; Detector_2_P5_Unit="mm"
    
    Detector_After_P5="0" # 0 or 1 Cube
    Cube_After_Matter_P5="G4_WATER"
    ## Plament After Detector 1 & 2 
    
    ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
    if [ ${Create_Phase_Space_P5} = "1" ]
    then
    option_P5=(0) 
    else
#     option_P5=(0 1 2 3 4) 
#      option_P5=(1 2) 
    option_P5=(0) 
    fi 
    
    len3_P5=${#option_P5[@]}  # nombre d'éléments dans le tableau
    
    
    ### P6
    z_Projet_ROOS=0
    
    if [ ${z_Projet_ROOS} = "1" ]
    then
    
        TypeSpaceDIskForSave_P6="Sps"
        
        ## VOIR DIRECTEMENT DANS LA MACRO "MZfv3_0.1"
        # v4 
        VersionConfig_P6="ROOS_v8"
        
        ### 4.2 X Y 100 micro
        Create_Phase_Space_P6=0
        
        WALLCLOCKTIME_P6="3:00:00"
        RAM_P6="2G"
        
    #     Ligne_Seule_CI/Config1_v1
        
        Geometrie_Folder_P6="Ligne_Seule_CI"
        # v1 v1_XS v1_Target
        
        Vconfig=2
        Geometrie_Version_P6="Config${Vconfig}_v1"
        
        # Stack Onlt for this project 
        StackName="Stack_Manip_13_08_20_config${Vconfig}"
        
        # G4_POLYVINYL_CHLORIDE (PMMA) || G4_WATER
        Material_Target_P6="G4_WATER"
        
        
        # M1 Rendement or M2 multi points 
        Methode_P6=M2
        # Methode 1 Le detecteur (Roos) 1 seule postion de cuve 
        
        
        if [ ${StackName} = "Stack_Manip_13_08_20_config1" ]
        then
        ##  mm !!!
        Pos_Stack_Z_P6=2064.675 # mm 
        elif [ ${StackName} = "Stack_Manip_13_08_20_config2" ]
        then
        Pos_Stack_Z_P6=232.175 # mm 
        else 
        Pos_Stack_Z_P6=0 # mm 
        echo "Choose a existing method"
        fi 
        
        
        
        
        if [ ${Methode_P6} = "M1" ]
        then
        ##  mm !!!
    #     Pos_Stack_Z_P6=232.175 # mm 
        Distribute_Mode_P6=0
        
        tab_Stack_P6[0]=${Pos_Stack_Z_P6}
        tab_Decalage_Stack_P6[0]=0
        
        elif [ ${Methode_P6} = "M2" ]
        then
        
    #     Pos_Stack_Z_P6=232.175 
        
        ## Config 1 206.4675 cm
        ## COnfig 2 23.2175 cm
        
        # um 
        Pos_Stack_Z_Min_P6=0 # 31
        Pos_Stack_Z_Max_P6=40 # 38
        Pas_Stack_Z_Max_P6=1
        
        I_compteur=-1
        
        for ((ostack=${Pos_Stack_Z_Min_P6}; ostack<${Pos_Stack_Z_Max_P6}; ostack+=${Pas_Stack_Z_Max_P6})); do
        
        
            if [ ${ostack} -gt 29 ] && [ ${ostack} -lt 36 ]
            then
                ##  mm !!!
                for ((ostack2=0; ostack2<10; ostack2+=1)); do
                
                let "I_compteur=${I_compteur}+1"
                
                PosZCalcul=$(echo "(${Pos_Stack_Z_P6}-(${ostack}+${ostack2}/10))"  |bc -l ) #mm
                
                Decalage_Real=$(echo "((${ostack}+${ostack2}/10))"  |bc -l ) #mm
                
                echo "*** tank ${Pos_Stack_Z_P6} ${Decalage_Real} ${PosZCalcul} ${ostack} ${ostack2}"
                
                tab_Stack_P6[${I_compteur}]=${PosZCalcul}
                tab_Decalage_Stack_P6[${I_compteur}]=${Decalage_Real}
                
                done
            else 
            
            let "I_compteur=${I_compteur}+1"
            
            PosZCalcul=$(echo "(${Pos_Stack_Z_P6}-${ostack})"  |bc -l ) #mm
            
            Decalage_Real=$(echo "(${ostack})"  |bc -l ) #mm
            
            echo "*** ${Pos_Stack_Z_P6} ${Decalage_Real} ${PosZCalcul} ${ostack} ${ostack2}"
            
            tab_Stack_P6[${I_compteur}]=${PosZCalcul}
            tab_Decalage_Stack_P6[${I_compteur}]=${Decalage_Real}
            
            fi 
        
        
        

        
        done
        
        Distribute_Mode_P6=1
        
    #     exit
        
        
        else 
        echo "Choose a existing method"
        fi 
        
        len_PosZ_Stack_P6=${#tab_Stack_P6[@]}  # nombre d'éléments dans le tableau

        
        ## 0 TypeSimu Pos et épaisseur de ref || 1 Epaisseur_Min || 2 Epaisseur_Max || 3 Pos_Min || 4 Pos_Max
        if [ ${Create_Phase_Space_P6} = "1" ]
        then
        option_P6=(0) 
        else
    #     option=(0 1 2 3 4) 
        option_P6=(0) 
        fi 
        len3_P6=${#option_P6[@]}  # nombre d'éléments dans le tableau
        
        
    else
    echo "z_Projet_ROOS=0"
    fi
#     exit
    
    
    
    
    

NameMainFolder="All_Simulation" 


    ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
    ### ### ### ### ### ### ### ### ### ### ### Projet Reglage ! Advanced users only ! ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
    ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

    ### P1 z_Projet_Arronax_Compensator_design

    if [ ${z_Projet_Arronax_Compensator_design} = "1" ]
    then
    
    Name_Projet="z_Projet_Arronax_Compensator_design"
    
    PathProject="${PathLaunchingFile}/${NameMainFolder}/${Name_Projet}"
    cd ${PathProject}
    
    echo "*********************************************************************"
    echo "Path project -> `pwd`"
    echo "*********************************************************************"
    
    NameMacro="LancerSimulation_Farm"
    FileToStockNameMacro=File_${NameMacro}
    
    mkdir ${FileToStockNameMacro}
    cd ${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}
    echo "*** Macro place -> `pwd`"
    
    for ((o=0; o<$len3; o++)); do
    
    echo "  Type Simu ${option[o]}"
    
    NameJob="${Name_Projet}_${NameMacro}_${Beam_ene_mono}_${Beam_ene_sigma}_T${option[o]}_${VersionConfig_P1}_${Coef_EVENT_NB}${EVENT_NB_Unit}"
    
    
    RUN_ID=`ls ${NameMacro}* | sed 's/[^0-9]//g' | sort -rn | sed q`
    echo "  Last run ID = "${RUN_ID}
    let "NEXT_RUN_ID=${RUN_ID}+1"
    echo "  Next run ID = "${NEXT_RUN_ID}

    
    PathMacroJob="${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}"
    CompletePathMacroJob=${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh
    
    cp ${PathProject}/${NameMacro}.sh ${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh

    echo "${NameMacro}_${NEXT_RUN_ID} ${NameJob} ${V_GATE}" >> README.txt
    
    sed -i "s/TypeSpaceDiskForSave/${TypeSpaceDIskForSave_P1}/g"     ${CompletePathMacroJob}
   
    sed -i "s/TYPESIMUCHANGE/${option[o]}/g"      ${CompletePathMacroJob}
    
    sed -i "s/VGATEREPLACE/${V_GATE}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Beamenemono/${Beam_ene_mono}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMENEMONOUnit/${Beam_ene_mono_Unit}/g"      ${CompletePathMacroJob}

    sed -i "s/Beamenetype/${Beam_ene_type}/g"      ${CompletePathMacroJob}
    sed -i "s/Beamenesigma/${Beam_ene_sigma}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMenesigmaUnit/${Beam_ene_sigma_Unit}/g"      ${CompletePathMacroJob}
    
    echo "${Beam_ene_mono} ${Beam_ene_mono_Unit} ${Beam_ene_type} ${Beam_ene_sigma} ${Beam_ene_sigma_Unit}"
    
    sed -i "s/CoefEVENTNB/${Coef_EVENT_NB}/g"      ${CompletePathMacroJob}
    sed -i "s/EVENTNBUnit/${EVENT_NB_Unit}/g"      ${CompletePathMacroJob}
    
    
    sed -i "s/VersionConfig/${VersionConfig_P1}/g"      ${CompletePathMacroJob}
    
    sed -i "s/PHYSICSLIST/${Physics_List_P1}/g"      ${CompletePathMacroJob}
    
#     sed -i "s/AuthorizeAllStepAndZSouris/${Authorize_AllStepAndZ_Souris}/g"      ${CompletePathMacroJob}
#     sed -i "s/AuthorizeAllStepAndZCubeAfter/${Authorize_AllStepAndZ_Cube_After}/g"      ${CompletePathMacroJob}
    
    sed -i "s/PourcentageResolutionEpaisseur/${Pourcentage_Resolution_Epaisseur}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CubeAfterMatter/${Cube_After_Matter_P1}/g"      ${CompletePathMacroJob}
   
    sed -i "s/WALLCLOCKTIME/${WALLCLOCKTIME_P1}/g"      ${CompletePathMacroJob}
    sed -i "s/RAMRAM/${RAM_P1}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Geometriefolder/${Geometrie_Folder_P1}/g"      ${CompletePathMacroJob}
    sed -i "s/GeometrieVersion/${Geometrie_Version_P1}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CREATEFASESPACE/${Create_Phase_Space_P1}/g"      ${CompletePathMacroJob}
    
    sed -i "s/NAMEJOB/${NameJob}/g"      ${CompletePathMacroJob}
    
    sed -i "s/TestFARM/${Test_FARM}/g"      ${CompletePathMacroJob}
    sed -i "s/DossierTest/${Dossier_Test}/g"      ${CompletePathMacroJob}
    
    if [ ${Test_FARM} = "1" ]
    then

    echo "Test en interactif"
    ./${NameMacro}_${NEXT_RUN_ID}.sh
    else
    echo "FARM Normal"
    qsub -l sps=1 -q huge ${NameMacro}_${NEXT_RUN_ID}.sh
    fi
    
    echo "*********************************************************************"
#     ls -lsrh 
    echo "*********************************************************************"
    
    qstat
    
    echo "*********************************************************************"
    
    done
    
    else
    echo "z_Projet_Arronax_Compensator_design ${z_Projet_Arronax_Compensator_design}"
    fi
   
    
   
    ### P2 z_Projet_Souris
   
    if [ ${z_Projet_Souris} = "1" ]
    then
    
#     /home/gate/nantes_sps/abongran/All_Simulation/z_Projet_Souris/MACtEST.mac
    Name_Projet="z_Projet_Souris"
    
    PathProject="${PathLaunchingFile}/${NameMainFolder}/${Name_Projet}"
    cd ${PathProject}
    
    echo "*********************************************************************"
    echo "Path project -> `pwd`"
    echo "*********************************************************************"
    
    NameMacro="LancerSimulation_Farm"
    FileToStockNameMacro=File_${NameMacro}
    
    mkdir ${FileToStockNameMacro}
    cd ${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}
    echo "*** Macro place -> `pwd`"
    
    for ((o=0; o<$len3_P2; o++)); do
    
    echo "  Type Simu ${option_P2[o]}"
    
    NameJob="${Name_Projet}_${NameMacro}_${Beam_ene_mono}_${Beam_ene_sigma}_T${option_P2[o]}_${VersionConfig_P2}_${Coef_EVENT_NB}${EVENT_NB_Unit}"
    
    
    RUN_ID=`ls ${NameMacro}* | sed 's/[^0-9]//g' | sort -rn | sed q`
    echo "  Last run ID = "${RUN_ID}
    let "NEXT_RUN_ID=${RUN_ID}+1"
    echo "  Next run ID = "${NEXT_RUN_ID}

    
    PathMacroJob="${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}"
    CompletePathMacroJob=${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh
    
    cp ${PathProject}/${NameMacro}.sh ${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh

    echo "${NameMacro}_${NEXT_RUN_ID} ${NameJob} ${V_GATE}" >> README.txt
    
    sed -i "s/TypeSpaceDiskForSave/${TypeSpaceDIskForSave_P1}/g"     ${CompletePathMacroJob}
   
    sed -i "s/TYPESIMUCHANGE/${option_P2[o]}/g"      ${CompletePathMacroJob}
    
    sed -i "s/VGATEREPLACE/${V_GATE}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Beamenemono/${Beam_ene_mono}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMENEMONOUnit/${Beam_ene_mono_Unit}/g"      ${CompletePathMacroJob}

    sed -i "s/Beamenetype/${Beam_ene_type}/g"      ${CompletePathMacroJob}
    sed -i "s/Beamenesigma/${Beam_ene_sigma}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMenesigmaUnit/${Beam_ene_sigma_Unit}/g"      ${CompletePathMacroJob}
    
    echo "${Beam_ene_mono} ${Beam_ene_mono_Unit} ${Beam_ene_type} ${Beam_ene_sigma} ${Beam_ene_sigma_Unit}"
    
    sed -i "s/CoefEVENTNB/${Coef_EVENT_NB}/g"      ${CompletePathMacroJob}
    sed -i "s/EVENTNBUnit/${EVENT_NB_Unit}/g"      ${CompletePathMacroJob}
    
    
    sed -i "s/VersionConfig/${VersionConfig_P2}/g"      ${CompletePathMacroJob}
    
   
    sed -i "s/WALLCLOCKTIME/${WALLCLOCKTIME_P2}/g"      ${CompletePathMacroJob}
    sed -i "s/RAMRAM/${RAM_P2}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Geometriefolder/${Geometrie_Folder_P2}/g"      ${CompletePathMacroJob}
    sed -i "s/GeometrieVersion/${Geometrie_Version_P2}/g"      ${CompletePathMacroJob}
    
    sed -i "s/NAMEJOB/${NameJob}/g"      ${CompletePathMacroJob}
    
    sed -i "s/UsePhaseSpace/${UsePhaseSpace_P2}/g"      ${CompletePathMacroJob}
    
    sed -i "s/DistributeSim/${Distribute_Sim_P2}/g"      ${CompletePathMacroJob}
    
    sed -i "s/PHYSICSLIST/${Physics_List}/g"      ${CompletePathMacroJob}
    
    sed -i "s/AuthorizeAllStepAndZSouris/${Authorize_AllStepAndZ_Souris}/g"      ${CompletePathMacroJob}
    sed -i "s/AuthorizeAllStepAndZCubeAfter/${Authorize_AllStepAndZ_Cube_After}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CubeAfterMatter/${Cube_After_Matter}/g"      ${CompletePathMacroJob}
    
    sed -i "s/TypeImageInput/${Type_Image_Input}/g"      ${CompletePathMacroJob}
    
    sed -i "s/AddPhaseSpaceKaptonColli/${Add_PhaseSpace_Kapton_Colli}/g"      ${CompletePathMacroJob}
    
    sed -i "s/AddActorNeutronsouris/${Add_Actor_Neutron_souris}/g"      ${CompletePathMacroJob}
    
    sed -i "s/TestFARM/${Test_FARM}/g"      ${CompletePathMacroJob}
    sed -i "s/DossierTest/${Dossier_Test}/g"      ${CompletePathMacroJob}
    
    sed -i "s/ShiftPositionInputImageOfProtocol/${Shift_Position_InputImageOfProtocol_P2}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CollimatorDiameter/${Collimator_Diameter_P2}/g"      ${CompletePathMacroJob}
    sed -i "s/IncertitudeIvalue/${Incertitude_Ivalue_P2}/g"      ${CompletePathMacroJob}
    
    
    
    
    if [ ${Test_FARM} = "1" ]
    then

    echo "Test en interactif"
    ./${NameMacro}_${NEXT_RUN_ID}.sh
    
    for ((distribe_i=0; distribe_i<${Distribute_Nb}; distribe_i++)); do
    ./${NameMacro}_${NEXT_RUN_ID}.sh
    echo "Qsub Multi Oh Yeah!!!! ${distribe_i}/${Distribute_Nb} "
    done
    
    else
    echo "FARM Normal"
    qsub -l sps=1 -q huge ${NameMacro}_${NEXT_RUN_ID}.sh
    
    for ((distribe_i=0; distribe_i<${Distribute_Nb}; distribe_i++)); do
    qsub -l sps=1 -q huge ${NameMacro}_${NEXT_RUN_ID}.sh
    echo "Qsub Multi Oh Yeah!!!! ${distribe_i}/${Distribute_Nb} "
    done
    
    fi
    
    
    echo "*********************************************************************"
#     ls -lsrh 
    echo "*********************************************************************"
    
    qstat
    
    echo "*********************************************************************"
    
    done
    
    else
    echo "z_Projet_Souris ${z_Projet_Souris}"
    fi
   
    ### P3 z_Projet_Manip_ZebraFish_11_03_20

    if [ ${z_Projet_Manip_ZebraFish_11_03_20} = "1" ]
    then
    
    Name_Projet="z_Projet_Manip_ZebraFish_11_03_20"
    
    PathProject="${PathLaunchingFile}/${NameMainFolder}/${Name_Projet}"
    cd ${PathProject}
    
    echo "*********************************************************************"
    echo "Path project -> `pwd`"
    echo "*********************************************************************"
    
    NameMacro="LancerSimulation_Farm"
    FileToStockNameMacro=File_${NameMacro}
    
    mkdir -f ${FileToStockNameMacro}
    cd ${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}
    echo "*** Macro place -> `pwd`"
    
    for ((o=0; o<$len3_P3; o++)); do
    
    echo "  Type Simu ${option_P3[o]}"
    
    NameJob="${Name_Projet}_${NameMacro}_${Beam_ene_mono}_${Beam_ene_sigma}_T${option_P3[o]}_${VersionConfig_P3}_${Coef_EVENT_NB}${EVENT_NB_Unit}"
    
    
    RUN_ID=`ls ${NameMacro}* | sed 's/[^0-9]//g' | sort -rn | sed q`
    echo "  Last run ID = "${RUN_ID}
    let "NEXT_RUN_ID=${RUN_ID}+1"
    echo "  Next run ID = "${NEXT_RUN_ID}

    
    PathMacroJob="${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}"
    CompletePathMacroJob=${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh
    
    cp ${PathProject}/${NameMacro}.sh ${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh

    echo "${NameMacro}_${NEXT_RUN_ID} ${NameJob} ${V_GATE}" >> README.txt
    
    sed -i "s/TypeSpaceDiskForSave/${TypeSpaceDIskForSave_P3}/g"     ${CompletePathMacroJob}
   
    sed -i "s/TYPESIMUCHANGE/${option_P3[o]}/g"      ${CompletePathMacroJob}
    
    sed -i "s/VGATEREPLACE/${V_GATE}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Beamenemono/${Beam_ene_mono}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMENEMONOUnit/${Beam_ene_mono_Unit}/g"      ${CompletePathMacroJob}

    sed -i "s/Beamenetype/${Beam_ene_type}/g"      ${CompletePathMacroJob}
    sed -i "s/Beamenesigma/${Beam_ene_sigma}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMenesigmaUnit/${Beam_ene_sigma_Unit}/g"      ${CompletePathMacroJob}
    
    echo "${Beam_ene_mono} ${Beam_ene_mono_Unit} ${Beam_ene_type} ${Beam_ene_sigma} ${Beam_ene_sigma_Unit}"
    
    sed -i "s/CoefEVENTNB/${Coef_EVENT_NB}/g"      ${CompletePathMacroJob}
    sed -i "s/EVENTNBUnit/${EVENT_NB_Unit}/g"      ${CompletePathMacroJob}
    
    
    sed -i "s/VersionConfig/${VersionConfig_P3}/g"      ${CompletePathMacroJob}
    
   
    sed -i "s/WALLCLOCKTIME/${WALLCLOCKTIME_P3}/g"      ${CompletePathMacroJob}
    sed -i "s/RAMRAM/${RAM_P3}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Geometriefolder/${Geometrie_Folder_P3}/g"      ${CompletePathMacroJob}
    sed -i "s/GeometrieVersion/${Geometrie_Version_P3}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CREATEFASESPACE/${Create_Phase_Space_P3}/g"      ${CompletePathMacroJob}
    
    sed -i "s/NAMEJOB/${NameJob}/g"      ${CompletePathMacroJob}
    
    ## Specifique P3
    sed -i "s/MaterialTarget/${Material_Target_P3}/g"      ${CompletePathMacroJob}
    
    sed -i "s/TestFARM/${Test_FARM}/g"      ${CompletePathMacroJob}
    sed -i "s/DossierTest/${Dossier_Test}/g"      ${CompletePathMacroJob}
    
    sed -i "s/STACKNAMESTACK/${StackName}/g"      ${CompletePathMacroJob}
    
    
    
    if [ ${Test_FARM} = "1" ]
    then

    echo "Test en interactif"
    ./${NameMacro}_${NEXT_RUN_ID}.sh
    else
    echo "FARM Normal"
    qsub -l sps=1 -q huge ${NameMacro}_${NEXT_RUN_ID}.sh
    fi
    
    
    
    echo "*********************************************************************"
#     ls -lsrh 
    echo "*********************************************************************"
    
    qstat
    
    echo "*********************************************************************"
    
    done
    
    else
    echo "z_Projet_Manip_ZebraFish_11_03_20 ${z_Projet_Manip_ZebraFish_11_03_20}"
    fi
   
   
          ### P4 z_Projet_Collimateur

    if [ ${z_Projet_Collimateur} = "1" ]
    then
    
    Name_Projet="z_Projet_Collimateur"
    
    PathProject="${PathLaunchingFile}/${NameMainFolder}/${Name_Projet}"
    cd ${PathProject}
    
    echo "*********************************************************************"
    echo "Path project -> `pwd`"
    echo "*********************************************************************"
    
    NameMacro="LancerSimulation_Farm"
    FileToStockNameMacro=File_${NameMacro}
    
    mkdir ${FileToStockNameMacro}
    cd ${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}
    echo "*** Macro place -> `pwd`"

    for ((o=0; o<$len3_P4; o++)); do
    
    echo "  Type Simu ${option_P4[o]}"
    
    NameJob="${Name_Projet}_${NameMacro}_${Beam_ene_mono}_${Beam_ene_sigma}_T${option_P4[o]}_${VersionConfig_P4}_${Coef_EVENT_NB}${EVENT_NB_Unit}"
    
    
    RUN_ID=`ls ${NameMacro}* | sed 's/[^0-9]//g' | sort -rn | sed q`
    echo "  Last run ID = "${RUN_ID}
    let "NEXT_RUN_ID=${RUN_ID}+1"
    echo "  Next run ID = "${NEXT_RUN_ID}

    
    PathMacroJob="${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}"
    CompletePathMacroJob=${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh
    
    cp ${PathProject}/${NameMacro}.sh ${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh

    echo "${NameMacro}_${NEXT_RUN_ID} ${NameJob} ${V_GATE}" >> README.txt
    
    sed -i "s/TypeSpaceDiskForSave/${TypeSpaceDIskForSave_P4}/g"     ${CompletePathMacroJob}
   
    sed -i "s/TYPESIMUCHANGE/${option_P4[o]}/g"      ${CompletePathMacroJob}
    
    sed -i "s/VGATEREPLACE/${V_GATE}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Beamenemono/${Beam_ene_mono}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMENEMONOUnit/${Beam_ene_mono_Unit}/g"      ${CompletePathMacroJob}

    sed -i "s/Beamenetype/${Beam_ene_type}/g"      ${CompletePathMacroJob}
    sed -i "s/Beamenesigma/${Beam_ene_sigma}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMenesigmaUnit/${Beam_ene_sigma_Unit}/g"      ${CompletePathMacroJob}
    
    echo "${Beam_ene_mono} ${Beam_ene_mono_Unit} ${Beam_ene_type} ${Beam_ene_sigma} ${Beam_ene_sigma_Unit}"
    
    sed -i "s/CoefEVENTNB/${Coef_EVENT_NB}/g"      ${CompletePathMacroJob}
    sed -i "s/EVENTNBUnit/${EVENT_NB_Unit}/g"      ${CompletePathMacroJob}
    
    
    sed -i "s/VersionConfig/${VersionConfig_P4}/g"      ${CompletePathMacroJob}
    
   
    sed -i "s/WALLCLOCKTIME/${WALLCLOCKTIME_P4}/g"      ${CompletePathMacroJob}
    sed -i "s/RAMRAM/${RAM_P4}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Geometriefolder/${Geometrie_Folder_P4}/g"      ${CompletePathMacroJob}
    sed -i "s/GeometrieVersion/${Geometrie_Version_P4}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CREATEFASESPACE/${Create_Phase_Space_P4}/g"      ${CompletePathMacroJob}
    
    sed -i "s/NAMEJOB/${NameJob}/g"      ${CompletePathMacroJob}
    
    ## Specifique P4
    sed -i "s/MaterialTarget/${Material_Target_P4}/g"      ${CompletePathMacroJob}
    
    sed -i "s/TestFARM/${Test_FARM}/g"      ${CompletePathMacroJob}
    sed -i "s/DossierTest/${Dossier_Test}/g"      ${CompletePathMacroJob}
    
    if [ ${Test_FARM} = "1" ]
    then

    echo "Test en interactif"
    ./${NameMacro}_${NEXT_RUN_ID}.sh
    else
    echo "FARM Normal"
    qsub -l sps=1 ${NameMacro}_${NEXT_RUN_ID}.sh
    fi
    
    
    
    echo "*********************************************************************"
#     ls -lsrh 
    echo "*********************************************************************"
    
    qstat
    
    echo "*********************************************************************"
    
    done
    
    else
    echo "z_Projet_Collimateur ${z_Projet_Collimateur}"
    fi
   
    ### P5 z_Projet_Instrumentation

    if [ ${z_Projet_Instrumentation} = "1" ]
    then
    
    Name_Projet="z_Projet_Instrumentation"
    
    PathProject="${PathLaunchingFile}/${NameMainFolder}/${Name_Projet}"
    cd ${PathProject}
    
    echo "*********************************************************************"
    echo "Path project -> `pwd`"
    echo "*********************************************************************"
    
    NameMacro="LancerSimulation_Farm"
    FileToStockNameMacro=File_${NameMacro}
    
    mkdir ${FileToStockNameMacro}
    cd ${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}
    echo "*** Macro place -> `pwd`"
    
    for ((o=0; o<$len3_P5; o++)); do
    
    echo "  Type Simu ${option_P5[o]}"
    
    NameJob="${Name_Projet}_${NameMacro}_${Beam_ene_mono}_${Beam_ene_sigma}_T${option_P5[o]}_${VersionConfig_P5}_${Coef_EVENT_NB}${EVENT_NB_Unit}"
    
    
    RUN_ID=`ls ${NameMacro}* | sed 's/[^0-9]//g' | sort -rn | sed q`
    echo "  Last run ID = "${RUN_ID}
    let "NEXT_RUN_ID=${RUN_ID}+1"
    echo "  Next run ID = "${NEXT_RUN_ID}

    
    PathMacroJob="${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}"
    CompletePathMacroJob=${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh
    
    cp ${PathProject}/${NameMacro}.sh ${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh

    echo "${NameMacro}_${NEXT_RUN_ID} ${NameJob} ${V_GATE}" >> README.txt
    
    sed -i "s/TypeSpaceDiskForSave/${TypeSpaceDIskForSave_P5}/g"     ${CompletePathMacroJob}
   
    sed -i "s/TYPESIMUCHANGE/${option_P5[o]}/g"      ${CompletePathMacroJob}
    
    sed -i "s/VGATEREPLACE/${V_GATE}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Beamenemono/${Beam_ene_mono}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMENEMONOUnit/${Beam_ene_mono_Unit}/g"      ${CompletePathMacroJob}

    sed -i "s/Beamenetype/${Beam_ene_type}/g"      ${CompletePathMacroJob}
    sed -i "s/Beamenesigma/${Beam_ene_sigma}/g"      ${CompletePathMacroJob}
    sed -i "s/BEAMenesigmaUnit/${Beam_ene_sigma_Unit}/g"      ${CompletePathMacroJob}
    
    echo "${Beam_ene_mono} ${Beam_ene_mono_Unit} ${Beam_ene_type} ${Beam_ene_sigma} ${Beam_ene_sigma_Unit}"
    
    sed -i "s/CoefEVENTNB/${Coef_EVENT_NB}/g"      ${CompletePathMacroJob}
    sed -i "s/EVENTNBUnit/${EVENT_NB_Unit}/g"      ${CompletePathMacroJob}
    
    
    sed -i "s/VersionConfig/${VersionConfig_P5}/g"      ${CompletePathMacroJob}
    
    sed -i "s/PHYSICSLIST/${Physics_List_P5}/g"      ${CompletePathMacroJob}
    
#     sed -i "s/AuthorizeAllStepAndZSouris/${Authorize_AllStepAndZ_Souris}/g"      ${CompletePathMacroJob}
#     sed -i "s/AuthorizeAllStepAndZCubeAfter/${Authorize_AllStepAndZ_Cube_After}/g"      ${CompletePathMacroJob}
   
    sed -i "s/WALLCLOCKTIME/${WALLCLOCKTIME_P5}/g"      ${CompletePathMacroJob}
    sed -i "s/RAMRAM/${RAM_P5}/g"      ${CompletePathMacroJob}
    
    sed -i "s/Geometriefolder/${Geometrie_Folder_P5}/g"      ${CompletePathMacroJob}
    sed -i "s/GeometrieVersion/${Geometrie_Version_P5}/g"      ${CompletePathMacroJob}
    
    sed -i "s/CREATEFASESPACE/${Create_Phase_Space_P5}/g"      ${CompletePathMacroJob}
    
    sed -i "s/NAMEJOB/${NameJob}/g"      ${CompletePathMacroJob}
    
    sed -i "s/TestFARM/${Test_FARM}/g"      ${CompletePathMacroJob}
    sed -i "s/DossierTest/${Dossier_Test}/g"      ${CompletePathMacroJob}
    
    # detector Cube After
    sed -i "s/AVAILDETECTOR/${Detector_After_P5}/g"      ${CompletePathMacroJob}
    sed -i "s/CubeAfterMatter/${Cube_After_Matter_P5}/g"      ${CompletePathMacroJob}
    
    ## Detecteur #
    
    # d1
    sed -i "s/DETECTOR1/${Detector_1_P5}/g"      ${CompletePathMacroJob}
    sed -i "s/DETECTOR1POSITION/${Detector_1_P5_Position}/g"      ${CompletePathMacroJob}
    sed -i "s/DETECTOR1UNIT/${Detector_1_P5_Unit}/g"      ${CompletePathMacroJob}
    
    #d2
    sed -i "s/DETECTOR2/${Detector_2_P5}/g"      ${CompletePathMacroJob}
    sed -i "s/DETECTOR2POSITION/${Detector_2_P5_Position}/g"      ${CompletePathMacroJob}
    sed -i "s/DETECTOR2UNIT/${Detector_2_P5_Unit}/g"      ${CompletePathMacroJob}
    
    
    
    if [ ${Test_FARM} = "1" ]
    then

    echo "Test en interactif"
    ./${NameMacro}_${NEXT_RUN_ID}.sh
    else
    echo "FARM Normal"
    qsub -l sps=1 -q huge ${NameMacro}_${NEXT_RUN_ID}.sh
    fi
    
    echo "*********************************************************************"
#     ls -lsrh 
    echo "*********************************************************************"
    
    qstat
    
    echo "*********************************************************************"
    
    done
    
    else
    echo "z_Projet_Instrumentation ${z_Projet_Instrumentation}"
    fi
    
    
    
    ### P6 z_Projet_ROOS

    if [ ${z_Projet_ROOS} = "1" ]
    then
    
        
        for ((ostack=0; ostack<$len_PosZ_Stack_P6; ostack++)); do
        
        echo "  PosZ_Stack ${tab_Stack_P6[ostack]}"
        
        Pos_Stack_Z_P6=${tab_Stack_P6[ostack]}
        Decalage_Pos_Stack_Z_P6=${tab_Decalage_Stack_P6[ostack]}
        
        echo "*** POs Stack ${Pos_Stack_Z_P6}"
        echo "*** Decalage ${Decalage_Pos_Stack_Z_P6}"
        
        Name_Projet="z_Projet_ROOS"
        
        PathProject="${PathLaunchingFile}/${NameMainFolder}/${Name_Projet}"
        cd ${PathProject}
        
        echo "*********************************************************************"
        echo "Path project -> `pwd`"
        echo "*********************************************************************"
        
        NameMacro="LancerSimulation_Farm"
        FileToStockNameMacro=File_${NameMacro}
        
        mkdir -f ${FileToStockNameMacro}
        cd ${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}
        echo "*** Macro place -> `pwd`"
        
        for ((o=0; o<$len3_P6; o++)); do
        
        echo "  Type Simu ${option_P6[o]}"
        
        NameJob="${Name_Projet}_${NameMacro}_${Beam_ene_mono}_${Beam_ene_sigma}_T${option_P6[o]}_${VersionConfig_P6}_${Coef_EVENT_NB}${EVENT_NB_Unit}"
        
        
        RUN_ID=`ls ${NameMacro}* | sed 's/[^0-9]//g' | sort -rn | sed q`
        echo "  Last run ID = "${RUN_ID}
        let "NEXT_RUN_ID=${RUN_ID}+1"
        echo "  Next run ID = "${NEXT_RUN_ID}

        
        PathMacroJob="${PathLaunchingFile}/${NameMainFolder}/${FileToStockNameMacro}"
        CompletePathMacroJob=${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh
        
        cp ${PathProject}/${NameMacro}.sh ${PathMacroJob}/${NameMacro}_${NEXT_RUN_ID}.sh

        echo "${NameMacro}_${NEXT_RUN_ID} ${NameJob} ${V_GATE}" >> README.txt
        
        sed -i "s/TypeSpaceDiskForSave/${TypeSpaceDIskForSave_P6}/g"     ${CompletePathMacroJob}
    
        sed -i "s/TYPESIMUCHANGE/${option_P6[o]}/g"      ${CompletePathMacroJob}
        
        sed -i "s/VGATEREPLACE/${V_GATE}/g"      ${CompletePathMacroJob}
        
        sed -i "s/Beamenemono/${Beam_ene_mono}/g"      ${CompletePathMacroJob}
        sed -i "s/BEAMENEMONOUnit/${Beam_ene_mono_Unit}/g"      ${CompletePathMacroJob}

        sed -i "s/Beamenetype/${Beam_ene_type}/g"      ${CompletePathMacroJob}
        sed -i "s/Beamenesigma/${Beam_ene_sigma}/g"      ${CompletePathMacroJob}
        sed -i "s/BEAMenesigmaUnit/${Beam_ene_sigma_Unit}/g"      ${CompletePathMacroJob}
        
        echo "${Beam_ene_mono} ${Beam_ene_mono_Unit} ${Beam_ene_type} ${Beam_ene_sigma} ${Beam_ene_sigma_Unit}"
        
        sed -i "s/CoefEVENTNB/${Coef_EVENT_NB}/g"      ${CompletePathMacroJob}
        sed -i "s/EVENTNBUnit/${EVENT_NB_Unit}/g"      ${CompletePathMacroJob}
        
        
        sed -i "s/VersionConfig/${VersionConfig_P6}/g"      ${CompletePathMacroJob}
        
    
        sed -i "s/WALLCLOCKTIME/${WALLCLOCKTIME_P6}/g"      ${CompletePathMacroJob}
        sed -i "s/RAMRAM/${RAM_P6}/g"      ${CompletePathMacroJob}
        
        sed -i "s/Geometriefolder/${Geometrie_Folder_P6}/g"      ${CompletePathMacroJob}
        sed -i "s/GeometrieVersion/${Geometrie_Version_P6}/g"      ${CompletePathMacroJob}
        
        sed -i "s/CREATEFASESPACE/${Create_Phase_Space_P6}/g"      ${CompletePathMacroJob}
        
        sed -i "s/NAMEJOB/${NameJob}/g"      ${CompletePathMacroJob}
        
        ## Specifique P6
        sed -i "s/MaterialTarget/${Material_Target_P6}/g"      ${CompletePathMacroJob}
        
        sed -i "s/TestFARM/${Test_FARM}/g"      ${CompletePathMacroJob}
        sed -i "s/DossierTest/${Dossier_Test}/g"      ${CompletePathMacroJob}
        
        sed -i "s/STACKNAMESTACK/${StackName}/g"      ${CompletePathMacroJob}
        
        sed -i "s/PosStackZ/${Pos_Stack_Z_P6}/g"      ${CompletePathMacroJob}
        sed -i "s/DECALAGEPOSSTACKZ/${Decalage_Pos_Stack_Z_P6}/g"      ${CompletePathMacroJob}
        
        
        sed -i "s/DistributeSim/${Distribute_Mode_P6}/g"      ${CompletePathMacroJob}
        
        if [ ${Test_FARM} = "1" ]
        then

        echo "Test en interactif"
        ./${NameMacro}_${NEXT_RUN_ID}.sh
        else
        echo "FARM Normal"
#         qsub -l sps=1 -q huge ${NameMacro}_${NEXT_RUN_ID}.sh
        qsub -l sps=1 ${NameMacro}_${NEXT_RUN_ID}.sh
        fi
        
        
        
        echo "*********************************************************************"
    #     ls -lsrh 
        echo "*********************************************************************"
        
        qstat
        
        echo "*********************************************************************"
        
        done
    done
    
    else
    echo "z_Projet_ROOS ${z_Projet_ROOS}"
    fi
    
    
    
    
    
    
    
    
    
    
    
    
done

done

   
# time ls -lsrh 
   


