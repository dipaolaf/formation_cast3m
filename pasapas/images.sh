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
# pour les fichiers ci-dessous : retrait du titre et legende, déplacement isovaleurs, changement taille fonte et epaisseur trait
  if [ "${i}" = "exemple_0.ps" ]
  then
    cast-post.sh -o -t -c 2 -s 15 -l 10 ${i}
# pour les fichiers ci-dessous : retrait du titre, déplacement isovaleurs, changement taille fonte et epaisseur trait
  elif [ "${i}" = "exemple_1.ps" ] ||
       [ "${i}" = "exemple_2.ps" ]
  then
    cast-post.sh -o -t -c 1 -s 15 -l 10 ${i}
# et pour tous les autres : retrait du titre, déplacement isovaleurs, changement taille fonte
  else
    cast-post.sh -o -t -c 1 -s 15 ${i}
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
rm *.ps *.eps
cd ..
