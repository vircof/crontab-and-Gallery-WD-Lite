#!/bin/bash
clear

## DEPENDENCIAS:
## comandos/programas basicos: cp mv rm clear cat touch chmod chown
## Programas que hay que instalar: php5 mogrify 

## Para minimizar los tiempos de ejecucion de php, este cript redimensionará las 
## imagenes utilizando un comando lanzado desde shell, llamado mogrify
## copiará y movera los archivos de igual manera, con shell
## y php solo se utilizará para la insercion o eliminacion de datos en la BD (Base de datos)


#incluimos variables
. ./variables.sh

## copiamos los archivos

mkdir "$PACH_IMAGENES"/tmp

echo "Copiando imagenes:"
cp "$PACH_IMAGENES"/* "$PACH_IMAGENES/tmp/"

echo "Realizando conversión de formatos a jpg"
## pasamos a formato jpg... por si acaso
mogrify -format jpg "$PACH_IMAGENES"/tmp/*

echo "Redimensionando las imagenes grandes"
## redimensionamos las imagenes a una ancho de $ANCHO_IMG_BIG con una altura proporcional.
## Estas imagenes serán las de la vista grande.
mogrify -resize "$ANCHO_IMG_BIG"x "$PACH_IMAGENES"/tmp/*.jpg

echo "gestionando archivos"
## salvamos las imagenes buenas y eliminamos el resto
mkdir "$PACH_IMAGENES"/to_save
mv "$PACH_IMAGENES"/tmp/*.jpg "$PACH_IMAGENES"/to_save
rm "$PACH_IMAGENES"/tmp/*
mv "$PACH_IMAGENES"/to_save/* "$PACH_IMAGENES"/tmp
rm -r "$PACH_IMAGENES"/to_save


## Creamos los directorios temporales de Big y Small
mkdir "$PACH_IMAGENES"/tmp/small
mkdir "$PACH_IMAGENES"/tmp/big

## distribuimos los archivos

mv "$PACH_IMAGENES"/tmp/*.jpg "$PACH_IMAGENES"/tmp/big
cp "$PACH_IMAGENES"/tmp/big/* "$PACH_IMAGENES"/tmp/small

## calculamos las miniaturas a un ancho de ANCHO_IMG_SMALL

echo "Redimensionando miniaturas"
mogrify -resize "$ANCHO_IMG_SMALL"x "$PACH_IMAGENES"/tmp/small/*.jpg

## bien, ya tenemos las imagenes a las resoluciones indicadas
## solo nos queda ponerlas en su "sitio" y aplicar los cambios en la Base de dqtos.

echo "sustituyendo archivos"
#borramos la carpeta de destino
rm "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY" -R

## creamos los direcctorios de destino. 
mkdir "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"
mkdir "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"/.original
mkdir "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"/thumb

## creamos los index, por seguridad.
touch "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"/index.html
touch "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"/.original/index.html
touch "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"/thumb/index.html

## movemos los archivos de los temporales al destino
mv "$PACH_IMAGENES"/tmp/big/*.* "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"
mv "$PACH_IMAGENES"/tmp/small/*.* "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"/thumb
## Establecemos su dueño
chown -R "$USSER_WWW_DATA":"$GROUP_WWW_DATA" "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"
## Establecemos permisos
chmod -R "$PERMISSS" "$PACH_WWW"/media/com_gallery_wd/uploads/"$NOMBRE_DIR_GALLLERY"

echo "eliminando temporales"
## Eliminamos los archivos temporales
rm -R "$PACH_IMAGENES"/tmp 





## y ahora creamos un archivo php para insertar los cambios en la base de datos,
## con los siguientes datos:

echo "iniciando gestion con la Base de datos"
## Construimos el archivo ./variables_php.sh
echo "$PHPSTART" > ./variables_php.sh
cat "$PACH_WWW"/configuration.php >> ./variables_php.sh
echo " " >> ./variables_php.sh
echo '$gallery_id = ''"'$GALL_ID'";' >> ./variables_php.sh
echo '$pach_www = ''"'$PACH_WWW'";' >> ./variables_php.sh
echo '$nombre_dir_gallery = ''"'$NOMBRE_DIR_GALLLERY'";' >> ./variables_php.sh
echo " " >> ./variables_php.sh
echo " " >> ./variables_php.sh
echo "?>" >> ./variables_php.sh
chmod 755 ./variables_php.sh



## Contruimos el ejecutable de php
echo "$PHPSTART" > ./php.sh
cat ./php.php >> ./php.sh
chmod 755 ./php.sh


## ejecutamos el codigo php
./php.sh

## y por ultimo eliminamos lo que acabamos de ejecutar.
rm ./php.sh
rm ./variables_php.sh

echo "this software is make for Héctor Hernández. license: GNU"
echo "you can contact will me in admin@atlantisgc.com"
echo "bye ;)"



