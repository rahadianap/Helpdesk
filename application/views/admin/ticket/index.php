<?php 
$cookie_post_fix=get8BitHashCode($grid_url);
$grid=new jQGrid();
$grid->url =$grid_url;
$grid->width = "auto";
$grid->height = "auto";
$grid->rowNum = 20;
$grid->pager = "#pagerb";
$grid->container = ".grid-body";
$grid->ShowReloadButtonInTitle=true;
$grid->ShowDownloadButtonInTitle=true;
$grid->loadComplete="data_on_complete";
$cookie_name=Mapp_setting::get_cookie_prefix()."_".$cookie_post_fix;
$is_checked=false;
if(isset($_COOKIE[$cookie_name]) && $_COOKIE[$cookie_name]=="Y"){
    $is_checked=true;
}
$grid->AddTitleRightHtml('<div class="form-group form-group-sm"><label class="control-label" for="is_auto_refresh">'.__('Enable Auto Reload (every %d min) ',1).'</label><div class="togglebutton "><label><input '.($is_checked?' checked="checked"':"").'  type="checkbox"  value="Y" class="" id="is_auto_refresh"  name="is_auto_refresh" ></label></div></div>');
$grid->AddSearchProperty("Track ID", "ticket_track_id");
$grid->AddSearchProperty("Client Email", "client_email");
$grid->AddSearchProperty("Client Name", "client_name");
$grid->AddModel("Title", "title", 260 ,"left");
$grid->SetXSCombindeField("title");
$grid->AddModelNonSearchable("Open Time", "opened_time", 60 ,"center","",true);
$grid->AddModelNonSearchable("Assigned", "assigned_on", 100 ,"left");
$grid->AddModelNonSearchable("Last Reply", "last_replied_by", 100 ,"left");
$grid->AddModelNonSearchable("L.Reply Time", "last_reply_time", 60 ,"center","",true);
$grid->isColumnChoseable=true;
$customes=Mcustom_field::getGridColumn();
get_grid_custom_column($grid,$customes);
if(ACL::HasPermission("admin/ticket/details")){
	$grid->AddModelNonSearchable("Action", "action", 80 ,"center");
}
$categories=["0"=>"All Category"]+Mcategory::getCategoryListHtmlOptionArrayOnlyTicket('A');
$ticket=new Mticket();
$prTicket=array_merge(["*"=>"All Priorities"],$ticket->GetPropertyOptions("priroty"));
$grid->AddSearchProperty("Category", "cat_id","select",$categories);
$grid->AddSearchProperty("Priority", "priroty","select",$prTicket);
?>
<style>
.gs-jq-grid .ui-jqgrid .loading {
  top: 20% !important;
}
</style>
<div class="box box-primary">
     <div class="box-body grid-body">
     <?php $grid->show();?>
     </div><!-- /.box-body -->
</div>
<script type="text/javascript">
var reload_interval=null;
function data_on_complete(rdata){
	setToolTipNalert();
	$("[aria-describedby$=cat_id]").removeAttr("title");
}
function Reload_setting(){
	var isChecked=$("#is_auto_refresh").is(":checked");
	if(isChecked){
		setCookie(appGlobalLang.base_cookie_name+"_<?php echo $cookie_post_fix;?>", "Y", 15,"/");    
    	if(!reload_interval){
    		reload_interval=setInterval(
    	    function(){
    		<?php echo $grid->ReloadMethod();?>();
    		},60000);
    	}
	}else{
		try{
			deleteCookie(appGlobalLang.base_cookie_name+"_<?php echo $cookie_post_fix;?>");  
			clearInterval(reload_interval);
			reload_interval=null;
		}catch(e){}
	}
}
/*window.onbeforeunload = function(e) {
    return 'Are you sure you want to leave this page?  You will lose any unsaved data.';
 };*/
$(function(){
	AddOnPageCloseMethod(function(e){
		console.log("Called");
	});
	AddOnCloseMethod(<?php echo $grid->ReloadMethod();?>);
	AddOnShowNotificationMethod(<?php echo $grid->ReloadMethod();?>);
	Reload_setting();
	$("#is_auto_refresh").on("change",function(){
		Reload_setting();
			  
	});
	
});
   
</script>
