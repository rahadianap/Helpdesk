<?php
require_once LIBPATH."FileCopyHelper.php";
require_once LIBPATH."AppStep.php";
require_once LIBPATH."helper.php";
require_once CONFIGPATH."config.php";
class AppInstaller {
    private static $thisobj=null;
    private static $steps=[];
    private static $theme="default";
    private static $current_step=0;
    private static $app_name="Web Installer";
    private static $slugon='';
    private static $version='1.0';
    private static $logo='';
    private static $css_list=[];
    private static $js_list=[];
    /**
     * @var AppSession
     */
    public $session;
    
    /**
     * @var AppStep;
     */
    private static $currentStepObj=null;
    private static $errorMessage=array();
    private static $errorFields=array();
    private static $infoMessage=array();
    private static $hiddenFilelds=array();
    private static $installerPath="";
    function __construct(){       
    	spl_autoload_register(array($this,"_myautoload_method"));
    	$this->session=AppSession::get_instance();
	}
	
	function _myautoload_method($class){
			if(file_exists(LIBPATH.$class.".php")){
				require_once LIBPATH.$class.".php";
				return;
			}elseif(file_exists(LIBPATH.strtolower($class).".php")){
			    require_once LIBPATH.strtolower($class).".php";				
				return;
			}elseif(file_exists(STEPPATH.$class.".php")){
				require_once STEPPATH.$class.".php";
				return;
			}elseif(file_exists(STEPPATH.strtolower($class).".php")){
			    require_once STEPPATH.strtolower($class).".php";				
				return;
			}
			die($class." doesn't exists");
	}
	
	public static function AddError($msg,$isSession=false,$is_unique=false){
	     
	     
	    if($isSession){
	        $thisobj=get_instance();
	        $getSession=$thisobj->session->GetSession("errorMessage");
	        if(!$getSession){
	            $getSession=array();
	        }
	        if($is_unique){
	            if(in_array($msg, $getSession)){
	                return ;
	            }
	        }
	        $getSession[]=$msg;
	        $thisobj->session->SetSession("errorMessage",$getSession);
	        return;
	    }
	    if($is_unique){
	        if(in_array($msg, self::$errorMessage)){
	            return ;
	        }
	    }
	    self::$errorMessage[]=$msg;
	}
	public static function AddInfo($msg,$isSession=false,$is_unique=false){
	
	    if($isSession){
	        $thisobj=get_instance();
	        $getSession=$thisobj->session->GetSession("infoMessage");
	        if(!$getSession){
	            $getSession=array();
	        }
	        if($is_unique){
	            if(in_array($msg, $getSession)){
	                return ;
	            }
	        }
	        $getSession[]=$msg;
	        $thisobj->session->SetSession("infoMessage",$getSession);
	        return;
	    }
	    if($is_unique){
	        if(in_array($msg, self::$infoMessage)){
	            return ;
	        }
	    }
	    self::$infoMessage[]=$msg;
	}
	
	public static function GetError($prefix='',$postfix=''){
	    $ci=get_instance();
	    $getSession=$ci->session->GetSession("errorMessage",true);
	    if($getSession){
	        self::$errorMessage=array_merge($getSession,self::$errorMessage);
	    }
	    if(count(self::$errorMessage)>0){
	        return $prefix.implode($postfix.$prefix, self::$errorMessage).$postfix;
	    }
	    return '';
	}
	public static function SetInstallerPath($path){
	     self::$installerPath=$path;
	}
	public static function GetInstallerPath(){
	    return self::$installerPath;
	}
	public static function GetInfo($prefix='',$postfix=''){
	    $thisobj=get_instance();
	    $getSession=$thisobj->session->GetSession("infoMessage",true);
	    if($getSession){
	        self::$infoMessage=array_merge($getSession,self::$infoMessage);
	    }
	    if(count(self::$infoMessage)>0){
	        return $prefix.implode($postfix.$prefix, self::$infoMessage).$postfix;
	    }
	    return '';
	}
	public static function GetMsg($prefix1='',$prefix2='',$postfix=''){
	    $str=self::GetError($prefix2,$postfix);
	    $str.=self::GetInfo($prefix1,$postfix);
	    if(!empty($str)){
	        return '<div class="d-m-b">'.$str.'</div>';
	    }
	    return '';
	}
    
    static function &get_instance(){
        if(!self::$thisobj){
            self::$thisobj=new self();
        }
        return self::$thisobj;
    }
    static function AddStep($step_name){
        if(endsWith($step_name, ".php")){
            $step_name=substr($step_name, 0,-4);
        }    
        if(!in_array($step_name, self::$steps)){
            self::$steps[]=$step_name;
        }      
    }
    static function AddCss($name,$isWithVersion=false){
        if(startsWith($name, "http") || startsWith($name, "//")){
            if(!in_array($name, self::$css_list)){
                self::$css_list[]=$name;
            }            
        }
        $url=base_url($name,$isWithVersion);
        if(!in_array($url, self::$css_list)){
            self::$css_list[]=$url;
        }  
    }
    static function AddJs($name,$isWithVersion=false){
        if(startsWith($name, "http") || startsWith($name, "//")){
            if(!in_array($name, self::$js_list)){
                self::$js_list[]=$name;
            }
        }
        $url=base_url($name,$isWithVersion);
        if(!in_array($url, self::$js_list)){
            self::$js_list[]=$url;
        }       
    }

    static function SetTheme($themename){
        self::$theme=$themename;
    }
    static function GetTheme(){
        return self::$theme;
    }
    static function SetAppData($appname,$slugon='',$version='1.0',$logo=''){
        self::SetAppName($appname);
        self::$slugon=$slugon;
        self::$version=$version;
        self::$logo=$logo;        
        
    }
    static function SetAppName($appname){
        self::$app_name=$appname;
    }
    static function GetAppName(){
        return self::$app_name;
    }
    static function GetAppVersion(){
        return self::$version;
    }
    static function ShowAppName(){
        echo  self::GetAppName();
    }
    static function GetHeaderContent(){        
        ?>
        <title><?php echo self::ShowAppName(); ?></title>    
        <?php foreach (self::$css_list as $url){?>    
    	   <link href="<?php echo $url;?>" rel="stylesheet" type="text/css" />
         <?php }
    }
    static function GetFooterContent(){
       foreach (self::$js_list as $url){?>    
        	   <script type="text/javascript" src="<?php echo $url;?>"></script>	
 <?php }
    }
    
    static function GetAppTitle(){
        $logo=!empty(self::$logo)?self::$logo:base_url("images/logo.png");
       ?>
       <div class="row">
       <div class="col-md-8 col-xs-6">
         <div class="f-content">
        <div class="">
            <img src="<?php echo $logo;?>" alt="<?php echo self::$app_name;?>" class="img-responsive app-logo" />
        </div>
        <div class="p-t-10 p-b-10">
            <div class="app-title"><?php echo self::$app_name;?></div>
            <div class="app-subtitle"><?php echo self::$app_name;?></div>
        </div>        
       </div>
       </div>
       <div class="col-md-4 col-xs-6 text-right ">
        <div class="app-version p-10"> <?php _e("Version : %s", self::$version);?></div>
       </div>
      </div>
       <?php 
    }
    static function FormOpen(){
       ?>
       <form class="form bv-form" action="<?php echo base_url("index.php?step=".self::$current_step)?>" method="post">
       <?php 
    }
    static function FormButtons(){
        if(!self::$currentStepObj->is_finish()){ 
            $nextButton=isset(self::$steps[self::$current_step+1])?__('Next').' <i class="fa fa-angle-double-right "></i>':__("Finish");
            if(self::$current_step>0){?>
            <a href="<?php echo base_url("index.php?step=".(self::$current_step-1))?>" class="btn btn-default pull-left"><i class="fa fa-angle-double-left "></i> <?php _e("Back") ; ?></a>
            <?php }?>
            <button type="submit" class="btn btn-success pull-right"><?php echo $nextButton; ?></button>
             <?php 
        }else{
            ?>
            <div class="text-center">
                <em class="app-copy">App is installed by <a target="blank" href="http://product.appsbd.com/webinstaller" class="">Appsbd Web Installer</a></em>
            </div>
            <?php 
        }
    }
    static function FormClose(){
         ?>
         </form>
         <?php 
    }
    static function Run(){
        self::$current_step=GetValue("step",'0');
       
        self::AddCss("plugins/bootstrapValidation/js/bootstrapValidator.min.css");
        self::AddJs("plugins/bootstrapValidation/js/bootstrapValidator.min.js");
        
       
        self::AddCss("plugins/bootstrap-material/css/material-all-css.css" );        
        self::AddJs( "plugins/bootstrap-material/js/material.js" );
        self::AddJs( "plugins/bootstrap-material/js/ripples.min.js" );
        self::AddJs( "plugins/bootstrap-material/js/marerial-init.js" );
        
        self::AddCss("css/main-style.css");
        self::AddJs("js/main-script.js");
        
        $system=self::get_instance();
        if(!empty(self::$steps[self::$current_step])){
            if(version_compare(PHP_VERSION,"5.3","<")){
                $thisObj=self::get_instance();
                $thisObj->_myautoload_method(self::$steps[self::$current_step]);
            }
            self::$currentStepObj=new self::$steps[self::$current_step](); 
                   }
        
        return $system->start();
    } 
    static function Output(){
        ob_start();
        self::_Output();
        $html=ob_get_clean();
        echo '<div id="MainLoader"><div class="msgText">
			    <div class="app-loader">
                    <div class="bar1"></div><div class="bar2"></div><div class="bar3"></div><div class="bar4"></div><div class="bar5"></div><div class="bar6"></div>
                </div>
			     '.self::$currentStepObj->getLoadingText().'</div>
			   </div>';
        echo GetMsg();
        echo $html;
        
    }
    private static function _Output(){      
        if(count(self::$steps)==0){
            echo "<h1> No step defined</h2>";
            return;
        }else{
            if(self::$currentStepObj){
                self::$currentStepObj->form_html();
                return;
            }
        }
        echo 'Error On this step';
    }
    
    private function _display(){
        if(self::$currentStepObj){
            if(IsPostBack){
                if(self::$currentStepObj->valid_data($_POST)){
                    if(isset(self::$steps[self::$current_step+1])){
                        Redirect(base_url("index.php?step=".(self::$current_step+1)));
                        return;
                    }
                }
            }
        }
        loadTheme();
    }    
    function start(){
        $this->_display();
    }
   
}