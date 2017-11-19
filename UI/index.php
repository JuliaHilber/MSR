<?php
	$location = $_POST["location"];
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
<br>
	<center>
	<fieldset>
		<legend><h3>Find your place of interest:</h3></legend>
	<form method="post" action="index.php">
		<select name="location">
		<?php //iterate over locations
			foreach($xml->topic as $topic) {
				?><option value="<?php echo $topic->number; ?>"><?php echo ucwords(str_replace("_", " ", $topic->title)); ?></option><?php
			}
		?>
		</select>
		<input type="submit" value="Search">
	</form>
	</fieldset>
	</center>
	<?php if($location != "") {
		$img = array();
		for($i = 0; $i < 50; $i++) {
			array_push($img, "");
		}
		$result = file("result.txt");
		$locationString = "";
		$filename = array();
		for($i=0; $i < count($result); $i++){
			$line = $result[$i];
			$parts = split("\t", $line);
			if($parts[0] == $location) {
				$k = $parts[3];
				foreach($xml->topic as $topic) {
					if($topic->number == $location) {
						$locationString = $topic->title;
						break;
					}
				}
				$id = "img/".$locationString."/".$parts[2].".jpg";
				$img[$k] = $id;
				$filename[$k] = $parts[2];
			}
		}
		echo "<br><center><h2>Location: </h2>".ucwords(str_replace("_", " ", $locationString))."</center><br>";
		?><table border='0' width='100%' cellspacing='0' cellpadding='0' style='padding-right: 20px;'><?php 
		$i = 0;
		foreach($img as $image) {
			if($i == 0) {
				$i++;
				continue;
			}
			if((($i-1)%3) == 0) {
				echo "<tr>";
			}
			echo "<td width='33.3%'>
					<form method='post' action='gallery.php'>
						<input type='hidden' name='location' value='".$locationString."'>
						<input type='hidden' name='image' value='".$image."'>
						<button id='nvbutton' type='submit'><img src='".$image."' alt='Image' width='100%'></button>
						<br><a style='padding-left: 20px;'>Rank: ".$i."</a>
						<br><a style='padding-left: 20px;'>File name: ".$filename[$i].".jpg</a>
					</form>
					</td>";
			if(($i%3) == 0) {
				echo "</tr>";
			}
			$i++;
		}
		echo "</table>";
	}?>
	
</body>
</html>