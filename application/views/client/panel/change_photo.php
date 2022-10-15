<div class="clearfix  text-center">
    <?php
    if(empty($mainobj)){
        $mainobj=new Msite_user();
        AddError("Main object has not initialized in controller");
    }
    if(!empty($mainobj->photo_url)){
        $currentPhoto=$mainobj->photo_url;
    }else{
        $currentPhoto=base_url("images/default-user-image.png");
    }
    ?>
    <div class="form-group">

            <img class="app-image-input img-thumbnail" data-name="user_photo" src="<?php echo $currentPhoto;?>" style="max-height: 200px; max-width: 250px;"/>
            <span class="form-group-help-block"><?php _e("Click on the Image to change. Best size is 250px x 200px");?></span>

    </div>
</div>
<div class="row btn-group-md popup-footer text-right">
    <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> <?php echo __("Save")?></button>
    <button type="button" class="close-pop-up btn  btn-danger"><i class="fa fa-times"></i> <?php _e("Cancel");?></button>
</div>
