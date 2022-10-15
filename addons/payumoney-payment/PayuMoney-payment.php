<?php

defined('APPSBD_APP') OR exit('No direct script access allowed');
require_once __DIR__."/AppPayuMoney.php";
add_action("init",function(){
    $payuMoney=new AppPayuMoney();
    AppPaymentBase::RegisterPaymentMethod($payuMoney);
});
