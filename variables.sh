#!/bin/bash


## pach de las imagenes DEL ORIGEN: EJEMPLO TFP SAMBA SFTP
PACH_IMAGENES="./Imagenes"

## ancho de las imagenes grandes
ANCHO_IMG_BIG="800"

## ancho de las imagenes mini
ANCHO_IMG_SMALL="300"

## ID de la galeria (se puede ver en el indice de galerias, desde joomla)
GALL_ID="1"


## usuario Y GRUPO al que pertenecerán los archivos "colgados en la pagina"
USSER_WWW_DATA="www-data"
GROUP_WWW_DATA="www-data"
## Permisos de los archivos "colgados en la pagina"
PERMISSS="755"

## pach de joomla
PACH_WWW="/var/www/html"

## cabecera SH para PHP
PHPSTART="#!/usr/bin/php5"

## Nombre de la carpeta destino de la galeria: (puede ser inventado, pero debe ser "algo". 
## Tiene que ser diferente si se ejecucan varios scripts como este en un mismo joomla) 
## ejemplos: (galeria_1) (galeria_2) (obras) (instalaciones) (cuadros) (albunes)
NOMBRE_DIR_GALLLERY="patata"
