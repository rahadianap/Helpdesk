<?php
class AppDB{
   public $mysqlobj=null;
   private $is_connected="NOT";
   private $host;
   private $user;
   private $password;
   private $database;
   function __construct($host, $user, $password, $database){
       $this->host=$host;
       $this->user=$user;
       $this->password=$password;
       $this->database=$database;
       ob_start();
       $this->mysqlobj=new mysqli($host, $user, $password, $database);
       if($this->isConnected()){
        $this->mysqlobj->set_charset("utf8");
       }
       ob_get_clean();
   } 
   function __destruct(){
        if($this->is_connected){            
            $this->mysqlobj->close();
        }
   }
   function query($query){
       return $this->mysqlobj->query($query);
   }
   function multi_query($query){
       try {
           $this->mysqlobj->query("SET SESSION sql_mode = ''");
           if ($this->mysqlobj->multi_query($query)) {
               do {
                   if ($result = $this->mysqlobj->store_result()) {
                       $result->free();
                   }
               } while ($this->mysqlobj->next_result());
               return true;
           }
           return false;
       } catch (Exception $e) {
           AddError($e->getMessage());
           return false;
       }
   }
   function processSQLFile($file){
       if(file_exists($file)){
           $commands = file_get_contents($file);
           if(!$this->multi_query($commands)){
               AddError("Database Creation Failed");
               AddError($this->mysqlobj->error);
              
           }else{
               return true;
           }
       }else{
           AddError("Error, file not exist in : ".$file);
       }
      return false;
       
   }
   function file_get_contents_utf8($fn) {
       $content = file_get_contents($fn);
       return mb_convert_encoding($content, 'UTF-8',
           mb_detect_encoding($content, 'UTF-8, ISO-8859-1', true));
   }
   function isConnected($isSetErrorMessage=true){
       if($this->is_connected=="NOT"){ 
           ob_start();
           $is_ok=true;
            if($this->mysqlobj->connect_errno){
                $is_ok=false;
                if($isSetErrorMessage){
                    if($this->mysqlobj->connect_errno==2002){
                        AddError("Connect failed:No such host is known",true);
                    }else{
                        AddError("Connect failed:".$this->mysqlobj->connect_error,true);
                    }
                }
            }
    
            
            
            if ($is_ok && !$this->mysqlobj->ping()) {
                if($isSetErrorMessage){ AddError(sprintf ("Error: ".$mysqli->error),true); }
            }
            ob_get_clean();
            $this->is_connected=$is_ok;
       }
       return $this->is_connected;
   }   
   
    
}