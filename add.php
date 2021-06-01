<?php 

	include 'database.php';

	$goalname = $_POST['goalname'];
	$descriptiondetails = $_POST['descriptiondetails'];
	$date = $_POST['date'];
	$tasks = $_POST['tasks'];

	$link->query("INSERT INTO person(goalname,descriptiondetails,dates,tasks)VALUES('".$goalname."','".$descriptiondetails."','".$date."','".$tasks."')");













































	// include 'database.php';

	// $fistname = $_POST['fistname'];
	// $descriptiondetails = $_POST['descriptiondetails'];
	// $date = $_POST['date'];
	// $address = $_POST['address'];

	// $link->query("INSERT INTO person(fistname,descriptiondetails,date,address)VALUES('".$fistname."','".$descriptiondetails."','".$date."','".$address."')");

