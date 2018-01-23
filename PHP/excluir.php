<?php
	include("./config.php");
	$connection = mysqli_connect($mysql_host, $mysql_login, $mysql_password, $mysql_database);
	$query = "DELETE FROM Usuario WHERE login = '".$_GET['login']."'";
	mysqli_query($connection, $query);
	header("location: ./index.php");
?>
