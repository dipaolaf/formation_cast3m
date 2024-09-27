# Traitement des images .ps générées par Cast3M
# afin d'être intégrées dans une présentation LaTeX
# Au programme :
# - modification des images (suppression titres, déplacement isovaleurs ...)
# - éclatement des fichiers .ps
# - convertion des images .ps en .pdf

# Dépendances :
# pssplit.sh   (S. Gounand)
# cast-post.sh (S. Gounand)
# ps2eps
# ps2pdf


# Copie des fichiers .ps
echo "[1/5] Copie des fichiers"
cp dgibi/*.ps images/.
cd images/


# Traitement des pages
echo "[2/5] Traitement des images .ps (retrait des légendes, titres ...)"
for i in *.ps
do
# pour les fichiers ci-dessous : retrait [titre + legende + isovaleurs]
  if [ "${i}" = "exo_4_temperature.ps" ] ||
     [ "${i}" = "exo_4_solu_temperature.ps" ] ||
     [ "${i}" = "exo_4_solu_bis_temperature.ps" ]
  then
    cast-post.sh -o -t -c 2 ${i}
# pour les fichiers ci-dessous : retrait [titre + legende + isovaleurs] + epaisseur trait
  elif [ "${i}" = "exemple_0.ps" ] ||
       [[ "${i}" == exo_1_*.ps ]]  ||
       [ "${i}" = "exo_2_chargement.ps" ]
  then
    cast-post.sh -o -t -c 2 -l 10 ${i}
# pour les fichiers ci-dessous : retrait titre, déplacement isovaleurs, changement taille fonte + epaisseur trait
  elif [ "${i}" = "exemple_1.ps" ] ||
       [ "${i}" = "exemple_2.ps" ] ||
       [[ "${i}" == "exo_3_temperature.ps" ]] ||
       [[ "${i}" == "exo_3_solu_temperature.ps" ]]
  then
    cast-post.sh -o -t -c 1 -s 15 -l 10 ${i}
# et pour tous les autres : retrait titre, déplacement isovaleurs, changement taille fonte + epaisseur trait
  else
    cast-post.sh -o -t -c 1 -s 15 -l 10 ${i}
  fi
done


# Éclatement des pages (si besoin seulement)
echo "[3/5] Extraction des pages"
for i in *.ps
do
  np=$(grep -c '%%Page:' ${i})
  if [ "${np}" -gt 1 ] ; then
    pssplit.sh ${i}
    rm ${i}
  fi
done


# Convertion en .eps
echo "[4/5] Convertion en eps"
for i in *.ps
do
  ps2eps -R + ${i} >/dev/null 2>&1
done


# Convertion en .pdf
echo "[5/5] Convertion en pdf"
for i in *.eps
do
  ps2pdf -dEPSCrop ${i}
done


# Ménage des fichiers
mv -f exemple*.pdf exemple/.
mv -f exo*.pdf exo/.
rm *.ps *.eps
cd ..
