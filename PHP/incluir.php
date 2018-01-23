<?php
	include("./functions.php");
	include("./config.php");
	$connection = mysqli_connect($mysql_host, $mysql_login, $mysql_password, $mysql_database);
	
	if (isset($_POST['login'])) {
		$login = $_POST['login'];
		$email = $_POST['email'];
		$senha = $_POST['senha'];
		$nome = $_POST['nome'];
		$tipo = $_POST['tipo'];
		$credito = $_POST['credito'];
		$data = date_format_bd($_POST['data']);
		
		$query = "SELECT login FROM Usuario WHERE login = $login";
		$result = mysqli_query($connection, $query);
		
		if (mysqli_num_rows($result) != 0) {
			$query = "
				UPDATE Usuario 
				SET email = '$email'
					nome = '$nome'
					tipo = '$tipo'
					credito = $credito
					dataNasce = '$data'
				WHERE login = '$login' and senha = MD5('$senha')
			";
		}
	}
	else {
		$query = "INSERT INTO Usuario VALUES('$login', '$email', MD5('$senha'), '$nome', '$tipo', $credito, '$data')";
	}
	
	mysqli_query($connection, $query);
	mysqli_close($connection);
	header("location: ./index.php");
?>
