<?php
require_once('../config.php');
require_once('lib/db.php');
require_once('lib/socnetauth2.php');
session_start();

$SocAuth = new SocAuth();

if( !$SocAuth->get_config_param('socnetauth2_vkontakte_status') )
{
	header("Location: ".$_SERVER['HTTP_REFERER']);
	exit();
}

$IS_DEBUG = 0;

if( !empty($_GET['first']) )
{
	$APP_ID = $SocAuth->get_config_param('socnetauth2_vkontakte_appid');
	$CURRENT_URI = $_SERVER['HTTP_REFERER'];
	
	$CURRENT_URI = str_replace("&socnetauth2close=1", "", $CURRENT_URI);
	$CURRENT_URI = str_replace("&amp;socnetauth2close=1", "", $CURRENT_URI);
	
	
	$REDIRECT_URI = 'http://'.$_SERVER['HTTP_HOST'].'/socnetauth2/vkontakte.php';
		
	$STATE = 'vkontakte_socnetauth2_'.rand();
	$SocAuth->setRecord($STATE, $CURRENT_URI);

	setcookie("vk_state", $STATE);
	
	$url = 'https://oauth.vk.com/authorize?client_id='.$APP_ID.
		'&scope=SETTINGS'.
		'&redirect_uri='.$REDIRECT_URI.
		'&display=page&'.
		'response_type=code';
	
	header("Location: ".$url);
}


if( !empty( $_GET['code'] ) && !empty( $_COOKIE['vk_state'] ) &&
	$recordData = $SocAuth->getRecord( $_COOKIE['vk_state'] ) )
{
	$CODE = $_GET['code'];
	
	$CURRENT_URI = $recordData['redirect'];
	$REDIRECT_URI = 'http://'.$_SERVER['HTTP_HOST'].'/socnetauth2/vkontakte.php';
	
	
	$CLIENT_ID = $SocAuth->get_config_param('socnetauth2_vkontakte_appid');
	$CLIENT_SECRET = $SocAuth->get_config_param('socnetauth2_vkontakte_appsecret');
	
	$url = "https://oauth.vk.com/access_token?client_id=".$CLIENT_ID.
		   "&client_secret=".$CLIENT_SECRET.
		   "&code=".$CODE.'&redirect_uri='.$REDIRECT_URI.'&';
		   
	if( $IS_DEBUG ) echo $url."<hr>";
	
	
	if( extension_loaded('curl') )
	{
		$c = curl_init($url);
			
		curl_setopt($c, CURLOPT_SSL_VERIFYPEER, FALSE);     
		curl_setopt($c, CURLOPT_SSL_VERIFYHOST, 2); 
			
		curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($c);
		curl_close($c);
	}
	else
	{
		$response = file_get_contents($url);
	}
			
	
	if( $IS_DEBUG ) echo $response."<hr>";
	
	$data = json_decode($response, true);
	
	if( !empty($data['access_token']) )
	{
		$graph_url = "https://api.vk.com/method/users.get?uids=".$data['user_id'].
		"&fields=uid,first_name,last_name,city,country&access_token=".$data['access_token'];
		
		if( $IS_DEBUG ) echo $graph_url."<hr>";
		
		if( extension_loaded('curl') )
		{
			$c = curl_init($graph_url);
			
			curl_setopt($c, CURLOPT_SSL_VERIFYPEER, FALSE);     
			curl_setopt($c, CURLOPT_SSL_VERIFYHOST, 2); 
			
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
		
		$arr = $userdata['response'][0];
		
		$provider = 'vkontakte';
		
		$arr = array(
			'identity' => $arr['uid'],
			'firstname' => $arr['first_name'],
			'lastname'  => $arr['last_name'],
			'email'     => '',
			'telephone'	=> ''
		);
		
		$data = array(
			'identity'  => $arr['identity'],
			'link' 		=> 'http://vk.com/id'.$arr['identity'],
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