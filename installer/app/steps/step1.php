<?php
class step1 extends AppStep{

    public function form_html()
    {
        ?>
        <h3 class="m-t-5">Welcome to Appsbd Support System Setup Wizard</h3>
        <p>The system is checking requirement</p>
        <div class="panel panel-default">

            <div class="panel-body p-0">


                <table class="table m-b-0">
                    <thead>
                    <tr>
                        <th width="30%">Name</th>
                        <th class="text-center" width="20%">Required</th>
                        <th class="text-center" width="20%">Your System</th>
                        <th class="text-center" width="30%">Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php $items=$this->get_version_details();
                    $isOk=true;
                    foreach ($items as $item){
                        if(!$item->status){
                            $isOk=false;
                        }
                        ?>
                        <tr>
                            <td><?php echo $item->name;?></td>
                            <td class="text-center"><?php echo $item->required_str;?></td>
                            <td class="text-center"><?php echo $item->system_str;?></td>
                            <td class="text-center"><?php echo $item->status_text;?></td>
                        </tr>
                    <?php }?>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="4" class="text-center <?php echo $isOk?"text-success":"text-danger";?>">
                            <?php echo $isOk?'<i class="fa fa-check-circle-o"></i> '."All requirment are passed":'<i class="fa fa-check-times-o"></i> '."All requirment are not passed";?>
                        </td>
                    </tr>
                    </tfoot>
                </table>

            </div>
        </div>
        <?php
    }


    public function valid_data($post_param)
    {

        $items=$this->get_version_details();
        $isOk=true;
        foreach ($items as $item){
            if(!$item->status){
                AddError($item->name." is not fulfilled the requirement");
                $isOk=false;
            }
        }

        return $isOk;

    }
    public function isFileWritable($path)
    {
        $writable_file = (file_exists($path) && is_writable($path));
        $writable_directory = (!file_exists($path) && is_writable(dirname($path)));

        if ($writable_file || $writable_directory) {
            return true;
        }
        return false;
    }
    public function get_version_details(){
        $missing= '<span class="text-red">Missing</span>';
        $requirements=[];
        $phpversion=phpversion();
        $php=new stdClass();
        $php->name="PHP Version";
        $php->required_str="&#8805; 5.3";
        if(!version_compare($phpversion, "8.2","<")){
            $php->required_str="Supports from 5.3 to ~8.1 , <br/> Your current verison is {$phpversion},<br/><span class='label label-warning'> Please use lower version of php</span>";
        }
        $php->system_str=$phpversion;
        $php->status=version_compare($phpversion, "5.3",">=") && version_compare($phpversion, "8.2","<");
        $php->status_text=$php->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $requirements[]=$php;

        $inspath=installed_path();
        $mysql=new stdClass();
        $mysql->name="PHP Write Permisssion";
        $mysql->required_str="Required";

        $mysql->status=$this->isFileWritable($inspath);
        $mysql->status_text=$mysql->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $mysql->system_str=$mysql->status?"Yes":"No";
        $requirements[]=$mysql;

        $mysql=new stdClass();
        $mysql->name="MySQLi Module";
        $mysql->required_str="&#8805; 0.1";
        $mysql->status=extension_loaded("mysqli");
        $mysql->status_text=$mysql->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $mysql->system_str=$mysql->status?phpversion("mysqli"):$missing;
        $requirements[]=$mysql;

        if(function_exists("curl_version")){
            $cversion=curl_version();
        }else{
            $cversion="";
        }

        $curl=new stdClass();
        $curl->name="Curl Module";
        $curl->required_str="Any";
        $curl->status=extension_loaded("curl");
        $curl->status_text=$curl->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $curl->system_str=$curl->status?$cversion['version']:$missing;
        $requirements[]=$curl;

        $openssl=new stdClass();
        $openssl->name="Openssl Module";
        $openssl->required_str="&#8805; 1.0";
        $openssl->status=extension_loaded("openssl");
        $openssl->status_text=$openssl->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $openssl->system_str=$openssl->status?OPENSSL_VERSION_TEXT:"-";
        $requirements[]=$openssl;

        $reqm=new stdClass();
        $reqm->name="Zip Module";
        $reqm->required_str="Any";
        $reqm->status=extension_loaded("zip");
        $reqm->status_text=$reqm->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $reqm->system_str=$reqm->status?phpversion("zip"):$missing;
        $requirements[]=$reqm;

        $gd=new stdClass();
        $gd->name="GD Module";
        $gd->required_str="Any";
        $gd->status=extension_loaded("gd");
        $gdVersion="-";
        if($gd->status){
            $gdinfo=gd_info ( );
            if(isset($gdinfo['GD Version'])){
                $gdVersion=$gdinfo['GD Version'];
            }
        }
        $gd->status_text=$gd->status?'<span class="label label-success">Passed</span>':'<span class="label label-danger">Failed</span>';
        $gd->system_str=$gd->status?$gdVersion:$missing;
        $requirements[]=$gd;

        if(!extension_loaded("mbstring")){
            $objs=new stdClass();
            $objs->name="MBString Module";
            $objs->required_str="Required";
            $objs->status=false;
            $objs->status_text='<span class="label label-danger">Failed</span>';
            $objs->system_str=$missing;
            $requirements[]=$objs;
        }
        if(!extension_loaded("iconv")){
            $objs=new stdClass();
            $objs->name="iconv Module";
            $objs->required_str="Required";
            $objs->status=false;
            $objs->status_text='<span class="label label-danger">Failed</span>';
            $objs->system_str=$missing;
            $requirements[]=$objs;
        }
        if(!extension_loaded("imap")){
            $objs=new stdClass();
            $objs->name="IMAP Module";
            $objs->required_str="Required";
            $objs->status=false;
            $objs->status_text='<span class="label label-danger">Failed</span>';
            $objs->system_str=$missing;
            $requirements[]=$objs;
        }


        return $requirements;
    }


}