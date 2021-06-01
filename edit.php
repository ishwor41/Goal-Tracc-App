<?php 

	include 'database.php';

	$id = $_POST['id'];
	$goalname = $_POST['goalname'];
	$descriptiondetails = $_POST['descriptiondetails'];
	$date = $_POST['date'];
	$tasks = $_POST['tasks'];

	$link->query("UPDATE person SET goalname = '".$goalname."',descriptiondetails = '".$descriptiondetails."',date = '".$date."',tasks = '".$tasks."' WHERE id = '".$id."'");


?>