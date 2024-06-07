# Formations au logiciel Cast3M

Ce dépôt contient les sources de documents de formation à Cast3M

Les présentations sont construite avec LaTeX grâce à la classe Beamer

## Construction des présentations
Afin d'avoir un bon référencements des sections, il faut compiler deux fois avec pdflatex.
Par exemple, pour la formation débutants, faire :
```bash
cd debutant
pdflatex debutant
pdflatex debutant
rm debutant.snm debutant.aux debutant.out debutant.nav debutant.toc debutant.log
```
## Rôle des fichiers
Un répertoire par formation :
- Répertoire "debutant" : pour la formation "débutants"
- Répertoire "pasapas" : pour les formation avancée sur PASAPAS et les procédures utilisateurs

Pour chaque formation (par exemple debutant) :
- debutant.tex : fichier principal, à compiler avec pdflatex
- debutant_part_intro.tex : sous partie, incluse dans le document principal
- ...
- description_gibiane.tex : description du langage Gibiane (pour le paquet "listings")
- /dgibi : cas tests Gibiane pour cette formation, ils créent des figures .ps
- images.sh : traitement des images .ps contenues dans /dgibi (suppression de titres, éclatement en plusieurs fichiers, convertion en .pdf ...)
- /images : images de la présentation
