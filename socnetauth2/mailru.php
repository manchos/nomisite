<?php
require_once('../config.php');
require_once('lib/db.php');
require_once('lib/socnetauth2.php');


session_start();

$SocAuth = new SocAuth();

if( !$SocAuth->get_config_param('socnetauth2_mailru_status') )
{
	header("Location: ".$_SERVER['HTTP_REFERER']);
	exit();
}

$IS_DEBUG = 0;

if( !empty($_GET['first']) )
{
	$STATE = 'mailru_socnetauth2_'.rand();
	
	$CURRENT_URI = $_SERVER['HTTP_REFERER'];
	$REDIRECT_URI = 'http://'.$_SERVER['HTTP_HOST'].'/socnetauth2/mailru.php';
	
	$CLIENT_ID = $SocAuth->get_config_param('socnetauth2_mailru_id');
	
	
	
			
	$SocAuth->setRecord($STATE, $CURRENT_URI);
	setcookie("mr_state", $STATE);
	
	
	$url = 	'https://connect.mail.ru/oauth/authorize?client_id='.$CLIENT_ID.
			'&response_type=code&scope=&redirect_uri='.urlencode($REDIRECT_URI);

	
	header("Location: ".$url);
	
	exit();
}


if( !empty( $_GET['code'] ) && !empty( $_COOKIE['mr_state'] ) &&
	$recordData = $SocAuth->getRecord( $_COOKIE['mr_state'] ) )
{
	$CODE = $_GET['code'];
	
	$CURRENT_URI = $recordData['redirect'];
	$REDIRECT_URI = 'http://'.$_SERVER['HTTP_HOST'].'/socnetauth2/mailru.php';
	
	
	$CLIENT_ID = $SocAuth->get_config_param('socnetauth2_mailru_id');
	$CLIENT_SECRET = $SocAuth->get_config_param('socnetauth2_mailru_secret');
	$CLIENT_PRIVATE = $SocAuth->get_config_param('socnetauth2_mailru_private');
	
	
	
	$url = 'https://connect.mail.ru/oauth/token';
	$fields = array(
						'client_id' => urlencode($CLIENT_ID),
						'client_secret' => urlencode($CLIENT_SECRET),
						'grant_type' => 'authorization_code',
						'code' => urlencode($_GET['code']),
						'redirect_uri' => urlencode($REDIRECT_URI)
				);
	//url-ify the data for the POST
	$fields_string = '';
	foreach($fields as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
	rtrim($fields_string, '&');
	

	//open connection
	$ch = curl_init();

	//set the url, number of POST vars, POST data
	curl_setopt($ch,CURLOPT_URL, $url);
	curl_setopt($ch,CURLOPT_POST, count($fields));
	curl_setopt($ch,CURLOPT_POSTFIELDS, $fields_string);

	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	//execute post
	$result = curl_exec($ch);

	//close connection
	curl_close($ch);
	
	
	$data = json_decode($result, 1);
	 
	
	if( !empty($data['access_token']) )
	{	
		$request_params = array(
			'app_id' => $CLIENT_ID,
			'method' => 'users.getInfo',
			'secure' => 1,
			'session_key' => $data['access_token'],
			'uids' => $data['x_mailru_vid'],
		);
 
		$params = '';
		
		foreach ($request_params as $key => $value)
		$params .= "$key=$value";
 
		
		$graph_url = 'http://www.appsmail.ru/platform/api'.'?'.http_build_query($request_params).
			   '&sig='.md5($params.$CLIENT_SECRET);
 
		
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
		
		
		$arr = $userdata[0];
		
		$provider = 'mailru';
		
		$arr = array(
			'identity' => $arr['uid'],
			'firstname' => $arr['first_name'],
			'lastname'  => $arr['last_name'],
			'email'     => $arr['email'],
			'telephone'	=> ''
		);
		
		$data = array(
			'identity'  => $arr['identity'],
			'link' 		=> '',
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