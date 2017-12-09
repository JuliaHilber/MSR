<?php
	$location = $_POST["location"];
	$image = $_POST["image"];
	$xml=simplexml_load_file("devset_topics.xml") or die("Error: Cannot create object");
?>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="style.css">
	<table border="0" width="100%" cellspacing="0" cellpadding="0" style="padding-right: 20px;">
		<tr class="header">
			<td width="33.3%"><a href="index.php"><img src="travel_searach.png"
					width="100" height="100" alt="Logo"> </a></td>
			<td width="33.3%" align="center"><h1>Travel Search</h1></td>
			<td width="33.3%"></td>
		</tr>
	</table>
	<title>Travel Search</title>
</head>
<body>
	<center>
		<h2>Location: </h2> <?php echo ucwords(str_replace("_", " ", $location)); ?><br><br>
		<?php foreach($xml->topic as $topic) {
			if($topic->title == $location) {
				$location = $topic->number;
				break;
			}
		} ?>
		<form method="post" action="index.php"><input type="hidden" name="location" value="<?php echo $location; ?>"><button type="submit">back</button></form>
		<br>
		<img src="<?php echo $image; ?>" alt="Image">
	</center>
</body>
</html>
