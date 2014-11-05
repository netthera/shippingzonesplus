<?php
/***************************************************************************
 *   copyright				: (C) 2008 - 2014 WeBid
 *   site					: http://www.webidsupport.com/
 ***************************************************************************/

/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version. Although none of the code may be
 *   sold. If you have been sold this script, get a refund.
 ***************************************************************************/

include 'common.php';

if (!$user->is_logged_in())
{
	$_SESSION['REDIRECT_AFTER_LOGIN'] = 'zones.php';
	header('location: user_login.php');
	exit;
}

//Check if the seller has zones
$query = "SELECT * FROM " . $DBPrefix . "zones WHERE user_id = ". $user->user_data['id'];
$result = mysql_query($query);
$system->check_mysql($result, $query, __LINE__, __FILE__);
$zones = mysql_fetch_assoc($result);

$action = ($zones['user_id']=='')? 'new':'update';

//zone arrays 
$used=$zone1=$zone2=$zone4=array();

//zone data strings to save in db
$zone1_data = $zone2_data = $zone4_data = "";

if (isset($_POST['action']))
{
	$zone1 = $_POST['zone1'];
	$zone2 = $_POST['zone2'];
	$zone4 = $_POST['zone4'];
}
else
{
	//load from the db
	$zone1 = explode("@" , $zones['zone1']);
	$zone2 = explode("@" , $zones['zone2']);
	$zone4 = explode("@" , $zones['zone4']);
}


//$country = mysql_fetch_assoc($result);
$i=1;

if(!isset($_POST['zone1'])&& $action=='new')
{
	$zone1_data = $user->user_data['country'];
	$used[$i] = $user->user_data['country'];
	$i++;
	$template->assign_block_vars('zone1', array(
		'COUNTRY' => $user->user_data['country']
	));
}
else
{
	$first=true;
	foreach ($zone1 as $selectedCountries){
		$zone1_data .=($first)?"":"@";
		$first=false;
		$zone1_data .= "$selectedCountries";
		$used[$i] = "$selectedCountries" ;
		$i++;
		if (isset($selectedCountries))
			$template->assign_block_vars('zone1', array(
				'COUNTRY' => $selectedCountries
			));
	}
}
$first=true;
foreach ($zone2 as $selectedCountries)
{
	$zone2_data .=($first)?"":"@";
	$first=false;
	$zone2_data .= "$selectedCountries";
	$used[$i] = "$selectedCountries" ;
	$i++;
	if ($selectedCountries!='')
		$template->assign_block_vars('zone2', array(
			'COUNTRY' => $selectedCountries
		));
}	
$first=true;
foreach ($zone4 as $selectedCountries)
{
	$zone4_data .=($first)?"":"@";
	$first=false;
	$zone4_data .= "$selectedCountries";
	$used[$i] = "$selectedCountries" ;
	$i++;
	if ($selectedCountries!='')
		$template->assign_block_vars('zone4', array(
			'COUNTRY' => $selectedCountries
		));
}
// Get Countries 
$query = "SELECT * FROM " . $DBPrefix . "countries";
$result = mysql_query($query);
$system->check_mysql($result, $query, __LINE__, __FILE__);


$find = array("&#39;", "&#40;", "&#41;");
$replace = array("'", "(", ")");
while ($country = mysql_fetch_assoc($result))
{	
	if(!in_array(str_replace($find, $replace, $country['country']),$used))
		$template->assign_block_vars('zone3', array(
			'COUNTRY' => $country['country']
		));
}

//write to the zones db
if (isset($_POST['action']))
{
	if ($action == 'new')
	{
		//add zones
		$query = "INSERT INTO " . $DBPrefix . "zones (user_id, zone1, zone2, zone4 ) VALUES
			(" . $user->user_data['id'] . ", \"" . $zone1_data . "\", \"" . $zone2_data . "\", \"" . $zone4_data . "\")";
		$system->check_mysql(mysql_query($query), $query, __LINE__, __FILE__);
	}
	else if($action == 'update') //just for clarity
	{
		//update zones
		$query = "UPDATE " . $DBPrefix . "zones SET  zone1= \"" . $zone1_data . "\", zone2= \"" . $zone2_data ."\", zone4= \"" . $zone4_data . "\" 
			WHERE user_id = " . $user->user_data['id'];
		$system->check_mysql(mysql_query($query), $query, __LINE__, __FILE__);
	}
}

include 'header.php';
$TMP_usmenutitle = $MSG['ZONES_100'];
include $include_path . 'user_cp.php';

$template->set_filenames(array(
		'body' => 'zones.tpl'
		));
$template->display('body');

include 'footer.php';
?>
