<?php

defined('APPSBD_APP') OR exit('No direct script access allowed');
require_once __DIR__."/AppInstamojo.php";
add_action("init",function(){
    $instamojo=new AppInstamojo();
    AppPaymentBase::RegisterPaymentMethod($instamojo);
});
