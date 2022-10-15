<?php
class step3 extends AppStep{
	function __construct(){
	    parent::__construct();
	}	
	public function valid_data($post_param)
	{
	   
	    $isOk=true;	
	    if(empty($post_param['appname'])){
	        AddError("Admin Full Name is requried");
	        $isOk=false;
	    }	    
	    if(empty($post_param["appusertitle"])){
	        AddError("Admin Full Name is requried");
	        $isOk=false;
	    }	   
	    if(empty($post_param["appusername"])){
	        AddError("Admin Username is requried");
	        $isOk=false;
	    }	   
	    if(empty($post_param["appuserpass"])){
	        AddError("Admin password is requried");
	        $isOk=false;
	    }	   
	    if(empty($post_param["adminemail"])){
	        AddError("Admin User Email is requried");
	        $isOk=false;
	    }elseif(filter_var ( $post_param["appusername"], FILTER_VALIDATE_EMAIL )){
	        AddError("Admin User Email is not valid email address");
	        $isOk=false;
	    }
	    if($isOk){
	        $this->saveData($post_param);
	    }	    
	    return $isOk;
	
	}
    public function form_html()
    {
        $siteform=new FormBuilder(true);
        $siteform->addInputText("appname","Applicaiton Name",$this->getValue("appname"),"ex. Appsbd Support System, You can change is later as well");
        
        $appbasicform=new FormBuilder(true);
        $appbasicform->addInputText("appusertitle","Full Name",$this->getValue("appusertitle"));
        $appbasicform->addInputText("appusername","Username",$this->getValue("appusername"));
        $appbasicform->addInputText("appuserpass","Password",$this->getValue("appuserpass"));
        $appbasicform->addInputEmail("adminemail", "Email",$this->getValue("adminemail"));
       
       ?>     
        <div class="panel panel-default m-b-10"> 
         <div class="panel-heading">Application Informaton</div>        
          <div class="panel-body">
               <div class="row">
                    <div class="col-md-offset-3 col-md-6">
                    <?php echo $siteform->getHtml();?>
                      
                    </div>
                </div>
              </div>
          </div>
          
         <div class="panel panel-default"> 
         <div class="panel-heading">Admin User Informaton</div>        
          <div class="panel-body">
               <div class="row">
                    <div class="col-md-offset-3 col-md-6">
                    <?php echo $appbasicform->getHtml();?>
                    </div>
                    
                </div>
              </div>
          </div>
       <?php 
       
    }
    
}