# -*- coding: utf-8 -*-
"""
Created on Mon Mar 16 11:47:57 2020

@author: s-chiavassa
"""
import SimpleITK
import os
import numpy as np
import matplotlib.pyplot as plt
import glob
import math
from math import sqrt

# L'objectif du script margeGATE.py est de calculer la dose et l'incertitude totale en
# mergeant plusieurs simulations Gate. Le nombre de particules initiales par simu
# peut être différent. Ce nombre est récupéré dans le fichier statistique généré par GATE 
# et sauvé dans le répertoire output pour chaque simu.  
# Ce répertoire doit comporter la dose, l'incertitude et la 
# dose_squared au format analyze. Toutes les matrices doivent avoir la même taille.
# Tous les répertoires outputs doivent être dans un même répertoire \output\
# placé au même niveau que le script.
########################################################################################


# calcul du nombre de simulations à merger et récupération des paths
##############################################################################

print ('Path ',os.getcwd()) 
path = os.getcwd() + '\output'
l = glob.glob(path+'\\*') 
nb_simus = len(l)
print('nombre de simulations en parallèles : ', nb_simus)

# recherche des path des fichiers dans les répertoires
##########################################################
tab_path_dose=nb_simus*[]
tab_path_squared=nb_simus*[]
tab_path_particules=nb_simus*[]

for i in range (0,nb_simus):
    for f in os.listdir(l[i]):
        if '-Dose.img' in f:
            tab_path_dose.append(os.path.join(l[i],f))
        if '-Squared.img' in f:
            tab_path_squared.append(os.path.join(l[i],f))
        if '-Dose.hdr' in f:
            chemin_info = os.path.join(l[i],f)
        if 'stat.ascii' in f:
            tab_path_particules.append(os.path.join(l[i],f))

#print tab_path_dose
#print tab_path_squared
#print tab_path_particules

# ouverture du header
########################
#print chemin_info
print ('Chemin info ',chemin_info) 

header = np.fromfile(chemin_info, dtype=np.int16)
print('taille des matrices de dose, dose squared et incertitude: ', header[21], header[22], header[23])
headshape=(header[21], header[22], header[23])

# Ouverture des fichiers dose et dose_squared 
#################################################################
head_dose = []
head_squared = []

for i in range (0,nb_simus):
    img = SimpleITK.ReadImage(tab_path_dose[i])     
    arr = SimpleITK.GetArrayFromImage(img)
    head_dose.append(np.ndarray.tolist(arr))
    img = SimpleITK.ReadImage(tab_path_squared[i])  
    arr = SimpleITK.GetArrayFromImage(img)
    head_squared.append(np.ndarray.tolist(arr))

# récupération du nombre de particules par simus
####################################################################################
Nb_particules=np.zeros(nb_simus, int)

for i in range (0,nb_simus):
    fichier = open(tab_path_particules[i], 'r')
    data = fichier.read()
    columns = data.split()
    Nb_particules[i] = columns[7]
    print('le nombre de particules de la simulation ', i, ' est ', Nb_particules[i])

Nb_particules_total = np.sum(Nb_particules) 
print('le nombre de particules totales est ', Nb_particules_total)


# calcul de la dose totale
#########################################
dose_totale = np.sum(head_dose, axis=0)
squared_total =  np.sum(head_squared, axis=0)


# calcul de l'incertitude globale
##########################################

A = np.zeros(shape=headshape) 
s = np.zeros(shape=headshape)
somme1 = squared_total / Nb_particules_total
somme2 = dose_totale / Nb_particules_total


for ux in range(0, headshape[0]):
    for uy in range(0, headshape[1]):
        for uz in range(0, headshape[2]):
            A[ux][uy][uz] = (1/(float(Nb_particules_total-1)))* (somme1[ux][uy][uz]-(somme2[ux][uy][uz]*somme2[ux][uy][uz]))
            s[ux][uy][uz] = sqrt(A[ux][uy][uz])
            s[ux][uy][uz] = s[ux][uy][uz] / dose_totale[ux][uy][uz]
            s[ux][uy][uz] = s[ux][uy][uz] * Nb_particules_total


# Création et sauvegarde des images dose et incertitude résultat au format analyze
# ATTENTION, les images sont flippées verticalement. Dans ImageJ, faire flip verticaly 
# pour les remettre.
#######################################################################################
img1 = SimpleITK.GetImageFromArray(dose_totale)
path_save1 = os.getcwd() +'\dose_totale.hdr'
SimpleITK.WriteImage(img1, path_save1)
img2 = SimpleITK.GetImageFromArray(s)
path_save2 = os.getcwd() +'\dose_totale2.hdr'
SimpleITK.WriteImage(img2, path_save2)
