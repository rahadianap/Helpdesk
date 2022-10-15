<?php
abstract class AppStep{
    private $title="App Tep";
    /**
     * @var AppSession
     */
    public $session;
    private $is_finish_step=false;
    private $save_id=null;
    protected $__data=[];
    private static $step_data=[];
    function __construct(){
        $this->session=AppSession::get_instance();    
        $this->setSaveID(get_class($this)) ;  
    }
    final function setSaveID($id){
        $this->save_id=$id;
        $this->loadData();
    }
    final function saveData($data){
        if($this->save_id!==null){
            $this->__data=$data;
            $this->session->SetSession("step_".$this->save_id, $this->__data);
        }
    }
    final function loadData(){
        if($this->save_id!==null){          
            $this->__data=$this->session->GetSession("step_".$this->save_id);
        }
    }
    final function getOtherStepData($stepNameOrSaveID,$index=""){
        if(!isset(self::$step_data[$stepNameOrSaveID])){
           self::$step_data[$stepNameOrSaveID]= $this->session->GetSession("step_".$stepNameOrSaveID);
        }
        if(!empty($index)){
            if(isset(self::$step_data[$stepNameOrSaveID][$index])){
                return self::$step_data[$stepNameOrSaveID][$index];
            }
            return "";
        }
        return self::$step_data[$stepNameOrSaveID];
    }
    function getLoadingText(){
        return 'Please Wait';
    }
    function getValue($index=null){
        if($index){
            if(isset($this->__data[$index])){
                return $this->__data[$index];
            }
            return '';
        }else{
           return $this->__data; 
        }
       
    } 
    function SetFinishStep($status=true){
        $this->is_finish_step=$status;
    }
    function is_finish(){
        return $this->is_finish_step;
    }    
    abstract function form_html();
    abstract function valid_data($post_param);
    
}