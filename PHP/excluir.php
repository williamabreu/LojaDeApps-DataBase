<?php
	/*
		GCC214 - Banco de Dados - 2017/2
		Loja De Apps
		
		@author Rafael Takehara
		@author Tarik Esmin
		@author	William Abreu
	*/

	include("./config.php");
	$connection = mysqli_connect($mysql_host, $mysql_login, $mysql_password, $mysql_database);
	$query = "DELETE FROM Usuario WHERE login = '".$_GET['login']."'";
	mysqli_query($connection, $query);
	header("location: ./index.php");
?>
