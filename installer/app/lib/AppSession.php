<?php
/**
 * Version 1.0.0
 * Creation date: 21/Nov/2017
 * @Written By: S.M. Sarwar Hasan (Appsbd) 
 */
defined('BASEPATH') OR exit('No direct script access allowed');
class AppSession {
    private static $selfObj=NULL;
	var $prefix="_winstaller";	
	private function __construct() {	  
	    session_set_cookie_params(0,'/','',false,true);
		session_start ();		
	}	
	static function get_instance(){
	    if(!self::$selfObj){
	        self::$selfObj=new self();
	    }
	    return self::$selfObj;
	}
	function CleanForSession(&$obj){
		
	}
	function SetSession($name, $obj) {
		$this->CleanForSession($obj);
		if (isset ( $_SESSION [$this->prefix.$name] )) {
			unset ( $_SESSION [$this->prefix.$name] );
		}
		$_SESSION [$this->prefix.$name] = serialize ( $obj );
	
	}
	
	function DestroySession(){
		session_destroy();
	}
	function GetSession($name, $isUnset = false,$default=null) {		
		$rData = null;
		if (isset ( $_SESSION [$this->prefix.$name] )) {
			$rData = unserialize ( $_SESSION [$this->prefix.$name] );
			if ($isUnset) {
				unset ( $_SESSION [$this->prefix.$name] );
			}
			return $rData;
		} else {
			return $default;
		}
	}	
}
?>
