<?php
class FormBuilder{	
	const INPUT_TOGGLE_TRUE="Y";
	const INPUT_TOGGLE_FALSE="N";
    /**
     * @var  multitype:FormElement 
     */
    private $elements=[];
    private $hiddens=[];
    private $is_horizontal=false;
    private $label_col=4;
    private $input_col=8;
    function __construct($is_horizontal=false,$label_col=4,$input_col=8){
        $this->setHorizontal($is_horizontal,$label_col,$input_col);
    }
    /**
     * @param string $status
     * @param string $label_col
     * @param string $input_col
     */
    function setHorizontal($status=true,$label_col=4,$input_col=8){
       $this->is_horizontal=$status;
       $this->label_col=$label_col;
       $this->input_col=$input_col;
    }
	/**
	 * @param string $title
	 * @param string $name
	 * @param string $default_value
	 * @param string $is_required
	 * @param string $validator
	 * @return APP_API_Input_config
	 */
	function addInputHidden($name,$default_value=""){
		$obj=new FormElement();
		$obj->type="H";
		$obj->name=$name;		
		$obj->default_value=$default_value;		
		$this->hiddens[$name]= $obj;
	}
	/**
	 * @param string $title
	 * @param string $name
	 * @param string $default_value
	 * @param string $is_required
	 * @param string $validator
	 * @return APP_API_Input_config
	 */
	function addInputText($name, $title,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$maxlength=100,$attr=[]){
		$obj=new FormElement();
		$obj->type="T";
		$obj->name=$name;
		$obj->title=$title;
		$obj->is_required=$is_required;
		$obj->attr=$attr;
		$obj->default_value=$default_value;
		$obj->note=$note;
		$obj->class=$class;
		$obj->maxlength=$maxlength;
		$obj->form_group_class=$form_group_class;
		$this->elements[$name]= $obj;		
	}
	/**
	 * @param string $title
	 * @param string $name
	 * @param string $default_value
	 * @param string $is_required
	 * @param string $validator
	 * @return APP_API_Input_config
	 */
	function addInputEmail($name, $title,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$maxlength=100,$attr=[]){
	    $obj=new FormElement();
	    $obj->type="E";
	    $obj->name=$name;
	    $obj->title=$title;
	    $obj->is_required=$is_required;
	    $obj->attr=$attr;
	    $obj->default_value=$default_value;
	    $obj->note=$note;
	    $obj->class=$class;
	    $obj->maxlength=$maxlength;
	    $obj->form_group_class=$form_group_class;
	    $this->elements[$name]= $obj;
	}
	/**
	 * @param string $title
	 * @param string $name
	 * @param string $default_value
	 * @param string $is_required
	 * @param string $validator
	 * @return APP_API_Input_config
	 */
	function addInputPassword($name, $title,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$maxlength=100,$attr=[]){
	    $obj=new FormElement();
	    $obj->type="P";
	    $obj->name=$name;
	    $obj->title=$title;
	    $obj->is_required=$is_required;
	    $obj->attr=$attr;
	    $obj->default_value=$default_value;
	    $obj->note=$note;
	    $obj->class=$class;
	    $obj->maxlength=$maxlength;
	    $obj->form_group_class=$form_group_class;
	    $this->elements[$name]= $obj;
	}
	/**
	 * @param string $title
	 * @param string $name
	 * @param string $default_value
	 * @param string $is_required
	 * @param string $validator
	 * @return APP_API_Input_config
	 */
	function addInputTextarea($name, $title,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$maxlength=100,$attr=[]){
	    $obj=new FormElement();
	    $obj->type="A";
	    $obj->name=$name;
	    $obj->title=$title;
	    $obj->is_required=$is_required;
	    $obj->attr=$attr;
	    $obj->default_value=$default_value;
	    $obj->note=$note;
	    $obj->class=$class;
	    $obj->maxlength=$maxlength;
	    $obj->form_group_class=$form_group_class;
	    $this->elements[$name]= $obj;
	}
	
	/**
	 * @param string $title
	 * @param string $name
	 * @param string $default_value
	 * @param string $is_required
	 * @param string $validator
	 * @return APP_API_Input_config
	 */
	function addInputNumber($name, $title,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$attr=[]){
		$obj=new FormElement();
		$obj->title=$title;
		$obj->type="N";
		$obj->name=$name;
		$obj->attr=$attr;
		$obj->default_value=$default_value;
		$obj->note=$note;
		$obj->class=$class;
		$obj->form_group_class=$form_group_class;
		$this->elements[$name]= $obj;		
	}
	
	/**
	 * @param unknown $title
	 * @param unknown $name
	 * @param string $default_value must be  Y or N;
	 * @return APP_API_Input_config
	 */
	function addInputToggle($name, $title,$note='',$default_value="Y",$class="",$form_group_class="",$attr=[]){
		$obj=new FormElement();
		$obj->title=$title;
		$obj->type="O";
		$obj->name=$name;		
		$obj->note=$note;
		$obj->attr=$attr;
		$obj->default_value=$default_value;
		$obj->class=$class;
		$obj->form_group_class=$form_group_class;
		$this->elements[$name]= $obj;
	}
	/**
	 * @param string $title
	 * @param string $name
	 * @param array $option
	 * @param string $default_value
	 * @param string $is_required
	 * @return APP_API_Input_config
	 */
	function addInputDropdown($name, $title,array $option,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$attr=[]){
		$obj=new FormElement();
		$obj->title=$title;
		$obj->type="D";
		$obj->name=$name;
		$obj->option=$option;
		$obj->note=$note;
		$obj->attr=$attr;
		$obj->default_value=$default_value;
		$obj->class=$class;
		$obj->form_group_class=$form_group_class;
		$this->elements[$name]= $obj;
		
	}
	/**
	 * @param string $title
	 * @param string $name
	 * @param array $option
	 * @param string $default_value
	 * @param string $is_required
	 */
	function addInputRadio($name, $title,array $option,$default_value="",$note='',$is_required=true,$class="",$form_group_class="",$attr=[]){
		$obj=new FormElement();
		$obj->title=$title;
		$obj->type="R";
		$obj->name=$name;
		$obj->option=$option;
		$obj->note=$note;
		$obj->attr=$attr;
		$obj->default_value=$default_value;
		$obj->class=$class;
		$obj->form_group_class=$form_group_class;
		$index=str_replace(array("[","]"), "_", $name);
	    $this->elements[$index]= $obj;;
	}
	function setMaxlength($source_input_name,$maxlength){
	    $source_input_name=str_replace(array("[","]"), "_", $source_input_name);
	    if(isset($this->elements[$source_input_name])){
	        $this->elements[$source_input_name]->maxlength=$maxlength;
	    }
	    
	}
	function setAttr($source_input_name,$attr=[]){
	    $source_input_name=str_replace(array("[","]"), "_", $source_input_name);
	    if(isset($this->elements[$source_input_name])){
	        $this->elements[$source_input_name]->attr=array_merge($this->elements[$source_input_name]->attr,$attr);
	    }
	     
	}
	function setDependable($source_input_name,$on_value,$destination_input_names){
	    $source_input_name=str_replace(array("[","]"), "_", $source_input_name);
	    if(isset($this->elements[$source_input_name])){
	        $this->elements[$source_input_name]->class.=" has_depend_fld";	        
	    }
	    $elems=explode(",", $destination_input_names);
	    $source_input_name_class=str_replace("_", "-", $source_input_name);
	    foreach ($elems as $elm){
	        $elmste=str_replace(array("[","]"), "_", $elm);
	        if(isset($this->elements[$elmste])){
	            $targetClass="fld-".strtolower($source_input_name_class);
	            $targetClass=str_replace("_", "-",$targetClass);
	            $targetClassValue=$targetClass."-".strtolower($on_value);	            
	            $this->elements[$elmste]->form_group_class.=" grp-hidden {$targetClass} {$targetClassValue}";
	        }
	    }
	}
	
	function getHtml(){
	    if($this->is_horizontal){?><div class="form-horizontal"> <?php }
	    foreach ($this->hiddens as $elem){
	        $elem->getHtml();
	    }
	    
	    foreach ($this->elements as $elem){
	        $elem->getHtml($this->is_horizontal,$this->label_col,$this->input_col);
	    }
	    if($this->is_horizontal){?></div> <?php }
	}
}
class FormElement{
    public $type;
    public $title;
    public $name;
    public $default_value="";
    public $option=array();
    public $is_required=false;
    public $note="";
    public $attr="";
    public $class="";
    public $form_group_class="";
    public $maxlength=100;
    function GetPostValue(){       
        return isset($_POST[$this->name])?$_POST[$this->name]:$this->default_value;
    }
    function GetHTMLRadioByArray($name, $title, $id, $isRequired, $options, $checkedValue, $isDisabled=false, $isHorizontal = true,$class="",$attr=array()){
        foreach ($options as $key=>$value){
            $attrStr=" ";
            if(is_array($attr) && count($attr)>0){
                foreach ($attr as $key=>$value){
                    $attrStr.=$key.'="'.$value.'" ';
                }
            }
            ?>
                    <div class="radio">
                        <label>
                            <input class="<?php echo $class;?>" <?php echo $attrStr;?> id="<?php echo $id;?>" type="radio" <?php echo $checkedValue==$key?'checked="checked"':"";?> <?php if(!$isDisabled){?>name="<?php echo $name;?>" <?php }else{?> disabled="disabled" <?php }?> value="<?php echo $key;?>" <?php if(!$isDisabled && $isRequired){?>data-bv-notempty="true" data-bv-notempty-message="Choose <?php echo $title;?>" <?php }?> /> <?php echo $value;?>
                        </label>
                    </div>
                    <?php 
         }
    }
    
        function GetHTMLOptionByArray($options,$selected=""){
            if(is_array($options)){
                foreach ($options as $key=>$value){
                    $this->GetHTMLOption($key,$value,$selected);
                }
            }
    
        }
   
        function GetHTMLOption($value,$text,$selected="",$attr=array()){
            $attrStr="";
            if(is_array($attr) && count($attr)>0){
                foreach ($attr as $key=>$value){
                    $attrStr.=$key.'="'.$value.'"';
                }
            }
            ?>
    <option <?php echo $attrStr;?> <?php echo $selected==$value?"selected='selected'":"";?>
    	value="<?php echo $value;?>"><?php echo $text;?></option>
    <?php 
    		
    	}
    
    function getHtml($is_horizontal,$label_col=4,$input_col=8){
        $extraattr="";
        foreach ($this->attr as $eattr=>$evalue){
            $extraattr=" {$eattr}=\"{$evalue}\" ";
        }
        if($this->type=="H"){
            ?>
            <input type="hidden" name="<?php echo $this->name;?>" <?php echo $extraattr;?> value="<?php echo $this->default_value;?>" />
            <?php 
        }else{
        ?>
         <div class="form-group <?php echo $this->form_group_class;?> ">
		      	<label class="control-label <?php echo $this->is_required?"label-required":""?> <?php echo $is_horizontal?"col-md-".$label_col:"";?>" for="<?php echo $this->name;?>"><?php echo $this->title; ?></label>
		      	<?php if($is_horizontal){?><div class="col-md-<?php echo $input_col;?>">   <?php }
		      	if($this->type=="T" || $this->type=="N" ||  $this->type=="P"|| $this->type=="E"){
		      				      		$typetext=["P"=>"password","N"=>"number","E"=>"email"];
		      		$intype=isset($typetext[$this->type])?$typetext[$this->type]:"text";
		      	?>                			     	
		      		
		      		<input type="<?php echo $intype;?>" maxlength="<?php echo $this->maxlength;?>"   
		      		value="<?php echo  $this->GetPostValue();?>" class="form-control <?php echo $this->class;?>" id="<?php echo $this->name;?>" name="<?php echo $this->name;?>"   
		      		placeholder="<?php echo ($this->title); ?>" 
		      		<?php if($this->type=="E"){?>
		      		data-bv-trigger="blur" data-bv-emailaddress-message="The value is not a valid email address"
		      		<?php }?>
		      		<?php if($this->is_required){?>
		      		data-bv-notempty="true" data-bv-notempty-message="<?php  printf("%s is required",$this->title);?>"
		      		<?php } echo $extraattr;?>
		      		>
		      		<?php if(!empty($this->note)){?>
		      		<span class="form-group-help-block"><?php echo $this->note;?></span>
		      		<?php }
		      		
		      	}elseif($this->type=="A"){
		      	    ?>
		      	    <textarea maxlength="<?php echo $this->maxlength;?>"   
		      		class="form-control <?php echo $this->class;?>" id="<?php echo $this->name;?>" name="<?php echo $this->name;?>"   
		      		placeholder="<?php echo ($this->title); ?>" 
		      		<?php if($this->is_required){?>
		      		data-bv-notempty="true" data-bv-notempty-message="<?php  printf("%s is required",$this->title);?>"
		      		<?php }  echo $extraattr;?>
		      		><?php echo  $this->GetPostValue();?></textarea>
		      		<?php if(!empty($this->note)){?>
		      		<span class="form-group-help-block"><?php echo $this->note;?></span>
		      		<?php }
		      	    
		      	}elseif($this->type=="O"){
					?>
					  
					     	<div class="togglebutton ">
						    	<input  name="<?php echo $this->name;?>" value="N" type="hidden">
								<label> 
									<input  type="checkbox" <?php echo $this->GetPostValue()=="Y"?' checked="checked"':'';?> value="Y" class="<?php echo $this->class;?>" id="<?php echo $this->name;?>"  name="<?php echo $this->name;?>" <?php echo $extraattr;?> > 
								</label>
								<?php if(!empty($this->note)){?>
					      		<span class="form-group-help-block"><?php echo $this->note;?></span>
					      		<?php }?>
							</div>
							
				      
					<?php 
				}elseif($this->type=="R"){					
					?>
					  <div class="inline radio-inline">
			        <?php 
			            $__api_input_selected= $this->GetPostValue();			           
			            $this->GetHTMLRadioByArray($this->name,$this->title,$this->name,true,$this->option,$__api_input_selected,false,true,$this->class,$this->attr);
			            ?>
			        
			       </div> 
			       <?php if(!empty($this->note)){?>
					      		<span class="form-group-help-block"><?php echo $this->note;?></span>
					      		<?php }?>
					     	
							
				      
					<?php 
				}elseif($this->type=="D"){
				   $selected= $this->GetPostValue();
				    ?>
				    <select class="form-control <?php echo $this->class;?>" id="<?php echo $this->name;?>" name="<?php echo $this->name;?>"  
		      		<?php if($this->is_required){?>
		      		data-bv-notempty="true" data-bv-notempty-message="<?php  printf("%s is required",$this->title);?>"
		      		<?php } echo $extraattr;?>
		      		>
		      		<?php $this->GetHTMLOptionByArray($this->option,$selected)?>
		      		</select>
				    <?php 
				}
		      		?>
		      		
		      	<?php if($is_horizontal){?></div><?php }?>
		      </div>
        <?php 
        }
    }
}