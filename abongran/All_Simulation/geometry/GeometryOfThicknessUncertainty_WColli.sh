#!/bin/bash


START=$(date +%s) # Pour calculer le temps de calcul

echo Running on host `hostname` # Done le nom du system
HOSTNAME=`hostname`

Path="./Ligne_ICO/v2T_WColli/"

mkdir -p ${Path}

# Wcollimator

# mkdir -p folder/subfolder he -p flag causes any parent directories to be created if necessary. 
#mkdir -p parentfolder/{subfolder1,subfolder2,subfolder3}

# Ligne ICO Ref

#KAPTON - collé a la source = fenêtre de sortie
#================================================

kapton_geometry_setHeight="0.050" # mm 
kapton_placement_setTranslation_Z="0.025" # mm kapton_geometry_setHeight/2

#TUNGSTENE + Support - pour éclater - homogénéiser - le faisceau - a 1cm du Kapton
#========================================================

# v2T : Tungsten dans un bloc d'air pas de problème de position des éléments
tungsten_geometry_setZLength="0.0517" # mm

#Detecteur Dose Charbel Lightdetector - contient deux ouvertures en alu
#=============================================================================================================
# 1 box air et 2 plaque d'alu symétrique
# Alu_in_placement_setTranslation_Z = - Alu_out_placement_setTranslation_Z

Alu_in_geometry_setZLength="0.020" #mm
Alu_out_geometry_setZLength=${Alu_in_geometry_setZLength} #mm

DetecteurCharbel_geometry_SetGapBetweenAlu=50 # mm
DetecteurCharbel_geometry_setZLength=$(echo "${DetecteurCharbel_geometry_SetGapBetweenAlu}+2*${Alu_in_geometry_setZLength}"  |bc -l )  #mm ="50.04"

Alu_in_placement_setTranslation_Z="-25.01" #mm
Alu_out_placement_setTranslation_Z="25.01" #mm

#2 micron de cuivre avant le colli pour monitorer les RX - 1cm avant le colli 
#=============================================================================
# 1 feuille de cuivre simple 
Cuivre_geometry_setZLength=0.002 #mm

#COLLIMATEUR 1 collé à la cible
#=============================================================================================================
# Colli cylindre :: inside hole cylinder air

colli1_geometry_setHeight="25" #mm

colli1_placement_setTranslation_Z="1637.50" # mm

frite_colli_before_geometry_setZLength="0.1" #mm
frite_colli_after_geometry_setZLength="0.1"  #mm

frite_colli_before_placement_setTranslation_Z="1624.95" #mm
frite_colli_after_placement_setTranslation_Z="1651.00" #mm



#Hole
trou1_geometry_setHeight=${colli1_geometry_setHeight}


### 

Epaisseur_Min=-5 # %Ref
Epaisseur_Max=6 # %Ref
Epaisseur_Pas=1

for ((iEpaisseur=${Epaisseur_Min}; iEpaisseur<${Epaisseur_Max}; iEpaisseur+=${Epaisseur_Pas})); do

echo "iEpaisseur ${iEpaisseur} /%Ref"  



### Partie +

#KAPTON - collé a la source = fenêtre de sortie
#================================================

CoefMultiplicateur=$(echo "($iEpaisseur / 100)+1"|bc -l)

# CoefMultiplicateur="$(python3 -c "print('{0:0.9f}'.format((${iEpaisseur} / 100) +1 ))")"
echo " "
echo "CoefMultiplicateur ${CoefMultiplicateur}"
echo " "

# CoefMultiplicateur=$(echo "($iEpaisseur / 100)+1"|bc -l) | awk '{printf "%f", $0}' || How do I get bc(1) to print the leading zero?

Calcul_kapton_geometry_setHeight="$(python3 -c "print('{0:0.9f}'.format( ${CoefMultiplicateur} * ${kapton_geometry_setHeight} ))")" # mm 

Calcul_kapton_placement_setTranslation_Z="$(python3 -c "print('{0:0.9f}'.format( (${Calcul_kapton_geometry_setHeight} / 2) ))")" # mm  kapton_geometry_setHeight/2

# Calcul_kapton_placement_setTranslation_Z=$(python3 -c "(${Calcul_kapton_placement_setTranslation_Z})/2"  )  # mm kapton_geometry_setHeight/2

echo " "
echo "Calcul_kapton_geometry_setHeight ${Calcul_kapton_geometry_setHeight}"
echo "Calcul_kapton_placement_setTranslation_Z ${Calcul_kapton_placement_setTranslation_Z}"
echo " "


#TUNGSTENE + Support - pour éclater - homogénéiser - le faisceau - a 1cm du Kapton
#========================================================

# v2T : Tungsten dans un bloc d'air pas de problème de position des éléments
Calcul_tungsten_geometry_setZLength=$(echo "($CoefMultiplicateur * $tungsten_geometry_setZLength)"|bc -l)

echo " "
echo "Calcul_tungsten_geometry_setZLength ${Calcul_tungsten_geometry_setZLength}"
echo " "
#Detecteur Dose Charbel Lightdetector - contient deux ouvertures en alu
#=============================================================================================================
# 1 box air et 2 plaque d'alu symétrique
# Alu_in_placement_setTranslation_Z = - Alu_out_placement_setTranslation_Z

Calcul_Alu_in_geometry_setZLength=$(echo "${CoefMultiplicateur}*${Alu_in_geometry_setZLength}"  |bc -l ) #mm
Calcul_Alu_out_geometry_setZLength=${Calcul_Alu_in_geometry_setZLength} #mm

Calcul_DetecteurCharbel_geometry_setZLength=$(echo "${DetecteurCharbel_geometry_SetGapBetweenAlu}+2*${Calcul_Alu_in_geometry_setZLength}"  |bc -l )  #mm ="50.04"

# d
Calcul_Alu_in_placement_setTranslation_Z=$(echo "(-1*${Calcul_DetecteurCharbel_geometry_setZLength}/2)+(${Calcul_Alu_in_geometry_setZLength}/2)"  |bc -l ) #mm
Calcul_Alu_out_placement_setTranslation_Z=$(echo "(1*${Calcul_DetecteurCharbel_geometry_setZLength}/2)-(${Calcul_Alu_in_geometry_setZLength}/2)"  |bc -l ) #mm

echo " "

echo "A Calcul_Alu_in_geometry_setZLength ${Calcul_Alu_in_geometry_setZLength}"
echo "A Calcul_Alu_out_geometry_setZLength ${Calcul_Alu_out_geometry_setZLength}"

echo "A Calcul_DetecteurCharbel_geometry_setZLength ${Calcul_DetecteurCharbel_geometry_setZLength}"

echo "A Calcul_Alu_in_placement_setTranslation_Z ${Calcul_Alu_in_placement_setTranslation_Z}"
echo "A Calcul_Alu_out_placement_setTranslation_Z ${Calcul_Alu_out_placement_setTranslation_Z}"
echo " "

#2 micron de cuivre avant le colli pour monitorer les RX - 1cm avant le colli 
#=============================================================================
# 1 feuille de cuivre simple 

Calcul_Cuivre_geometry_setZLength=$(echo "$CoefMultiplicateur*$Cuivre_geometry_setZLength"  |bc -l ) #mm

echo " "
echo "A Calcul_Cuivre_geometry_setZLength ${Calcul_Cuivre_geometry_setZLength}"
echo " "

#COLLIMATEUR 1 collé à la cible
#=============================================================================================================
# Colli cylindre :: inside hole cylinder air

# CoefMultiplicateur_Colli=${CoefMultiplicateur}
CoefMultiplicateur_Colli="1"

Calcul_colli1_geometry_setHeight=$(echo "$CoefMultiplicateur_Colli*$colli1_geometry_setHeight"  |bc -l ) #mm

Calcul_frite_colli_before_placement_setTranslation_Z=$(echo "${colli1_placement_setTranslation_Z}-(${Calcul_colli1_geometry_setHeight}/2)-${frite_colli_before_geometry_setZLength}"  |bc -l ) #mm
Calcul_frite_colli_after_placement_setTranslation_Z=$(echo "$colli1_placement_setTranslation_Z+($Calcul_colli1_geometry_setHeight/2)+1"  |bc -l ) #mm

#Hole
Calcul_trou1_geometry_setHeight=${Calcul_colli1_geometry_setHeight}

echo " "
echo "A Calcul_colli1_geometry_setHeight ${Calcul_colli1_geometry_setHeight}"
echo "A Calcul_frite_colli_before_placement_setTranslation_Z ${Calcul_frite_colli_before_placement_setTranslation_Z}"
echo "A Calcul_frite_colli_after_placement_setTranslation_Z ${Calcul_frite_colli_after_placement_setTranslation_Z}"
echo "A Calcul_trou1_geometry_setHeight ${Calcul_trou1_geometry_setHeight}"
echo " "



###########################################################################################################################################
###########################################################################################################################################

# Création du .mac

###########################################################################################################################################
###########################################################################################################################################



### Partie -

/bin/cat <<EOM > ${Path}Setup_Line_${CoefMultiplicateur}.mac

# 26/02/2020 : lIGNE Arronax
# Bride + Kapton 
# Disposition Tungsten : 1 Feuille de tungsten enchassé dans du PVC
# Détecteur Charbel
# Cuivre Rayons X
# Collimateur

## echo "CoefMultiplicateur ${CoefMultiplicateur}"

#====================================================================
#====================================================================
# -----------------------------------------------------
# Bride + fenetre kapton
#================================================
/gate/world/daughters/name   BeamPipe
/gate/world/daughters/insert        cylinder
/gate/BeamPipe/setMaterial  G4_STAINLESS-STEEL
/gate/BeamPipe/geometry/setRmin          0. cm
/gate/BeamPipe/geometry/setRmax          3.0 cm
/gate/BeamPipe/geometry/setHeight         10.0 cm
/gate/BeamPipe/geometry/setPhiStart        0 deg
/gate/BeamPipe/geometry/setDeltaPhi      360 deg
/gate/BeamPipe/placement/setTranslation 0. 0. -5.0 cm
/gate/BeamPipe/vis/setColor grey
/gate/BeamPipe/vis/forceSolid true

/gate/BeamPipe/daughters/name   Inside_BeamPipe
/gate/BeamPipe/daughters/insert        cylinder
/gate/Inside_BeamPipe/setMaterial                Vacuum
/gate/Inside_BeamPipe/geometry/setRmin          0.0 cm
/gate/Inside_BeamPipe/geometry/setRmax          1.5 cm
/gate/Inside_BeamPipe/geometry/setHeight         10.0 cm
/gate/Inside_BeamPipe/geometry/setPhiStart        0 deg
/gate/Inside_BeamPipe/geometry/setDeltaPhi      360 deg
/gate/Inside_BeamPipe/placement/setTranslation 0. 0. 0 cm
/gate/Inside_BeamPipe/vis/setColor white
/gate/Inside_BeamPipe/vis/forceSolid true

#/gate/world/daughters/name   BeamPipe2
#/gate/world/daughters/insert        cylinder
#/gate/BeamPipe2/setMaterial  G4_STAINLESS-STEEL
#/gate/BeamPipe2/geometry/setRmin          1.5 cm
#/gate/BeamPipe2/geometry/setRmax          3.0 cm
#/gate/BeamPipe2/geometry/setHeight         1.0 cm
#/gate/BeamPipe2/geometry/setPhiStart        0 deg
#/gate/BeamPipe2/geometry/setDeltaPhi      360 deg
#/gate/BeamPipe2/placement/setTranslation 0. 0. 0.5 cm
#/gate/BeamPipe2/vis/setColor grey
#/gate/BeamPipe2/vis/forceSolid true
#/gate/kapton/vis/forceWireframe

#KAPTON - collé a la source = fenêtre de sortie
#================================================

/gate/world/daughters/name   kapton
/gate/world/daughters/insert        cylinder
/gate/kapton/setMaterial                G4_KAPTON
/gate/kapton/geometry/setRmin          0.0 cm
/gate/kapton/geometry/setRmax          1.5 cm
/gate/kapton/geometry/setHeight         ${Calcul_kapton_geometry_setHeight} mm
/gate/kapton/geometry/setPhiStart        0 deg
/gate/kapton/geometry/setDeltaPhi      360 deg
/gate/kapton/placement/setTranslation 0. 0. ${Calcul_kapton_placement_setTranslation_Z} mm
/gate/kapton/vis/setColor yellow
/gate/kapton/vis/forceSolid true

# -----------------------------------------------------
#====================================================================
#====================================================================





#TUNGSTENE + Support - pour éclater - homogénéiser - le faisceau - a 1cm du Kapton
#========================================================
# décalage de +0.01 mm pour placer le Phasespace
# // Charbel 26/02/2020 : incertitude sur le placement +- 1 mm

/gate/world/daughters/name tungsten_support
/gate/world/daughters/insert box
/gate/tungsten_support/setMaterial G4_AIR
/gate/tungsten_support/geometry/setXLength 6. cm
/gate/tungsten_support/geometry/setYLength 6. cm
/gate/tungsten_support/geometry/setZLength 4 mm
/gate/tungsten_support/vis/setColor white
/gate/tungsten_support/vis/forceWireframe
#/gate/tungsten_support/vis/forceSolid
/gate/tungsten_support/placement/setTranslation 0. 0. 12.01 mm

/gate/tungsten_support/daughters/name tungsten
/gate/tungsten_support/daughters/insert box
/gate/tungsten/setMaterial G4_W
/gate/tungsten/geometry/setXLength 25 mm
/gate/tungsten/geometry/setYLength 25 mm
/gate/tungsten/geometry/setZLength ${Calcul_tungsten_geometry_setZLength} mm
/gate/tungsten/vis/setColor red
#/gate/tungsten/vis/forceWireframe
/gate/tungsten/vis/forceSolid
/gate/tungsten/placement/setTranslation 0. 0. 0. mm



#Detecteur Dose Charbel - contient deux ouvertures en alu
#=============================================================================================================
/gate/world/daughters/name DetecteurCharbel
/gate/world/daughters/insert box
/gate/DetecteurCharbel/setMaterial G4_AIR
/gate/DetecteurCharbel/geometry/setXLength 6. cm
/gate/DetecteurCharbel/geometry/setYLength 6. cm
/gate/DetecteurCharbel/geometry/setZLength ${Calcul_DetecteurCharbel_geometry_setZLength} mm
/gate/DetecteurCharbel/vis/setColor white
/gate/DetecteurCharbel/vis/forceWireframe
#/gate/DetecteurCharbel/vis/forceSolid
/gate/DetecteurCharbel/placement/setTranslation 0. 0. 45.1467 mm


#Aluminium - 2 couches de 20 micron espacé de 5cm en entrée et sortie du système PM  - 1cm après le tungsten
/gate/DetecteurCharbel/daughters/name Alu_in
/gate/DetecteurCharbel/daughters/insert box
/gate/Alu_in/setMaterial G4_Al
/gate/Alu_in/geometry/setXLength 6. cm
/gate/Alu_in/geometry/setYLength 6. cm
/gate/Alu_in/geometry/setZLength ${Calcul_Alu_in_geometry_setZLength} mm
/gate/Alu_in/vis/setColor gray
#/gate/Alu_in/vis/forceWireframe
/gate/Alu_in/vis/forceSolid
/gate/Alu_in/placement/setTranslation 0. 0. ${Calcul_Alu_in_placement_setTranslation_Z} mm

/gate/DetecteurCharbel/daughters/name Alu_out
/gate/DetecteurCharbel/daughters/insert box
/gate/Alu_out/setMaterial G4_Al
/gate/Alu_out/geometry/setXLength 6. cm
/gate/Alu_out/geometry/setYLength 6. cm
/gate/Alu_out/geometry/setZLength ${Calcul_Alu_out_geometry_setZLength} mm
/gate/Alu_out/vis/setColor gray
#/gate/Alu_out/vis/forceWireframe
/gate/Alu_out/vis/forceSolid
/gate/Alu_out/placement/setTranslation 0. 0. ${Calcul_Alu_out_placement_setTranslation_Z} mm



#2 micron de cuivre avant le colli pour monitorer les RX - 1cm avant le colli 
#=============================================================================
# Charbel 26/02/2020 : Placement et utilisation non décidée

/gate/world/daughters/name Cuivre
/gate/world/daughters/insert box
/gate/Cuivre/setMaterial G4_Cu
/gate/Cuivre/geometry/setXLength 20. cm
/gate/Cuivre/geometry/setYLength 20. cm
/gate/Cuivre/geometry/setZLength ${Calcul_Cuivre_geometry_setZLength} mm
/gate/Cuivre/vis/setColor red
#/gate/Cuivre/vis/forceWireframe
/gate/Cuivre/vis/forceSolid true
/gate/Cuivre/placement/setTranslation 0. 0. 1610. mm




#COLLIMATEUR 1 collé à la cible
#=============================================================================================================
#/gate/world/daughters/name colli1
#/gate/world/daughters/insert box
#/gate/colli1/setMaterial G4_Al
#/gate/colli1/geometry/setXLength 20. cm
#/gate/colli1/geometry/setYLength 20. cm
#/gate/colli1/geometry/setZLength 2.5 cm
#/gate/colli1/vis/setColor grey
#/gate/colli1/vis/forceSolid true
#/gate/colli1/placement/setTranslation 0. 0. 163.75 cm

/gate/world/daughters/name colli1
/gate/world/daughters/insert cylinder
/gate/colli1/setMaterial G4_Al
/gate/colli1/geometry/setRmin 0 cm
/gate/colli1/geometry/setRmax 10 cm
/gate/colli1/geometry/setHeight ${Calcul_colli1_geometry_setHeight} mm
/gate/colli1/vis/setColor grey
/gate/colli1/vis/forceSolid true
/gate/colli1/placement/setTranslation 0. 0. 163.75 cm


#TROU colli1

/gate/colli1/daughters/name trou1
/gate/colli1/daughters/insert cylinder
/gate/trou1/setMaterial G4_AIR
/gate/trou1/geometry/setRmin 0. cm
/gate/trou1/geometry/setRmax 0.5 cm
/gate/trou1/geometry/setHeight ${Calcul_trou1_geometry_setHeight} mm
/gate/trou1/vis/setColor white
/gate/trou1/vis/forceSolid true


/gate/world/daughters/name frite_colli_before
/gate/world/daughters/insert box
/gate/frite_colli_before/setMaterial G4_AIR
/gate/frite_colli_before/geometry/setXLength 40 cm
/gate/frite_colli_before/geometry/setYLength 40 cm
/gate/frite_colli_before/geometry/setZLength 0.01 cm
/gate/frite_colli_before/placement/setTranslation 0. 0. ${Calcul_frite_colli_before_placement_setTranslation_Z} mm
/gate/frite_colli_before/vis/setColor magenta
/gate/frite_colli_before/vis/forceSolid

/gate/world/daughters/name frite_colli_after
/gate/world/daughters/insert box
/gate/frite_colli_after/setMaterial G4_AIR
/gate/frite_colli_after/geometry/setXLength 40 cm
/gate/frite_colli_after/geometry/setYLength 40 cm
/gate/frite_colli_after/geometry/setZLength 0.01 cm
/gate/frite_colli_after/placement/setTranslation 0. 0. ${Calcul_frite_colli_after_placement_setTranslation_Z} mm
/gate/frite_colli_after/vis/setColor magenta
/gate/frite_colli_after/vis/forceSolid



EOM





done



   
END=$(date +%s)
DIFF=$(( $END - $START ))
   
echo "temps ${DIFF} [s]"


