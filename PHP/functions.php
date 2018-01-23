<?php
	// Converte data no formato AAAA-MM-DD para DD/MM/AAAA
	function date_format_br($date) {
		$array = split("-", $date);
		return "$array[2]/$array[1]/$array[0]";
	}
	
	// Converte data no formato DD/MM/AAAA para AAAA-MM-DD
	function date_format_bd($date) {
		$array = split("/", $date);
		return "$array[2]-$array[1]-$array[0]";
	}
?>
