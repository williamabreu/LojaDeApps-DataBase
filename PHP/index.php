<?php header("Content-Type: text/html; charset=iso-8859-1", true); ?>

<html>
	<head>
		<title>Loja de Apps</title>
	</head>

	<body>
		<center>
			<h2>Tabela de Usuários</h2>
		</center>
		
		<form name="form1" method="POST" action="form_incluir.php">		
			<table border="1" align="center" width="80%">	
				<?php
				include("./config.php");				
				$connection = mysqli_connect($host, $login, $senha, $bd);
				$query = "
					SELECT nome, email, dataNasce, tipo, credito, login 
					FROM Usuario 
					ORDER BY nome
				";
				$tabela = mysqli_query($connection, $query);
				
				if (mysqli_num_rows($tabela) == 0) {
					?>
					<tr><td align="center">Tabela está vazia.</td></tr>
					<tr bgcolor="grey"><td height="5"></td></tr>
					<tr><td align="center"><input type="submit" value="Add Novo"></td></tr>
					<?php
				}
				else {
					?>
					<tr>
						<td width="25%"><b><center>Nome</center></b></td>
						<td width="20%"><b><center>E-mail</center></b></td>
						<td width="12%"><b><center>Nascimento</center></b></td>
						<td width="13%"><b><center>Tipo de conta</center></b></td>
						<td width="10%"><b><center>Crédito</center></b></td>
						<td width="20%"><b><center>Opções</center></b></td>
					</tr>
					<?php
					while ($dados = mysqli_fetch_row($tabela)) {
						$keyDados = $dados[5];
						?>
						<tr>
							<td><?php echo $dados[0]; ?></td>
							<td><?php echo $dados[1]; ?></td>
							<td><?php echo $dados[2]; ?></td>
							<td><?php echo $dados[3]; ?></td>
							<td><?php echo $dados[4]; ?></td>
							<td align="center">
								<input type="button" value="Editar" onclick="location.href='form_incluir.php?codigo=<?php echo $keyDados; ?>'">
								<input type="button" value="Excluir" onclick="location.href='excluir.php?codigo=<?php echo $keyDados; ?>'">
							</td>
						</tr>
						<?php
					}
					
					mysqli_close($connection);
					?>
					
					<tr bgcolor="grey"><td colspan="6" height="5"></td></tr>
					<tr><td colspan="6" align="center"><input type="submit" value="Add Novo"></td></tr>
					
					<?php
				}
				?>
			</table>
		</form>
	</body>
</html>
