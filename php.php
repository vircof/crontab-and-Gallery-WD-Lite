<?php



// este include es creado por las variables que se han introducido en "variables.sh" 
// (ahora en formato php) y la informacion de joomla de usuario y contraseña a la bd
include "./variables_php.sh";

  
// nos olvidamos de las clases publicas y pasamos los datos a variables simples.
// La aplicacion no requiere un gran numero de variables y prefiero simplificar.
$joomlaa = new JConfig();			
									// definimos:
$db = $joomlaa->db;					// Nombre de la base de datos
$dbhost = $joomlaa->host;			// host de la BD
$dbusuario = $joomlaa->user;		// Usuario de la BD
$dbpassword = $joomlaa->password;	// password de la BD
$prefix = $joomlaa->dbprefix;		// Prefijo de la base de datos.




// definimos la conexion a la base de datos
$conexion = new mysqli($dbhost, $dbusuario, $dbpassword, $db);




if ($conexion->connect_errno) 	// probamos la conexion
	{
	printf("Falló la conexión: %s\n", $conexion->connect_error);
	exit();
	}
	else						// si todo va bien.... 
	{
								// definimos la sentencia SQL para eliminar las imagenes de 
								// la galeria
	$sql = "DELETE FROM `{$prefix}bwg_image` WHERE `gallery_id` = {$gallery_id}";

		
		
								// si la sentencia no se puede realizar...
		if (!$conexion->query("{$sql}")) 
		{
		echo "Falló en la eliminacion de la galeria en la base de datos: (" . $conexion->errno . ") " . $conexion->error;
		echo '
';
		}
		else					// y si la sentencia se realiza bien....
		{
		echo "Galeria con id: {$gallery_id} eliminada correctamente.";	
				echo '
'; 
		};

};

// Ahora mismo la galeria no tiene imagenes en la BD
// leemos los archivos del directorio thumb, donde ya estan las imagenes.

// contador de imagenes: Definirá el orden de las imagenes.
$contador_imagenes = "0";


// abrimos el directorio y ejecutamos un while sobre lo que contenga "para ver lo que hay"
$directorio = opendir("{$pach_www}/media/com_gallery_wd/uploads/{$nombre_dir_gallery}/thumb"); //ruta actual
while ($archivo = readdir($directorio))
{
	if (is_dir($archivo))				//verificamos si es o no un directorio.
    {
										// si es un directorio, no devolvemos nada...
	echo "";
    }
    else 								// si no es un directorio:
    {
		if ($archivo == 'index.html') 	// verificamos si es index.html ...
		{
		echo '';						// si es index.html, no pasa nada.
		} 
		else 							// si es otra cosa, ¡¡¡ES UNA IMAGEN!!!
		{
		// sumamos "1" al contador:
		$contador_imagenes = ($contador_imagenes + 1);
		
		//pruebas:
		//echo "archivo ={$contador_imagenes} {$archivo} ////";
		
		
		// esto lo e explicado antes.... paso....
		
		if ($conexion->connect_errno) 
			{
				printf("Falló la conexión: %s\n", $conexion->connect_error);
				exit();
			}
			else
			{
				$sql= "INSERT INTO `{$prefix}bwg_image` (`id`, `gallery_id`, `slug`, `filename`, `image_url`, `thumb_url`, `description`, `alt`, `date`, `size`, `filetype`, `resolution`, `author`, `order`, `published`, `comment_count`, `avg_rating`, `rate_count`, `hit_count`, `redirect_url`) 
				VALUES (NULL, '{$gallery_id}', '{$archivo}', '{$archivo}', '/{$nombre_dir_gallery}/{$archivo}', '/{$nombre_dir_gallery}/thumb/{$archivo}', '{$archivo}', '{$archivo}', '', '', '', '', '699', '{$contador_imagenes}', '1', '0', '0', '0', '0', '')";


		
		
		
			if (!$conexion->query("{$sql}")) 
				{
				echo "Falló la insercion de la imagen en la BD: (" . $conexion->errno . ") " . $conexion->error;
				echo '
				';
				}
			else
				{
				echo "Imagen: _-{$archivo}-_ insertada corectamente en la BD";	
				echo '
'; 
				};
		
		
		
			};// fin if de errores de conexion
	
		}; // fin if  "si no es index"
		
	}; // fin if "si no es un directorio"
	
} // fin de bucle de lectura de archivos



mysqli_close($conexion); // Cerramos la conexion con la base de datos

// pruebas:
echo '

';
//echo " base de datos: {$db}";
//echo " Host BD: {$dbhost}";
//echo " Usuario BD: {$dbusuario}";
//echo " Pass BD: {$dbpassword}";
//echo " Prefijo BD: {$prefix}";

//echo " ID de la galeria: {$gallery_id}";
//echo "SQL: {$sql}";
//echo '


//';

?>
