<?php
class step2 extends AppStep{
    private $hasSqlStrictMode=false;
    private $newCommand="";
	function __construct(){
	    parent::__construct();
	}
	public function is_sql_strict_enabled(&$mysqli){
        $sqlmode=$mysqli->query("SELECT @@GLOBAL.sql_mode as gmode");
        $keys=['NO_ZERO_IN_DATE','NO_ZERO_DATE'];
        if($sqlmode){
            $sqlmoderow=mysqli_fetch_object($sqlmode);
            if(!empty($sqlmoderow->gmode)){
                foreach ($keys as $k){
                    if(strpos($sqlmoderow->gmode,$k)!==FALSE){
                        return true;
                    }
                }
            }
        }
        return false;
    }
    public function getSQLStrictCommand(&$mysqli){
        $sqlmode=$mysqli->query("SELECT @@GLOBAL.sql_mode as gmode");
        $keys=['ONLY_FULL_GROUP_BY','NO_ZERO_IN_DATE','NO_ZERO_DATE'];
        $returnStr='';
        if($sqlmode){
            $sqlmoderow=mysqli_fetch_object($sqlmode);
            if(!empty($sqlmoderow->gmode)){
                $returnStr=$sqlmoderow->gmode;
                foreach ($keys as $k){
                    $returnStr=str_replace($k.",","",$returnStr);
                }
            }
        }
        return $returnStr;
    }
	public function valid_data($post_param)
	{
	    $isOk=true;
	    $dbserver=GetParamValue($post_param,"dbserver");
	    if(empty($dbserver)){
	        AddError("Server is requried");
	        $isOk=false;
	    }
	    $dbname=GetParamValue($post_param,"dbname");
	    if(empty($dbname)){
	        AddError("DB Name is requried");
	        $isOk=false;
	    }
	    $dbuser=GetParamValue($post_param,"dbuser");
	    if(empty($dbuser)){
	        AddError("Server is requried");
	        $isOk=false;
	    }
	    $dbpass=GetParamValue($post_param,"dbpass");
	   
	    if($isOk){
	        ob_start();
	        $mysqli = new AppDB($dbserver, $dbuser, $dbpass, $dbname);
            if(!$mysqli->isConnected()){
                $isOk=false;
            }else{
                if($this->is_sql_strict_enabled($mysqli)){
                    $this->newCommand=$this->getSQLStrictCommand($mysqli);
                    if(ENVIRONMENT=="production"){
                        $mysqli->query("SET GLOBAL sql_mode = '$this->newCommand'");
                    }
                    if($this->is_sql_strict_enabled($mysqli)) {
                        $this->hasSqlStrictMode = true;

                    }
                }
            }
	    }
	    if($isOk){
	        $this->saveData($post_param);
            if($this->hasSqlStrictMode){
                $isForceSQL= GetParamValue($post_param,"sql_mode_force");
                if($isForceSQL!="Y"){
                    AddError("SQL Strict mode detected");

                    $isOk = false;
                }
            }
	    }
	    return $isOk;
	
	}
    public function form_html()
    {
        $dbform = new FormBuilder(true);
        $dbform->addInputText("dbserver", "Database Host", $this->getValue("dbserver"), "ex. localhost");
        $dbform->addInputText("dbname", "Database Name", $this->getValue("dbname"));
        $dbform->addInputText("dbuser", "Database User", $this->getValue("dbuser"));
        $dbform->addInputPassword("dbpass", "Database Password", $this->getValue("dbpass"), "", false);
        ?>
        <div class="">
            <h3 class="m-t-5"><i class="fa fa-database"></i> Database Informaton</h3>
            <p>Please fill the form</p>
        </div>

        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <?php if ($this->hasSqlStrictMode) { ?>
                            <div class="panel panel-warning">
                                <div class="panel-heading"><i class="fa fa-exclamation-triangle text-red"></i> Error Description</div>
                                <div class="panel-body">
                                    Would you please run this command in your MySQL server?
                                    <div class="panel panel-default brs-5 m-b-0" style="background: #fcfcfc;">
                                        <div class="panel-body p-5" >
                                            SET GLOBAL sql_mode = '<?php echo $this->newCommand; ?>';
                                        </div>
                                    </div>
                                    If you run this command then simply press the next button.<br/>
                                    <br>
                                    <label for="sql_mode_force">Or If you can't run that command then check the box bellow</span>:

                                    <div class="checkbox">
                                        <label>
                                            <input name="sql_mode_force" value="Y" type="checkbox"> Proced this installation anyway
                                        </label>
                                    </div>
                                    </label>
                                </div>
                            </div>

                        <?php } ?>
                    </div>
                    <div class="col-md-offset-3 col-md-6">
                        <?php echo $dbform->getHtml(); ?>
                    </div>

                </div>
            </div>
        </div>
        <?php

    }
    
}