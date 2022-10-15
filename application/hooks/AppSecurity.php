<?php
class AppSecurity {
	static $_POSTData=[];
	function __construct() {
		self::$_POSTData=$_POST;
		
	}
	static function RawPostValue($item,$default=''){
		if(isset(self::$_POSTData[$item])){
			return self::$_POSTData[$item];
		}
		return $default;
	}
	function CleanRequestParam(){
	    $this->max_php_version_check();
		$this->CleanAllParam();
	}

    function max_php_version_check()
    {
        if(version_compare(PHP_VERSION,'8.2.0','>=')){
            show_error("We're sorry, but this app cannot be installed with PHP ".PHP_VERSION." or higher. Please install a lower PHP version (any from 5.6 to 8.1.x)");
        }
    }

	function CleanAllParam(){
		$preg="/\-\-|[;'\"]|eval[^a-z]|cast\s*\(|base64_decode|sleep[^a-z]|gzinflate|XOR|str_rot13|javascript|\\\+|<|>/i";
				foreach ($_GET as &$value){			
			if(!empty($value)){
				if(is_string($value)){
					$value=trim($value);
					$value=preg_replace($preg, "", $value);
				}elseif(is_array($value)){
					foreach ($value as &$v){
						$v=preg_replace($preg, "", $v);
					}
				}
			}			
		}
	 	$allowlist=array('app_des_html','msg','k_body','footer_text','welcome_msg','ticket_body','css','js','email_footer','site_copyw');
		foreach ($_POST as $key=>&$value){
			$this->filter_data($key, $value,$allowlist);
			
		}
		foreach ($_REQUEST as $key=>&$value){			
			$this->filter_data($key, $value,[]);			
		}
		foreach ($_COOKIE as $key=>&$value){
			$this->filter_data($key, $value,[]);
		}
	}
	
	private function filter_data($key,&$value,$allowlist=[]){
	    $preg="/\-\-|[;'\"]|eval[^a-z]|cast\s*\(|base64_decode|sleep[^a-z]|gzinflate|XOR|str_rot13|\\\+|<|>/i";
	    $preg2="/javascript:|javascript.*?:/i";

	    	    if(!in_array($key, $allowlist)){
    	    if(!empty($value)){
    	        if(is_string($value)){
    	            $value=strip_tags($value);
    	            $value=preg_replace($preg2, "JavaScript ", $value);
    	            $value=preg_replace($preg, "", $value);
    	        }elseif(is_array($value)){
    	            foreach ($value as $k=>&$v){
    	                $this->filter_data($k,$v,$allowlist);	                
    	            }
    	        }
    	    }
	    }else{
            $value=$this->CleanHTMLtoText($value);
        }
	    
	}
    private function CleanHTMLtoText($html) {
	    $html=preg_replace('/<\s*head.+?<\s*\/\s*head.*?>/si', ' ', $html );
	    $html=preg_replace('/<\s*style.+?<\s*\/\s*style.*?>/si', ' ', $html );
	    $html=preg_replace('/<\s*javascript.+?<\s*\/\s*javascript.*?>/si', ' ', $html );
	    $html=strip_tags($html, '<h1><h2><h3><h4><strong><b><span><ol><ul><u><font><li><table><tr><img><br><pre><div><td><th><tbody><thead><tfoot><hr><p><a><iframe><figure><figcaption><video>');
	    if(function_exists("libxml_use_internal_errors") && class_exists("DOMDocument") &&  (defined('LIBXML_HTML_NOIMPLIED') || defined('LIBXML_HTML_NODEFDTD'))) {
		    libxml_use_internal_errors( true ); 		    $doc = new DOMDocument();
		    if(function_exists("mb_convert_encoding")) {
			    $doc->loadHTML( mb_convert_encoding( $html, 'HTML-ENTITIES', 'UTF-8' ), LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD );
		    }else{
			    $doc->loadHTML( '<?xml encoding="utf-8" ?>'.$html,  LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD );
		    }
		    $html = @$doc->saveHTML();
	    }
	    $html=preg_replace('/p class=\"MsoNormal\"\>/si', ' ', $html );
	
	    return $html;
    }
}