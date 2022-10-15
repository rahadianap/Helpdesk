<?php

defined('APPSBD_APP') OR exit('No direct script access allowed');
require_once __DIR__."/AppRazorPay.php";
add_action("init",function(){
    $razorPay=new AppRazorPay();
    AppPaymentBase::RegisterPaymentMethod($razorPay);
});
