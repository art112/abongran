#!/bin/bash

# déclaration d'une fonction
MakeFilm_EBT3() 
{ local varlocal="je suis la fonction"
  echo " "
  echo "***"
  echo "MakeFilmEBT3 $varlocal $0"
  echo "Nombres de paramètres : $#"
  
#   for ((i=0; i<$#; i+=1)); do
#   echo ${i} "$i"
#   done

  
  local CompletePathGeometry="$1"
  
  local MotherVolume="$2"
  
  local NameFilm="$3"

  local Position_Film="$4" ;local Position_Film_Unit="$5"
  local Size_X_Film="$6" ; local Size_X_Film_Unit="$7"
  local Size_Y_Film="$8" ; local  Size_Y_Film_Unit="$9"
  
  local Lenght_Film=${10} ### EBT3 2*125 + 28
  local Lenght_Film_Unit=${11}

  local Lenght_Film_Active_Layer=${12}
  local Lenght_Film_Active_Layer_Unit=${13}
  
  
  echo " "
  echo "CompletePathGeometry ${CompletePathGeometry}"
  echo "MotherVolume ${MotherVolume}"
  echo "Name ${NameFilm}"
  echo "Position ${Position_Film} ${Position_Film_Unit}"
  echo "Size_X_Film ${Size_X_Film} ${Size_X_Film_Unit}"
  echo "Size_Y_Film ${Size_Y_Film} ${Size_Y_Film_Unit}"
  echo "Lenght_Film ${Lenght_Film} ${Lenght_Film_Unit}"
  echo "Lenght_Film_Active_Layer ${Lenght_Film_Active_Layer} ${Lenght_Film_Active_Layer_Unit}"
  echo " "
  
#   MakeFilm_EBT3 "./geometry/Geo" "world" "F_1" "0" "um" "6" "cm" "6" "cm"
  
  ### Parametres calcules
  
  NameFilm_ActiveLayer="${NameFilm}_ActiveLayer"
  
  ### Fil EBT3 : Une couche active de 28 um et deux couche de PET de 125 um
  ### Simulée comme un cube de PET inseré

/bin/cat <<EOM >> ${CompletePathGeometry}.mac

    ##############################################################################################################################################
    # ${NameFilm}
    ##############################################################################################################################################
 
    /gate/${MotherVolume}/daughters/name ${NameFilm}
    /gate/${MotherVolume}/daughters/insert box
    ### 
    /gate/${NameFilm}/setMaterial Layer_EBT3
    /gate/${NameFilm}/geometry/setXLength ${Size_X_Film} ${Size_X_Film_Unit}
    /gate/${NameFilm}/geometry/setYLength ${Size_Y_Film} ${Size_Y_Film_Unit}
    ### 125 * 2 + 28 um 
    /gate/${NameFilm}/geometry/setZLength ${Lenght_Film} ${Lenght_Film_Unit}
    /gate/${NameFilm}/vis/setColor white
    #/gate/${NameFilm}/vis/forceWireframe
    /gate/${NameFilm}/vis/forceSolid
    /gate/${NameFilm}/placement/setTranslation 0. 0. ${Position_Film} ${Position_Film_Unit}
  
    /gate/${NameFilm}/daughters/name ${NameFilm_ActiveLayer}
    /gate/${NameFilm}/daughters/insert box
    ### 
    /gate/${NameFilm_ActiveLayer}/setMaterial Active_Layer_EBT3 
    #EBT3_ActiveLayer
    /gate/${NameFilm_ActiveLayer}/geometry/setXLength ${Size_X_Film} ${Size_X_Film_Unit}
    /gate/${NameFilm_ActiveLayer}/geometry/setYLength ${Size_Y_Film} ${Size_Y_Film_Unit}
    ###  
    /gate/${NameFilm_ActiveLayer}/geometry/setZLength ${Lenght_Film_Active_Layer} ${Lenght_Film_Active_Layer_Unit}
    /gate/${NameFilm_ActiveLayer}/vis/setColor blue
    #/gate/${NameFilm_ActiveLayer}/vis/forceWireframe
    /gate/${NameFilm_ActiveLayer}/vis/forceSolid
    /gate/${NameFilm_ActiveLayer}/placement/setTranslation 0. 0. 0. mm
  
EOM

echo "***"
}

# appel de ma fonction
# maFonction "Hello" "World!"

# déclaration d'une fonction
MakeBox() 
{ local varlocal="je suis la fonction"
  echo " "
  echo "***"
  echo "MakeBox $varlocal $0"
  echo "Nombres de paramètres : $#"
  
#   for ((i=0; i<$#; i+=1)); do
#   echo ${i}
#   done

  
  local CompletePathGeometry="$1"
  
  local MotherVolume="$2"
  
  local NameFilm="$3"

  local Position_Length="$4" ;local Position_Length_Unit="$5"
  local Size_X_Length="$6" ;local Size_X_Length_Unit="$7"
  local Size_Y_Length="$8" ;local Size_Y_Length_Unit="$9"
  local Size_Z_Length="${10}" ;local Size_Z_Length_Unit="${11}"
  
  local Mater=${12}
  
  echo " "
  echo "CompletePathGeometry ${CompletePathGeometry}"
  echo "MotherVolume ${MotherVolume}"
  echo "Name ${NameFilm}"
  echo "Position ${Position_Length} ${Position_Length_Unit}"
  echo "Size_X_Length ${Size_X_Length} ${Size_X_Length_Unit}"
  echo "Size_Y_Length ${Size_Y_Length} ${Size_Y_Length_Unit}"
  echo "Size_Z_Length ${Size_Z_Length} ${Size_Z_Length_Unit}"
  echo "Mater ${Mater}"
  echo " "
  
#   MakeBox "./geometry/Geo" "world" "F_1" "0" "um" "6" "cm" "6" "cm"
  

  
  ### Fil EBT3 : Une couche active de 28 um et deux couche de PET de 125 um
  ### Simulée comme un cube de PET inseré

/bin/cat <<EOM >> ${CompletePathGeometry}.mac
    
    ##############################################################################################################################################
    # ${NameFilm}
    ##############################################################################################################################################
    
    /gate/${MotherVolume}/daughters/name ${NameFilm}
    /gate/${MotherVolume}/daughters/insert box
    ### 
    /gate/${NameFilm}/setMaterial  ${Mater}
    /gate/${NameFilm}/geometry/setXLength ${Size_X_Length} ${Size_X_Length_Unit}
    /gate/${NameFilm}/geometry/setYLength ${Size_Y_Length} ${Size_Y_Length_Unit}
    /gate/${NameFilm}/geometry/setZLength ${Size_Z_Length} ${Size_Z_Length_Unit}
    /gate/${NameFilm}/vis/setColor white
    #/gate/${NameFilm}/vis/forceWireframe
    /gate/${NameFilm}/vis/forceSolid
    /gate/${NameFilm}/placement/setTranslation 0. 0. ${Position_Length} ${Position_Length_Unit}
  
EOM
echo "***"
}

# 
MakeDoseActor() 
{ local varlocal="je suis la fonction"
  echo " "
  echo "***"
  echo "MakeDoseActor $varlocal $0"
  echo "Nombres de paramètres : $#"
  
#   for ((i=0; i<$#; i+=1)); do
#   echo ${i}
#   done

  
  local CompletePathGeometry="$1"
  local Extension="$2"
  local NameFilm="$3"

  local setResolution_X="$4" ;
  local setResolution_Y="$5" ;
  local setResolution_Z="${6}";
  
  echo " "
  echo "CompletePathGeometry ${CompletePathGeometry}"
  echo "Extension ${Extension}"
  echo "Name ${NameFilm}"
  echo "setResolution_X ${setResolution_X}"
  echo "setResolution_Y ${setResolution_Y}"
  echo "setResolution_Z ${setResolution_Z}"
  echo " "
  
  NameDoseActor="${NameFilm}_Actor"
  
/bin/cat <<EOM >> ${CompletePathGeometry}.mac
    
    ##############################################################################################################################################
    # ${NameFilm} ${NameDoseActor}
    ##############################################################################################################################################

    /gate/actor/addActor DoseActor ${NameDoseActor}
    /gate/actor/${NameDoseActor}/save output/${NameDoseActor}.${Extension}
    /gate/actor/${NameDoseActor}/attachTo ${NameFilm}
    /gate/actor/${NameDoseActor}/setResolution ${setResolution_X} ${setResolution_Y} ${setResolution_Z}
    /gate/actor/${NameDoseActor}/saveEveryNSeconds 60
    /gate/actor/${NameDoseActor}/stepHitType random
    /gate/actor/${NameDoseActor}/enableEdep true
    /gate/actor/${NameDoseActor}/enableUncertaintyEdep true
    /gate/actor/${NameDoseActor}/enableSquaredEdep false
    /gate/actor/${NameDoseActor}/enableDose true
    /gate/actor/${NameDoseActor}/enableUncertaintyDose true
    /gate/actor/${NameDoseActor}/enableSquaredDose false
    /gate/actor/${NameDoseActor}/enableDoseToWater true
    /gate/actor/${NameDoseActor}/enableUncertaintyDoseToWater true
    /gate/actor/${NameDoseActor}/enableSquaredDoseToWater false
    /gate/actor/${NameDoseActor}/enableNumberOfHits true
  
EOM
echo "***"
}

MakeDoseActor_SetSize() 
{ local varlocal="je suis la fonction"
  echo " "
  echo "***"
  echo "MakeDoseActor $varlocal $0"
  echo "Nombres de paramètres : $#"
  
#   for ((i=0; i<$#; i+=1)); do
#   echo ${i}
#   done

  
  local CompletePathGeometry="$1"
  local Extension="$2"
  local NameFilm="$3"

  local setResolution_X="$4" ;
  local setResolution_Y="$5" ;
  local setResolution_Z="${6}";
  
  local setSize_X="$7" ;
  local setSize_Y="$8" ;
  local setSize_Z="${9}";
  local setSize_Unit="${10}";
  
  
  echo " "
  echo "CompletePathGeometry ${CompletePathGeometry}"
  echo "Extension ${Extension}"
  echo "Name ${NameFilm}"
  echo "setResolution_X ${setResolution_X}"
  echo "setResolution_Y ${setResolution_Y}"
  echo "setResolution_Z ${setResolution_Z}"
  echo "setSize_X ${setSize_X}"
  echo "setSize_Y ${setSize_Y}"
  echo "setSize_Z ${setSize_Z}"
  echo "setSize_Unit ${setSize_Unit}"
  echo " "
  
  NameDoseActor="${NameFilm}_Actor"
  
/bin/cat <<EOM >> ${CompletePathGeometry}.mac
    
    ##############################################################################################################################################
    # ${NameFilm} ${NameDoseActor}
    ##############################################################################################################################################

    /gate/actor/addActor DoseActor ${NameDoseActor}
    /gate/actor/${NameDoseActor}/save output/${NameDoseActor}.${Extension}
    /gate/actor/${NameDoseActor}/attachTo ${NameFilm}
    /gate/actor/${NameDoseActor}/setSize ${setSize_X} ${setSize_Y} ${setSize_Z} ${setSize_Unit}
    /gate/actor/${NameDoseActor}/setResolution ${setResolution_X} ${setResolution_Y} ${setResolution_Z}
    /gate/actor/${NameDoseActor}/saveEveryNSeconds 60
    /gate/actor/${NameDoseActor}/stepHitType random
    /gate/actor/${NameDoseActor}/enableEdep true
    /gate/actor/${NameDoseActor}/enableUncertaintyEdep true
    /gate/actor/${NameDoseActor}/enableSquaredEdep true
    /gate/actor/${NameDoseActor}/enableDose true
    /gate/actor/${NameDoseActor}/enableUncertaintyDose true
    /gate/actor/${NameDoseActor}/enableSquaredDose true
    /gate/actor/${NameDoseActor}/enableDoseToWater true
    /gate/actor/${NameDoseActor}/enableUncertaintyDoseToWater true
    /gate/actor/${NameDoseActor}/enableSquaredEdep true
    /gate/actor/${NameDoseActor}/enableNumberOfHits true
  
EOM
echo "***"
}


START=$(date +%s) # Pour calculer le temps de calcul

echo Running on host `hostname` # Done le nom du system
HOSTNAME=`hostname`


###########################################################################################################################################
###########################################################################################################################################

# Création du .mac main

###########################################################################################################################################
###########################################################################################################################################

NameStack="Stack_ManipZebra_28_05_20_v3"
File=Stack

CompletePathGeometry="./geometry/$File" 
mkdir -p $CompletePathGeometry
CompletePathGeometry="$CompletePathGeometry/$NameStack"

CompletePathGeometry_Actor="${CompletePathGeometry}_Actor"

### COnception du Stack

### Film F B Box

declare -a Ordre_Stack
declare -a Size_X
declare -a Size_Z


# Ordre_Stack[0]="B"
# Size_X[0]="4"
# Size_Z[0]="13"


for ((ov=0; ov<25; ov++)); do

echo ${ov}

Ordre_Stack[${ov}]="BD"
Size_X[${ov}]="4"
Size_Z[${ov}]="1"
done

# declare -p Ordre_Stack

# declare -p Size_X
# declare -p Size_Z

Ordre_Stack[25]="B"
Size_X[25]="4"
Size_Z[25]="13"


# Ordre_Stack=(F B F B F B F B F F F F B)

# Size_X=(6 30 6 30 6 10 6 10 6 6 6 6 10)
Size_X_Unit="cm"

### mm
# Size_Z=(0 25 0 5 0 0.5 0 0.5 0 0 0 0 4.776)
Size_Z_Unit="mm"

# Film
Film_Lenght=0.278 ### EBT3 2*125 + 28
Film_Lenght_Unit=mm

Film_Lenght_Active_Layer=0.028
Film_Lenght_Active_Layer_Unit="mm"

### Box 

Box_Mater="G4_PLEXIGLASS"

echo end

#### Fin de conception

lenOrdre_Stack=${#Ordre_Stack[@]}  # nombre d'éléments dans le tableau
NbrBox=0
NbrFilm=0

for ((ov=0; ov<$lenOrdre_Stack; ov++)); do

    if [ ${Ordre_Stack[ov]} = "F" ]
    then
    let "NbrFilm=${NbrFilm}+1"

    elif [ ${Ordre_Stack[ov]} = "B" ]
    then
    let "NbrBox=${NbrBox}+1"
    
    elif [ ${Ordre_Stack[ov]} = "BD" ]
    then
    let "NbrBox=${NbrBox}+1"
    
    else
    echo "FATAL ERROR Unknow Type_Space_Disk_For_Save ${Type_Space_Disk_For_Save}"
    exit
    fi

done


### Recherche du max pour l'ensemble des sacks
# IFS=$'\n'
# Max=`echo "${Size_X[*]}" | sort -nr | head -n1`
# echo "Max ${Max}"

max=${Size_X[0]}
for n in "${Size_X[@]}" ; do
    ((n > max)) && max=$n
done
echo "Max $max"


echo "NbrBox ${NbrBox}"
echo "NbrFilm ${NbrFilm}"

SizeWorld_X_Y=$max
echo "SizeWorld_X_Y $SizeWorld_X_Y $Size_X_Unit"


# array=( -1.75 -2.75 -3.75 -4.75 -5.75 -6.75 -7.75 -8.75 )
SizeWorld_Z=`dc <<< '[+]sa[z2!>az2!>b]sb'"${Size_Z[*]//-/_}lbxp"`

SizeWorld_Z=$(echo "($Film_Lenght * $NbrFilm + $SizeWorld_Z )"|bc -l)
echo "SizeWorld_Z $SizeWorld_Z"
# SizeWorld_Z=$(echo "($NbrBox *   $tungsten_geometry_setZLength)"|bc -l)


### Make Stack init

/bin/cat <<EOM > ${CompletePathGeometry}.mac
##############################################################################################################################################
# $NameStack
##############################################################################################################################################
EOM

/bin/cat <<EOM > $CompletePathGeometry_Actor.mac
##############################################################################################################################################
# $NameStack Actor
##############################################################################################################################################
EOM


# TODO Position
### World

NameStack=Stack_1
MakeBox "${CompletePathGeometry}" "world" "$NameStack" "1439.535" "mm" "$SizeWorld_X_Y" "$Size_X_Unit" "$SizeWorld_X_Y" "$Size_X_Unit" "$SizeWorld_Z" "$Size_Z_Unit" "G4_AIR"

SetSizebinDoseactor=$(echo "($SizeWorld_Z*100)"|bc -l) 

SetSizebinDoseactor=$(echo "$SetSizebinDoseactor" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')


MakeDoseActor_SetSize "$CompletePathGeometry_Actor" "root" "${NameStack}" "1" "1" "${SetSizebinDoseactor}" "1" "1" "$SizeWorld_Z" "$Size_Z_Unit"

###

NbrBox=0
NbrFilm=0

Z_Position=$(echo "(-1*($SizeWorld_Z/2))"|bc -l)
echo "Zposition $Z_Position"

for ((ov=0; ov<$lenOrdre_Stack; ov++)); do

    if [ ${Ordre_Stack[ov]} = "F" ]
    then
    
    let "NbrFilm=${NbrFilm}+1"
    ## Calcul de la position
    Z_Position=$(echo "($Z_Position+($Film_Lenght/2))"|bc -l)
    MakeFilm_EBT3 "${CompletePathGeometry}" "$NameStack" "F_${NbrFilm}" "$Z_Position" "$Size_Z_Unit" "${Size_X[ov]}" "$Size_X_Unit" "${Size_X[ov]}" "$Size_X_Unit" "$Film_Lenght" "$Film_Lenght_Unit" "$Film_Lenght_Active_Layer" "$Film_Lenght_Active_Layer_Unit"
    Z_Position=$(echo "($Z_Position+($Film_Lenght/2))"|bc -l)
    
    MakeDoseActor "$CompletePathGeometry_Actor" "root" "F_${NbrFilm}_ActiveLayer" "600" "600" "1"
    
    elif [ ${Ordre_Stack[ov]} = "B" ]
    then
    let "NbrBox=${NbrBox}+1"
    Z_Position=$(echo "($Z_Position+(${Size_Z[ov]}/2))"|bc -l)
    MakeBox "${CompletePathGeometry}" "$NameStack" "B_${NbrBox}" "$Z_Position" "$Size_Z_Unit" "${Size_X[ov]}" "$Size_X_Unit" "${Size_X[ov]}" "$Size_X_Unit" "${Size_Z[ov]}" "$Size_Z_Unit" "$Box_Mater"
    Z_Position=$(echo "($Z_Position+(${Size_Z[ov]}/2))"|bc -l)
    
    elif [ ${Ordre_Stack[ov]} = "BD" ]
    then
    let "NbrBox=${NbrBox}+1"
    Z_Position=$(echo "($Z_Position+(${Size_Z[ov]}/2))"|bc -l)
    MakeBox "${CompletePathGeometry}" "$NameStack" "BD_${NbrBox}" "$Z_Position" "$Size_Z_Unit" "${Size_X[ov]}" "$Size_X_Unit" "${Size_X[ov]}" "$Size_X_Unit" "${Size_Z[ov]}" "$Size_Z_Unit" "$Box_Mater"
    Z_Position=$(echo "($Z_Position+(${Size_Z[ov]}/2))"|bc -l)
    
    MakeDoseActor "$CompletePathGeometry_Actor" "root" "BD_${NbrBox}" "400" "400" "1"
    
    else
    echo "FATAL ERROR Unknow Type_Space_Disk_For_Save ${Type_Space_Disk_For_Save}"
    exit
    fi
    
    echo "Zposition $Z_Position"

done




# /gate/physics/Gamma/SetCutInRegion Stack_1 0.1 mm
# /gate/physics/Electron/SetCutInRegion Stack_1 0.1 mm
# /gate/physics/Proton/SetCutInRegion Stack_1 0.005 mm
# /gate/physics/Positron/SetCutInRegion Stack_1 0.1 mm
# /gate/physics/SetMaxStepSizeInRegion Stack_1 0.01 mm


### COrrection pour la visu
sed -i "s/#\/gate\/Stack_1\/vis\/forceWireframe/\/gate\/Stack_1\/vis\/forceWireframe/g"      ${CompletePathGeometry}.mac
sed -i "s/\/gate\/Stack_1\/vis\/forceSolid/#\/gate\/Stack_1\/vis\/forceSolid/g"      ${CompletePathGeometry}.mac




   
END=$(date +%s)
DIFF=$(( $END - $START ))
   
echo "temps ${DIFF} [s]"


