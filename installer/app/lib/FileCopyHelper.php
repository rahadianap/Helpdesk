<?php
class FileCopyHelper {

    public static function move_files( $from_dir, $_to_dir ,&$error='')
    {

        $from_dir=rtrim($from_dir,'/ \\');
        if(!is_dir($_to_dir)){
            mkdir($_to_dir,0777,true);
        }
        $_to_dir=realpath($_to_dir);
        $isAllOk=true;
        foreach (glob($from_dir.'/{,.}*', GLOB_BRACE) as $file){
            if(in_array(basename($file),['.','..'])){
                continue;
            }
            if(is_file($file)){
                $tofile=$_to_dir."/".basename($file);
                if(file_exists($tofile)){
                    unlink($tofile);
                }
                if(!copy($file,$tofile)){
                    $error.= "Can not copy ".$file."\n";
                    $isAllOk=false;
                }
            }elseif(is_dir($file)){
                self::move_files($file,$_to_dir."/".basename($file),$error);
            }

        }
        if($isAllOk){
            self::app_delete_folder($from_dir);
        }
        return true;

    }

    static function app_delete_folder($dir,$isFastMode=false){
        if(!file_exists($dir) && !is_dir($dir)){
            return;
        }
        if($isFastMode){

            @system("rm -rf ".escapeshellarg($dir));
            if(is_dir($dir)){
                                $isFastMode=false;
                return self::app_delete_folder($dir,$isFastMode);
            }else{
                return true;
            }
        }else{
            $files = array_diff(scandir($dir), array('.','..'));
            foreach ($files as $file) {
                (is_dir("$dir/$file") && !is_link($dir)) ? self::app_delete_folder("$dir/$file",$isFastMode) : unlink("$dir/$file");
            }

            if(@rmdir($dir)){
                return true;
            }elsE{
                self::app_delete_folder($dir);
            }
        }
    }

}
