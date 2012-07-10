#!/usr/bin/php
<?php
$maxchars = 21;

exec("node nozbe_nextactions.js",$output);
foreach( $output as $a ) {
	if(strlen($a) > @maxchars) {
		$a = substr($a,0,$maxchars-1);
		$a .= "...";
	}
	echo '${color0}* ${color2}'.$a."\n";
}
?>
