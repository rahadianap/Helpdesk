<?php

defined('APPSBD_APP') OR exit('No direct script access allowed');
require_once __DIR__."/AppPayTM.php";
add_action("init",function(){
    $payuMoney=new AppPayTM();
    AppPaymentBase::RegisterPaymentMethod($payuMoney);
});
