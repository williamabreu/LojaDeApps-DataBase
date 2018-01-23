<?php 
	header("Content-Type: text/html; charset=UTF-8", true); 
	include("./functions.php");
?>

<html>
	<head>
		<title>Loja de Apps</title>
	</head>
	
	<body>
		<form name="form1" method="POST" action="incluir.php">
			<?php
			if (isset($_GET['login'])) {
				include("./config.php");
				$connection = mysqli_connect($mysql_host, $mysql_login, $mysql_password, $mysql_database);
				?>
				
				<center><h2>Editar Usu&aacute;rio</h2></center>
				
				<?php
				$login = $_GET['login'];
				$query = "SELECT * FROM Usuario WHERE login = '$login'";
				$result = mysqli_query($connection, $query);
				$array = mysqli_fetch_array($result, MYSQLI_ASSOC);
				$data = date_format_br($array['dataNasce']);
				$credito = number_format($array['credito'], "2");
				mysqli_close($connection);
				?>
				
				<input type="hidden" name="login" value="<?php echo $login; ?>">
				<?php
			}
			else {
				?>
				<center><h2>Novo Usu&aacute;rio</h2></center>
				<?php
			}
			?>
			
			<table border="0" align="center">
				<tr>
					<td>Nome:</td>
					<td colspan="2">
					  <input type="text" name="nome" value="<?php echo @$array['nome']; ?>" maxlength="30" size="50">
					</td>
				</tr>
				<tr>
					<td>E-mail:</td>
					<td>
						<input type="text" name="email" value="<?php echo @$array['email']; ?>" maxlength="50" size="50">
					</td>
				</tr>
				
				<?php
				if (! isset($_GET['login'])) {
					?>
					<tr>
						<td>Login:</td>
						<td colspan="2">
							<input type="text" name="login" value="" maxlength="50" size="50">
						</td>
					</tr>
					<tr>
						<td>Senha:</td>
						<td>
							<input type="password" name="senha" value="" maxlength="32" size="50">
						</td>
					</tr>
					<?php
				}
				?>
				
				<tr>
					<td>Tipo:</td>
					<td>
						<input type="text" name="tipo" value="<?php echo @$array['tipo']; ?>" maxlength="10" size="50">
					</td>
				</tr>
				<tr>
					<td>Cr&eacute;dito:</td>
					<td>
						<input type="text" name="credito" value="<?php echo @$credito; ?>" maxlength="10" size="50">
					</td>
				</tr>
				<tr>
					<td>Nascimento:</td>
					<td>
						<input type="text" name="data" value="<?php echo @$data; ?>" maxlength="10" size="50">
					</td>
				</tr>
				<tr>
					<td height="10"></td>
				</tr>
				
				<?php
				if (isset($_GET['login'])) {
					?>
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td colspan="3" align="center"><b>Confirme a senha para validar mudan&ccedil;as</b></td>
					</tr>
					<tr>
						<td height="10"></td>
					</tr>
					<tr>
						<td>Senha:</td>
						<td>
							<input type="password" name="senha" value="" maxlength="32" size="50">
						</td>
					</tr>
					<?php
				}
				?>
				
				<tr>
					<td height="10"></td>
				</tr>
				<tr>
					<td colspan="3" align="center">
					  <input type="button" value="Cancelar" onclick="location.href='index.php'">
					  <input type="submit" value="Salvar">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
