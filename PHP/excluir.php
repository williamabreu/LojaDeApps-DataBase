<?php
	include("./config.php");
	$connection = mysqli_connect($host, $login, $senha, $bd);
	$query = "DELETE FROM dados_pessoais WHERE codigo=".$_GET["codigo"];
	mysqli_query($connection, $query);
	header("location: ./index.php");
?>
