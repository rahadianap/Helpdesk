<?php
if(!function_exists("_e")){
    function _e($string, $parameter = null, $_ = null)
    {
        $args=func_get_args();
        if(!empty($args[0])){
            echo call_user_func_array("__",$args);
        }else{
            echo $args[0];
        }
    }
}
if(!function_exists("_n")){
    function _n($number)
    {
       echo $number;
    }
}
if(!function_exists("__")){
    function __($string, $parameter = null, $_ = null)
    {
        $args=func_get_args();
        
         
        if(count($args)>1){
            $msg=call_user_func_array("sprintf",$args);
        }else{
            $msg=$args[0];
        }
        return $msg;
    }
}
function &get_instance(){
    return AppInstaller::get_instance();
}
function startsWith($haystack, $needle)
{
    $length = strlen($needle);
    return (substr($haystack, 0, $length) === $needle);
}

function endsWith($haystack, $needle)
{
    $length = strlen($needle);
    return $length === 0 ||(substr($haystack, -$length) === $needle);
}

function base_url($str='',$isVersionstr=false)
{    
     $base_url  =  ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == "on") || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') ?  "https" : "http")."://".$_SERVER['HTTP_HOST'].str_replace(basename($_SERVER['SCRIPT_NAME']),"",$_SERVER['SCRIPT_NAME']);
     if(empty($str)){
         return $base_url;
     }else{
         $str=ltrim($str,'/');
         $timestr="";
         if($isVersionstr){
             if(file_exists(BASEPATH.$str)){                 
                 if(strpos($str, "?")!==FALSE){
                     $timestr="&v=".fileatime(BASEPATH.$str);
                 }else{
                     $timestr="?v=".fileatime(BASEPATH.$str);
                 }
             }
         }
         return $base_url.$str;
     }
}
function installed_base_url($str='',$isVersionstr=false)
{
    $base_url=base_url();
    $installer_path=AppInstaller::GetInstallerPath();
    $installer_path=rtrim($installer_path,'/').'/';
    if(!empty($installer_path)){
        $base_url=str_replace("/".$installer_path, "/", $base_url);
    }    
    if(empty($str)){
        return $base_url;
    }else{
        $str=ltrim($str,'/');
        $timestr="";
        if($isVersionstr){
            if(file_exists(BASEPATH.$str)){
                if(strpos($str, "?")!==FALSE){
                    $timestr="&v=".fileatime(BASEPATH.$str);
                }else{
                    $timestr="?v=".fileatime(BASEPATH.$str);
                }
            }
        }
        return $base_url.$str;
    }
}
function installed_path()
{
    $base_path=str_replace('\\', '/', BASEPATH); 
    $installer_path=AppInstaller::GetInstallerPath();
    $installer_path=rtrim($installer_path,'/').'/';
    if(!empty($installer_path)){
        $base_path=str_replace("/".$installer_path, "/", $base_path);
    }
    return $base_path;    
}
function installed_relative_path(){
    $base_path=str_replace(basename($_SERVER['SCRIPT_NAME']),"",$_SERVER['SCRIPT_NAME']);
    $installer_path=AppInstaller::GetInstallerPath();
    $installer_path=rtrim($installer_path,'/').'/';
    if(!empty($installer_path)){
        $base_path=str_replace("/".$installer_path, "/", $base_path);
    }
    return $base_path;
}

function AddError($msg,$isSession=false,$is_unique=false){
    return AppInstaller::AddError($msg,$isSession,$is_unique);
}



function AddInfo($msg,$isSession=false,$is_unique=false){
    return AppInstaller::AddInfo($msg,$isSession,$is_unique);
}

function file_get_contents_utf8($fn) {
    $content = file_get_contents($fn);
    return mb_convert_encoding($content, 'UTF-8',
        mb_detect_encoding($content, 'UTF-8, ISO-8859-1', true));
}
function GetMsg($prefix1='<div class="msg alert alert-success alert-dismissible fade in" role="alert"><i class="fa fa-check-circle-o"> </i> ',$prefix2='<div class="msg alert alert-danger" role="alert" ><i class="fa fa-times-circle-o"> </i> ',$postfix='</div>'){
    return AppInstaller::GetMsg($prefix1,$prefix2,$postfix);
}
function app_delete_folder($dir,$isFastMode=true){
    if($isFastMode){
        if(function_exists("system")) {
            @system("rm -rf " . escapeshellarg($dir));
        }
        if(is_dir($dir)){
                        $isFastMode=false;
            return app_delete_folder($dir,$isFastMode);
        }else{
            return true;
        }
    }else{
        $files = array_diff(scandir($dir), array('.','..'));
        foreach ($files as $file) {
            (is_dir("$dir/$file") && !is_link($dir)) ? app_delete_folder("$dir/$file",$isFastMode) : unlink("$dir/$file");
        }
        return rmdir($dir);
    }
}

function template_url($str='',$isVersionstr=false)
{
  $str=ltrim($str,'/');
  $templatename=AppInstaller::GetTheme();
  return base_url("theme/$templatename/$str",$isVersionstr);
}
function plugin_url($str='',$isVersionstr=false)
{  
  return base_url("plugins/$str",$isVersionstr);
}
function PostValue($name, $default = "",$isXsClean=true) {    
    return isset($_POST[$name])?$_POST[$name]:$default;
}
function GetParamValue($param_array,$name, $default = "",$isXsClean=true) {
    return isset($param_array[$name])?$param_array[$name]:$default;
}
function SetParamValue(&$param_array,$name, $value = "") {
    $param_array[$name]=$value;   
}
function GetValue($name, $default = "",$isXsClean=true) {
    return isset($_GET[$name])?$_GET[$name]:$default;
}
function RequestValue($name, $default = "",$isXsClean=true,$isNoTrim=false) {
   return isset($_REQUEST[$name])?$_REQUEST[$name]:$default;
}
function Redirect($url = '',  $code = NULL)
{
    header('Location: '.$url, TRUE, $code);
    die;
}
function RedirectStep($step_number = '',  $code = NULL)
{
    Redirect("index.php?step=".$step_number);
}
if(!function_exists("GPrint")){
    function GPrint($obj,$isReturn=false){
        $data=print_r($obj,true);
        $data=htmlentities($data);
        if($isReturn){
            return "<pre>".$data."</pre>";
        }
        echo"<pre>".$data."</pre>";
    }
}
function loadTheme(){
    $templatename=AppInstaller::GetTheme();
    if(file_exists(BASEPATH."theme/$templatename/main.php")){
        include BASEPATH."theme/$templatename/main.php";
    }else{
        ?>
        <div class="panel panel-default">
          <div class="panel-heading"><?php _e("Template Load Error"); ?></div>
          <div class="panel-body">
              	<p class="text-danger">The file does not exist in the path : <?php echo BASEPATH."theme/$templatename/main.php";?></p>
          </div>
        </div>
        <?php 
    }
   
}