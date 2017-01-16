<?php
require_once('../config.php');
require_once('lib/db.php');
require_once('lib/socnetauth2.php');
session_start();

$SocAuth = new SocAuth();

if( !$SocAuth->get_config_param('socnetauth2_odnoklassniki_status') )
{
	header("Location: ".$_SERVER['HTTP_REFERER']);
	exit();
}

$IS_DEBUG = 0;

if( !empty($_GET['first']) )
{
	$APPLICATION_ID = $SocAuth->get_config_param('socnetauth2_odnoklassniki_application_id');
	$REDIRECT_URI = 'http://'.$_SERVER['HTTP_HOST'].'/socnetauth2/odnoklassniki.php';
	$CURRENT_URI = $_SERVER['HTTP_REFERER'];
		
	$STATE = 'odnoklassniki_socnetauth2_'.rand();
	$SocAuth->setRecord($STATE, $CURRENT_URI);
		
	setcookie("od_state", $STATE);
		
	$url = 'http://www.odnoklassniki.ru/oauth/authorize?client_id='.
	$APPLICATION_ID.'&response_type=code&redirect_uri='.urlencode($REDIRECT_URI);
	
	header("Location: ".$url);
}


if( !empty( $_GET['code'] ) && !empty( $_COOKIE['od_state'] ) &&
	$recordData = $SocAuth->getRecord( $_COOKIE['od_state'] ) )
{
	$CODE = $_GET['code'];
	
	$CURRENT_URI = $recordData['redirect'];
	$REDIRECT_URI = 'http://'.$_SERVER['HTTP_HOST'].'/socnetauth2/odnoklassniki.php';
	$CLIENT_ID = $SocAuth->get_config_param('socnetauth2_odnoklassniki_application_id');
	$CLIENT_SECRET = $SocAuth->get_config_param('socnetauth2_odnoklassniki_secret_key');
	$CLIENT_PUBLIC = $SocAuth->get_config_param('socnetauth2_odnoklassniki_public_key');
	
	//code={code}&redirect_uri=http://mysite.com/oklogin&grant_type=authorization_code&client_id={client_id}&client_secret={secret_key}
	
	$POSTURL  = 'http://api.odnoklassniki.ru/oauth/token.do';
	$POSTVARS = 'code='.$CODE.'&redirect_uri='.$REDIRECT_URI.'&grant_type=authorization_code'.
	'&client_id='.$CLIENT_ID.'&client_secret='.$CLIENT_SECRET;
	
	$ch = curl_init($POSTURL);
	curl_setopt($ch, CURLOPT_POST      ,1);
	curl_setopt($ch, CURLOPT_POSTFIELDS    , $POSTVARS);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION  ,1);
	curl_setopt($ch, CURLOPT_HEADER      ,0);  // DO NOT RETURN HTTP HEADERS
	curl_setopt($ch, CURLOPT_RETURNTRANSFER  ,1);  // RETURN THE CONTENTS OF THE CALL
	$response = curl_exec($ch);
	curl_close($ch);
 
	if( $IS_DEBUG ) echo $response."<hr>";
	
	$data = json_decode($response, true);
	
	
	if( !empty($data['access_token']) )
	{
		$SIGN = md5('application_key='.$CLIENT_PUBLIC.'method=users.getCurrentUser'.md5($data['access_token'].$CLIENT_SECRET));
		
		$graph_url = "http://api.odnoklassniki.ru/fb.do?method=users.getCurrentUser".
		"&access_token=".$data['access_token'].
		"&application_key=".$CLIENT_PUBLIC.
		"&sig=".$SIGN;
		
		if( $IS_DEBUG ) echo $graph_url."<hr>";
		
		if( extension_loaded('curl') )
		{
			$c = curl_init($graph_url);
			curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
			$json = curl_exec($c);
			curl_close($c);
		}
		else
		{
			$json = file_get_contents($graph_url);
		}
		
		if( $IS_DEBUG ) echo $json;
		
		$userdata = json_decode($json, TRUE);
		/*
			uid - user ID
			birthday - date of birth
			age - user`s age
			first_name - user`s name
			last_name - user`s last name
			name - composition of first and last name to render
			has_email - true/false has or not e-mail
			gender - gender
			pic_1 - profile small icon (50x50)
			pic_2 - profile small picture (128x128)
		*/
		
		
		$arr = $userdata;
		
		$provider = 'odnoklassniki';
		
		$arr = array(
			'identity' => $arr['uid'],
			'firstname' => $arr['first_name'],
			'lastname'  => $arr['last_name'],
			'email'     => $arr['email'],
			'telephone'	=> ''
		);
		
		$data = array(
			'identity'  => $arr['identity'],
			'link' 		=> $arr['link'],
			'firstname' => '',
			'lastname'  => '',
			'email'     => '',
			'telephone'	=> '',
			'data'		=> serialize($arr),
			'provider'  => $provider
		);
		
		if( !empty( $arr['firstname'] ) )
		{
			$data['firstname'] = $arr['firstname'];
		}
		
		if( !empty( $arr['lastname'] ) )
		{
			$data['lastname'] = $arr['lastname'];
		}
		
		if( !empty( $arr['email'] ) )
		{
			$data['email'] = $arr['email'];
		}
		
		if( !empty( $arr['telephone'] ) )
		{
			$data['telephone'] = $ar['telephone'];
		}
		
		$data['company'] = '';
		$data['address_1'] = '';
		$data['postcode'] = '';
		$data['city'] = '';
		$data['zone'] = '';
		$data['country'] = '';
		
		///////////////////////////////////////
				
		
		$SocAuth->checkDB();
		
		if( $customer_id = $SocAuth->checkNew($data) )
		{
			if( $SocAuth->get_config_param('socnetauth2_dobortype') != 'every' )
			{
				$_SESSION['customer_id'] = $customer_id;
				$_SESSION['socnetauth2_confirmdata_show'] = 0;
				
				header("Location: ".$CURRENT_URI ); 
			}
			else
			{
				if( $confirm_data = $SocAuth->isNeedConfirm( $data ) )
				{
					$data['customer_id'] = $customer_id;
					$confirm_data['data'] = $data;
					$_SESSION['socnetauth2_confirmdata'] = serialize($confirm_data);
					$_SESSION['socnetauth2_confirmdata_show'] = 1;
					header("Location: ".$CURRENT_URI ); 
				}
				else
				{
					$_SESSION['customer_id'] = $customer_id;
					$_SESSION['socnetauth2_confirmdata_show'] = 0;
					header("Location: ".$CURRENT_URI ); 
				}
			}
		}
		else
		{
			$confirm_data = $SocAuth->isNeedConfirm( $data );
			
			if( !$SocAuth->get_config_param('socnetauth2_email_auth') || $SocAuth->get_config_param('socnetauth2_email_auth') == 'none' )
			{
				if( $confirm_data )
				{
					$confirm_data['data'] = $data;
					$_SESSION['socnetauth2_confirmdata'] = serialize($confirm_data);
					$_SESSION['socnetauth2_confirmdata_show'] = 1;
					header("Location: ".$CURRENT_URI ); 
				}
				else
				{
					$_SESSION['socnetauth2_confirmdata'] = '';
					$_SESSION['socnetauth2_confirmdata_show'] = '';
				
					$customer_id = $SocAuth->addCustomer( $data );
					$_SESSION['customer_id'] = $customer_id;	
				
					header("Location: ".$CURRENT_URI ); 
				}
			}
			elseif( $SocAuth->get_config_param('socnetauth2_email_auth') == 'confirm'  )
			{
				// требуется добор данных
				if( $confirm_data )
				{
					$confirm_data['data'] = $data;
					$_SESSION['socnetauth2_confirmdata'] = serialize($confirm_data);
					$_SESSION['socnetauth2_confirmdata_show'] = 1;
					header("Location: ".$CURRENT_URI ); 
				}
				// Получен E-mail и включено проверка email письмом
				elseif( !empty( $data['email'] ) && $SocAuth->checkByEmail($data, 0) )
				{
					include(DIR_SYSTEM.'library/mail.php');
					
					$SocAuth->sendConfirmEmail($data);
					$_SESSION['socnetauth2_confirmdata'] = serialize(array(1, 2, 3, 4, $data['email'], $data['identity'], $data['link'], $data['provider'], $data));
					$_SESSION['socnetauth2_confirmdata_show'] = 1;
					
					header("Location: ".$CURRENT_URI );
				}
				//Получен e-mail и он уникальный
				elseif( empty( $data['email'] ) ||
					 ( !empty( $data['email'] ) && !$SocAuth->checkByEmail($data, 0) ) )
				{
					$_SESSION['socnetauth2_confirmdata'] = '';
					$_SESSION['socnetauth2_confirmdata_show'] = '';
				
					$customer_id = $SocAuth->addCustomer( $data );
					$_SESSION['customer_id'] = $customer_id;	
				
					header("Location: ".$CURRENT_URI ); 
				}
			}
			elseif( $SocAuth->get_config_param('socnetauth2_email_auth') == 'noconfirm'  )
			{
				// требуется добор данных
				if( $confirm_data )
				{
					$confirm_data['data'] = $data;
					$_SESSION['socnetauth2_confirmdata'] = serialize($confirm_data);
					$_SESSION['socnetauth2_confirmdata_show'] = 1;
					header("Location: ".$CURRENT_URI ); 
				}
				// Получен E-mail 
				elseif( !empty( $data['email'] ) && $customer_id = $SocAuth->checkByEmail($data, 1) )
				{
					$_SESSION['socnetauth2_confirmdata'] = '';
					$_SESSION['socnetauth2_confirmdata_show'] = '';
					$_SESSION['customer_id'] = $customer_id;	
				
					header("Location: ".$CURRENT_URI );
				}
				//Получен e-mail и он уникальный 
				elseif( empty( $data['email'] ) ||
					 ( !empty( $data['email'] ) && !$SocAuth->checkByEmail($data, 0) ) )
				{
					$_SESSION['socnetauth2_confirmdata'] = '';
					$_SESSION['socnetauth2_confirmdata_show'] = '';
				
					$customer_id = $SocAuth->addCustomer( $data );
					$_SESSION['customer_id'] = $customer_id;	
				
					header("Location: ".$CURRENT_URI ); 
				}	
			}
		}
	}
	
}

?>