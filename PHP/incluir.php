<?php
	include("./config.php");
	$connection = mysqli_connect($host, $login, $senha, $bd);
	
	if (isset($_POST["codigo"])) {
		$query = "SELECT codigo FROM dados_pessoais WHERE codigo=".$_POST["codigo"];
		$result = mysqli_query($connection, $query);
		
		if (mysqli_num_rows($result) != 0) {
		  $query = "UPDATE dados_pessoais SET nome='".$_POST["nome"]."',ddd=".$_POST["ddd"].",telefone=".$_POST["telefone"]." WHERE codigo=".$_POST["codigo"];
		}
	}
	else {
		$query = "INSERT INTO dados_pessoais VALUES (null,'".$_POST["nome"]."',".$_POST["ddd"].",".$_POST["telefone"].")";
	}
	
	mysqli_query($connection, $query);
	mysqli_close($connection);
	header("location: ./index.php");
?>
