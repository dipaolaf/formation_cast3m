Formations au logiciel Cast3M
=============================

Ce dépôt héberge le code source des documents de formation au logociel Cast3M

Les présentations sont construites avec LaTeX grâce à la classe Beamer

Construction des présentations
------------------------------
Marche à suivre pour la formation débutants

**1) Calculs Cast3M**

Lancez les calculs Cast3M de tous les fichiers .dgibi :
```bash
cd dgibi/
castem24 formation_debutant_1_maillage.dgibi
castem24 formation_debutant_2_thermique.dgibi
castem24 formation_debutant_3_mecanique.dgibi
castem24 plaque.dgibi
...
```
Ce qui créera plein de fichiers .ps

**2) Traitement des images**

Revenir dans le répertoire parent et lancer le traitement des images :
```bash
cd ../
./images.sh
```
Ce qui créera plein d'images .pdf dans le répertoire /images

Cette étape peu prendre du temps...

**3) Compilation LaTeX**

Afin d'avoir un bon référencements des sections, il faut compiler deux fois avec pdflatex :
```bash
pdflatex debutant
pdflatex debutant
```
Enfin, on peut faire un ménage des fichiers temporaires :
```bash
rm *.aux *.log *.nav *.out *.snm *.toc
```

Rôles des fichiers
------------------
Un répertoire par formation :
- /debutant : pour la formation "débutants"
- /pasapas : pour la formation avancée sur PASAPAS et les procédures utilisateurs

Pour chaque formation (par exemple debutant) :
- debutant.tex : fichier principal, à compiler avec pdflatex
- debutant_presentation.tex : sous partie, incluse dans le document principal
- ...
- description_gibiane.tex : description du langage Gibiane (pour le paquet "listings")
- /dgibi : cas tests Gibiane pour cette formation, ils créent des figures .ps
- images.sh : traitement des images .ps contenues dans /dgibi (suppression de titres, éclatement en plusieurs fichiers, convertion en .pdf ...)
- /images : images .pdf et .png utilisées dans le document final
