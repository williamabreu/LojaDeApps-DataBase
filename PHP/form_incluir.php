<?php header("Content-Type: text/html; charset=iso-8859-1", true); ?>

<html>
	<head>
		<title>Editar Usuário</title> 
	</head>
	
	<body>
		<form name="form1" method="POST" action="incluir.php">
			<?php
			if (isset($_GET['codigo'])) {	
				include("./config.php");
				$connection = mysqli_connect($host, $login, $senha, $bd);
				?>
				
				<center><h2>Editar Usuário</h2></center>
				
				<?php
				$query = "SELECT * FROM dados_pessoais WHERE codigo=".$_GET['codigo'];				
				$result = mysqli_query($connection, $query);
				$vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
				mysqli_close($connection);
				?>
				
				<input type="hidden" name="codigo" value="<?php echo $_GET['codigo']; ?>">
				<?php
			}
			else {
				?>
				<center><h2>Novo Usuário</h2></center>
				<?php
			}
			?>
			
			<table border="0" align="center" width="35%">
				<tr><td width="20%">Nome:</td>
					<td colspan="2" width="90%">
					  <input type="text" name="nome" value="<?php echo @$vetor['nome']; ?>" maxlength="50" size="31">
					</td>
				</tr>
				<tr><td>Telefone:</td>
					<td><input type="text" name="ddd" value="<?php echo @$vetor['ddd']; ?>" maxlength="2" size="3">
						<input type="text" name="telefone" value="<?php echo @$vetor['telefone']; ?>" maxlength="8" size="9">
					</td>
				</tr>
				<tr><td colspan="3" align="center">
					  <input type="button" value="Cancelar" onclick="location.href='index.php'">
					  <input type="submit" value="Gravar">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
