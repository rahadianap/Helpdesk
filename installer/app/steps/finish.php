<?php

class finish extends AppStep
{
    private $isRetry = false;
    private $hasSQLStrictMode = false;

    function __construct()
    {
        parent::__construct();
        $this->SetFinishStep();
        @set_time_limit(0);
    }

    public function form_html()
    {

        if ($this->process_setup()) {
            ?>

            <div class="text-center">
                <h1 class="m-t-5"><i class="fa fa-smile-o"></i> Thank You.</h1>
                <p>The setup is successfully finished</p>
                <strong>To login admin panel click the link bellow</strong><br/>
                <a href="<?php echo installed_base_url("admin"); ?>" class=""><?php echo installed_base_url(); ?><span
                            class="h-light">admin</span></a>
                <br/><br/><strong>To view site click the link bellow</strong> <br/>
                <a href="<?php echo installed_base_url(); ?>" class=""><?php echo installed_base_url(); ?></a>
            </div>
            <?php
        } else {
            ?>
            <div class="text-center">
                <h3 class="m-t-5"><i class="fa fa-times-circle-o"></i> Setup Process Failed.</h3>
                <p>The setup is failed, Try again</p>
                <?php
                if ($this->isRetry) {
                    ?>
                    <a href="" class="btn btn-success "><i class="fa fa-gear"></i> Retry Setup</a>
                    <?php
                } ?>
            </div>
            <?php
        }
    }

    public function is_sql_strict_enabled(&$mysqli)
    {
        $sqlmode = $mysqli->query("SELECT @@GLOBAL.sql_mode as gmode");
        $keys = ['NO_ZERO_IN_DATE', 'NO_ZERO_DATE'];
        if ($sqlmode) {
            $sqlmoderow = mysqli_fetch_object($sqlmode);
            if (!empty($sqlmoderow->gmode)) {
                foreach ($keys as $k) {
                    if (strpos($sqlmoderow->gmode, $k) !== FALSE) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public function process_setup()
    {
        $is_ok = true;
        $host = $this->getOtherStepData("step2", "dbserver");
        $database = $this->getOtherStepData("step2", "dbname");
        $user = $this->getOtherStepData("step2", "dbuser");
        $password = $this->getOtherStepData("step2", "dbpass");
        $db = new AppDB($host, $user, $password, $database);

        if (!$db->isConnected()) {
            RedirectStep(1);
        }
        $inspath = installed_path();

        if (ENVIRONMENT == "development") {
            $inspath .= "tmp/";
        }
        $dbFilePath=$inspath . "after_install/database.sql";
        if(!file_exists($dbFilePath)){
            if(file_exists(DATAPATH . "database.apss")){
                $dbFilePath=DATAPATH . "database.apss";
            }
        }

        if (!$db->processSQLFile($dbFilePath)) {
            $is_ok = false;
        }else{
            unlink($dbFilePath);
        }
        if ($is_ok) {
            $appname = $this->getOtherStepData("step3", "appname");
            $adminuser = $this->getOtherStepData("step3", "appusername");
            $adminuser = trim($adminuser);
            $adminfulluser = $this->getOtherStepData("step3", "appusertitle");
            $appuserpass = $this->getOtherStepData("step3", "appuserpass");
            $appuserpassmd5 = md5("AA" . $appuserpass);
            $adminemail = $this->getOtherStepData("step3", "adminemail");
            $licensekey = $this->getOtherStepData("step4", "licensekey");
            $addDate = date('Y-m-d H:i:s');
            $result = $db->query("SHOW TABLES");
            if ($result->num_rows < 35) {
                $is_ok = false;
                AddError("It can't create database table in mysql");
                $this->isRetry = true;
            };
            if ($is_ok) {
                                $this->hasSQLStrictMode = $this->is_sql_strict_enabled($db);
                if (!$db->query("Update app_user SET title='$adminfulluser',user='$adminuser', email='$adminemail',pass='$appuserpassmd5' , contact_number='', add_date='$addDate' WHERE id='AA' ")) {

                }
                if (!$db->query("DELETE FROM app_user WHERE id <>'AA'")) {

                }
                if (!$db->query("UPDATE `app_setting` SET `s_val`='$appname' WHERE (`s_key`='app_title')")) {

                }
                if (!$db->query("UPDATE `app_setting` SET `s_val`='$adminemail' WHERE (`s_key`='app_email')")) {

                }
                if (!$db->query("DELETE FROM `app_setting` WHERE (`s_key`='licstr')")) {

                }
                if (!empty($licensekey)) {
                    if (!$db->query("INSERT INTO `app_setting` (`s_key`, `s_title`, `s_val`, `s_type`, `s_option`, `s_auto_load`) VALUES ('licstr', '', '$licensekey', 'T', '', 'Y')")) {

                        if (!$db->query("UPDATE `app_setting` SET `s_val`='$licensekey' WHERE (`s_key`='licstr')")) {

                        }
                    }
                }
            }
        }
        if ($is_ok) {

            $main_data_path = DATAPATH . "data.apsd";
            if (file_exists($main_data_path)) {

                     $datazip=new ZipArchive();
                      if ($datazip->open($main_data_path) === TRUE)
                      {
                          if(!is_dir($inspath)){
                              mkdir($inspath,0755,true);
                          }
                          if(!$datazip->extractTo($inspath)){
                              $is_ok=false;
                              AddError("Can not extract source file, Contact with provider");
                          }
                          $datazip->close();
                      }else{
                          $is_ok=false;
                          AddError("Can not open source file, Contact with provider");
                      }
            }
            if ($is_ok) {
                                if (!FileCopyHelper::move_files($inspath . "/after_install", $inspath, $cpError)) {
                    AddError($cpError);
                    return false;
                }

                                $htaccessupdate = file_get_contents($inspath . ".htaccess");
                $relativepath = installed_relative_path();
                $htaccessupdate = str_replace("###PATH##", $relativepath, $htaccessupdate);
                file_put_contents($inspath . ".htaccess", $htaccessupdate);
                                                if (file_exists($inspath . ".conf")) {
                    $conf_ngnix = file_get_contents($inspath . ".conf");
                    $relativepath = installed_relative_path();
                    $conf_ngnix = str_replace("###PATH##", $relativepath, $conf_ngnix);
                    file_put_contents($inspath . ".conf", $conf_ngnix);
                }
                                if (file_exists($inspath . "web.config")) {
                    $iis_conf = file_get_contents($inspath . "web.config");
                    $relativepath = installed_relative_path();
                    if ($relativepath == "/") {
                        $iis_conf = str_replace("###PATH##", "", $iis_conf);
                    } else {
                        $iis_conf = str_replace("###PATH##", $relativepath, $iis_conf);
                    }
                    file_put_contents($inspath . "web.config", $iis_conf);
                }


                                $dbfilename = $inspath . "/application/config/database.php";
                $databaseconfig = file_get_contents($dbfilename);
                $databaseconfig = str_replace(["###DBHOST###", "###DBUSER###", "###DBPASS###", "###DBNAME###"], [$host, $user, $password, $database], $databaseconfig);
                file_put_contents($dbfilename, $databaseconfig);

                                $appConfigFilename = $inspath . "/application/config/appconfig.php";
                $appConfig = file_get_contents($appConfigFilename);
                $appConfig = str_replace(["###BASEURL###", "###SESSPREFIX###"], [installed_base_url(), hash("crc32b", $appname)], $appConfig);
                if ($this->hasSQLStrictMode) {
                    if (strpos($appConfig, "is_sql_mode") === false) {
                        $appConfig .= '$config[\'is_sql_mode\']=true;';
                    } else {
                        $appConfig = str_replace("###SQLMODE###", 'true', $appConfig);
                    }
                }
                file_put_contents($appConfigFilename, $appConfig);


            }
        }
        if (ENVIRONMENT == "production") {
            $redirectstr = "<?php
        
               header('Location: ..'); die;";
            app_delete_folder(BASEPATH . "app/");
            if (!is_dir(BASEPATH)) {
                mkdir(BASEPATH, 0755, true);
            }
            file_put_contents(BASEPATH . "index.php", $redirectstr);
            $this->session->DestroySession();
        }
        return $is_ok;
    }

    public function valid_data($post_param)
    {

        return true;
    }

}