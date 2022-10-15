SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_message
-- ----------------------------
DROP TABLE IF EXISTS `admin_message`;
CREATE TABLE `admin_message`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `body` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `to_user` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'FK(app_user,id,title)',
  `from_user` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `last_replied` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=New,R=Read,D=Deleted)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_message
-- ----------------------------

-- ----------------------------
-- Table structure for admin_message_reply
-- ----------------------------
DROP TABLE IF EXISTS `admin_message_reply`;
CREATE TABLE `admin_message_reply`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `msg_id` int(11) NOT NULL DEFAULT 0,
  `reply_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `replied_by` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=New,R=Read,D=Deleted)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `msg_id`(`msg_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_message_reply
-- ----------------------------

-- ----------------------------
-- Table structure for admin_note
-- ----------------------------
DROP TABLE IF EXISTS `admin_note`;
CREATE TABLE `admin_note`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ref_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ref_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'radio(T=On TIcket, U=On Client)',
  `user_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `note` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `entry_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of admin_note
-- ----------------------------

-- ----------------------------
-- Table structure for app_log
-- ----------------------------
DROP TABLE IF EXISTS `app_log`;
CREATE TABLE `app_log`  (
  `user_id` char(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `user_type` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_role` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'C' COMMENT 'E=User, A=Admin,C=Company',
  `changed_page` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `changed_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'U' COMMENT 'U=Update, A=ADD, D=Delete,O=Others',
  `changed_value` char(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `msg_code` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `msg_param` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `ip` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `date_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `tag` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `member_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `agent_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  INDEX `pv_id`(`user_id`) USING BTREE,
  INDEX `agent_id`(`agent_id`) USING BTREE,
  INDEX `member_id`(`member_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of app_log
-- ----------------------------

-- ----------------------------
-- Table structure for app_notificaiton
-- ----------------------------
DROP TABLE IF EXISTS `app_notificaiton`;
CREATE TABLE `app_notificaiton`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `msg` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `entry_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=Notification,M=message)',
  `entry_link` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `n_counter` decimal(2, 0) UNSIGNED NOT NULL DEFAULT 1,
  `is_popup_link` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `view_time` timestamp(0) NULL DEFAULT NULL,
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `item_type` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `extra_param` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'radio(A=Active,V=Viewed,D=Deleted)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_type`(`user_id`) USING BTREE,
  INDEX `user_id_item`(`user_id`, `item_type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'notification' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of app_notificaiton
-- ----------------------------

-- ----------------------------
-- Table structure for app_setting
-- ----------------------------
DROP TABLE IF EXISTS `app_setting`;
CREATE TABLE `app_setting`  (
  `s_key` char(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `s_title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `s_val` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `s_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'drop(T=Textbox,A=Textarea,B=Boolean,D=Dropdown,R=Radio,Z=Timezone)',
  `s_option` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `s_auto_load` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  PRIMARY KEY (`s_key`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of app_setting
-- ----------------------------
INSERT INTO `app_setting` VALUES ('app_email', 'App Email', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_title', 'App Title', 'Support System', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_theme', 'APP Theme', 'bss2020', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_hmp', 'APP Homepage', '1', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('isonly_logo', 'Show Only Logo', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_date_format', 'Date Format', 'M d, Y', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_time_format', 'Time Format', 'H:i', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('regi_enable', 'Registration', 'N', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_captcha', 'Captcha Settings', 'D', 'R', 'eyJEIjoiRGVmYXVsdCIsIkciOiJHb29nbGUgUmUtY2FwdGNoYSJ9', 'Y');
INSERT INTO `app_setting` VALUES ('ap_dc_length', 'Captcha length', '6', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('ap_dc_str_type', 'Captcha String Type', 'AN', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_gc_secret', 'Re-Captcha Secret Key', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_gc_site_key', 'Re-Captcha Site Key', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_main_color', 'Main Color', '#0B8EC2', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_text_color', 'Link and Heading Color', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_welcome_bg', 'Welcome Background', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_welcome_text', 'Welcome Text', '#ffffff', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_header_bg', 'Header background Color', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_c_auto', 'Auto Others Color', 'Y', 'B', 'eyJZIjoiWWVzIiwiTiI6Ik5vIn0=', 'Y');
INSERT INTO `app_setting` VALUES ('app_navbar_bg', 'Menu Background', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_nav_acive_text', 'Menu Active Text color', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('footer_bg_color', 'Footer Background', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('footer_text_color', 'Footer Text Color', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_header_isg', 'Header Gradient', 'N', 'B', 'eyJZIjoiWWVzIiwiTiI6Ik5vIn0=', 'Y');
INSERT INTO `app_setting` VALUES ('is_cptcha_client_login', 'Client Captcha Login', 'N', 'B', 'eyJZIjoiWWVzIiwiTiI6Ik5vIn0=', 'Y');
INSERT INTO `app_setting` VALUES ('is_cptcha_guest_ticket', 'On Guest Ticket', 'Y', 'B', 'eyJZIjoiWWVzIiwiTiI6Ik5vIn0=', 'Y');
INSERT INTO `app_setting` VALUES ('is_cptcha_client_regi', 'Client Registration Captcha', 'Y', 'B', 'eyJZIjoiWWVzIiwiTiI6Ik5vIn0=', 'Y');
INSERT INTO `app_setting` VALUES ('is_cptcha_admin_login', 'Admin Login Captcha', 'N', 'B', 'eyJZIjoiWWVzIiwiTiI6Ik5vIn0=', 'Y');
INSERT INTO `app_setting` VALUES ('max_file_upload_size', 'Max Upload File Size', '2', 'N', '', 'Y');
INSERT INTO `app_setting` VALUES ('allowed_file_type', 'Allowed file type', 'jpg|png|zip', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('allow_profile_upload', 'Profile Upload', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('allow_ticket_file_upload', 'Allow Ticket File Upload', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_guest_ticket', 'Enable Guest Ticket', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_public_ticket', 'Enable Guest Ticket', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('ticket_htmleditor', 'Ticket HTML Editor', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_html_editor', 'Choose HTML Editor', 'S', 'R', 'eyJTIjoiU3VtbWVybm90ZSIsIkMiOiJDSyBFZGl0b3IifQ==', 'Y');
INSERT INTO `app_setting` VALUES ('app_layout', 'Application Layout', 'B', 'R', 'eyJGIjoiRnVsbCBXaWR0aCIsIkIiOiJCb3ggU2l6ZSJ9', 'Y');
INSERT INTO `app_setting` VALUES ('is_check_online', 'User Online Status Check', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('ticket_email_str', 'Ticket Email String', '##Ticket ID:', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('ticket_email_rp_str', 'Ticket Email Reply Line', '##- Please type your reply above this line -##', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('any_can_assign', 'Is any staff can reply', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_imap_ticket', 'Email to Ticket', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('imap_host', 'IMAP Host', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('imap_port', 'IMAP Host', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('imap_is_secure', 'IMAP Secure Protocol', '', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('imap_user', 'IMAP User', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('imap_pass', 'IMAP Password', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('out_email_name', 'From Name', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('out_email_from', 'From Email', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('out_email_protocol', 'Email Protocol', 'sendmail', 'R', 'eyJzZW5kbWFpbCI6IlNlbmRtYWlsIiwic210cCI6IlNNVFAifQ==', 'Y');
INSERT INTO `app_setting` VALUES ('mailpath', 'Sendmail Path', '/usr/sbin/sendmail', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('smtp_host', 'SMTP Host', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('smtp_port', 'SMTP Host', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('smtp_is_secure', 'SMTP Secure Protocol', '', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('smtp_user', 'SMTP User', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('smtp_pass', 'SMTP Password', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_dos_atk', 'Enable DoS Attack', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_dos_req', 'DoS Attack Request Count', '30', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_dos_sec', 'DoS Attack Request Seconds', '10', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_dos_action', 'DoS Attack Action', 'C', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_user_scq', 'Enable Admin User Security', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('appuser_sec_tried', 'Loing Miss Attempts', '5', 'N', '', 'Y');
INSERT INTO `app_setting` VALUES ('appuser_sec_min', 'Miss Attempts Interval', '30', 'N', '', 'Y');
INSERT INTO `app_setting` VALUES ('fb_enable', 'Feedback Enable', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('fb_e_msg', 'Feedback message email title', 'How do you rate the support you received?', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('fb_n_msg', 'Nagative Feedback Message', 'We are very sorry, we will try our best in future', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('fb_p_msg', 'Positive Feedback Message', 'We are very happy that we were able to satisfy you.', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('msg_last_tried', '_mt', '1531905713', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_app_forcessl', 'Enable Force SSL', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('licstr', '-', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('_uprcs', 'UProcs', '2.1.0', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('dlogin_enable', 'Default Login', 'N', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('dgustpopup', 'Disable Guest Popup', 'N', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_alpguest_ticket', 'Show All Priroty', 'N', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_lang', 'App Language', '', 'Y', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_clang', 'App Site Language', '', 'Y', '', 'Y');
INSERT INTO `app_setting` VALUES ('app_noti_email', 'Notification Email', '', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_netkt_open', 'On Ticket Open', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_netktu_reply', 'On ticket User Notification', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_netkta_reply', 'On Admin User Reply Notification', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_aetkt_open', 'Email On ticket User Assign', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_astkt_open', 'icket User Assign Notification', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_nstkt_open', 'On Ticket Open', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_nstktu_reply', 'On ticket User Notification', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_nstkta_reply', 'On Admin User Reply Notification', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_nstone', 'Is Admin Notification Tone', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('enable_aclose', 'Enable Ticket Auto close', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('aclosing_rule', 'Auto closing rule', 'N', 'N', '', 'Y');
INSERT INTO `app_setting` VALUES ('aclosing_msg', 'Auto closing message', 'As the ticket has been inactive for a long time, we are considering the issue to be resolved. Our support system is closing this ticket automatically.', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('up_last_tried', '_tt', '1531905715', 'T', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_state_kn', 'Disable Knowledge Stat In Homepage', 'N', 'B', '', 'Y');
INSERT INTO `app_setting` VALUES ('is_first_run', '', 'N', 'T', '', 'N');

-- ----------------------------
-- Table structure for app_setting_api
-- ----------------------------
DROP TABLE IF EXISTS `app_setting_api`;
CREATE TABLE `app_setting_api`  (
  `s_api_name` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `s_key` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `s_title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `s_val` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `s_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'drop(T=Textbox,A=Textarea,B=Boolean,D=Dropdown,R=Radio,Z=Timezone)',
  `s_option` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `s_auto_load` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Y' COMMENT 'bool(Y=Yes,N=No)',
  UNIQUE INDEX `api_name`(`s_api_name`, `s_key`) USING BTREE,
  INDEX `s_api_name`(`s_api_name`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_setting_api
-- ----------------------------
INSERT INTO `app_setting_api` VALUES ('Envato', 'api_type', 'API Type', 'P', 'R', 'eyJQIjoiUGVyc29uYWwiLCJPIjoiT2xkIFRva2VuIn0=', 'N');
INSERT INTO `app_setting_api` VALUES ('Envato', 'api_username', 'Envato Username', '', 'T', '', 'N');
INSERT INTO `app_setting_api` VALUES ('Envato', 'api_token', 'API Token', '', 'T', '', 'N');
INSERT INTO `app_setting_api` VALUES ('paypal', 'is_enable_paypal', 'is_enable_paypal', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('paypal', 'is_test_mode', 'is_test_mode', 'Y', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('paypal', 'client_id', 'client_id', '', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('paypal', 'secret', 'secret', '', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'is_enable_g_login', 'is_enable_g_login', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'login_g_client_id', 'login_g_client_id', '', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'login_g_secret', 'login_g_secret', '', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'is_enable_f_login', 'is_enable_f_login', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'is_enable_t_login', 'is_enable_t_login', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'is_enable_l_login', 'is_enable_l_login', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'is_enable_gh_login', 'is_enable_gh_login', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('social', 'is_enable_y_login', 'is_enable_y_login', 'N', 'B', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('system', 'footer_text', 'footer_text', '<p>This a support system of for our client. We will try our best for you. Please feel free to contact with us</p>', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('system', 'welcome_msg', 'welcome_msg', '<h2 id=\"page-header-title\" align=\"center\">Support Desk</h2><h3 id=\"page-header-tagline\" align=\"center\">Its a support application for our product. We normally response within 24 hours<br></h3>', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_is_active', 'gdpr_is_active', 'N', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_ua_active', 'gdpr_ua_active', 'Y', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_cnb', 'gdpr_cnb', 'Y', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_cnb_bg', 'gdpr_cnb_bg', '#38c0b1', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_cnb_tc', 'gdpr_cnb_tc', '#000000', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_cookie_msg', 'gdpr_cookie_msg', '<p>This website uses \r\ncookies. Continued use of this website indicates you have read and \r\nunderstood our Privacy & Cookies policy and agree to its terms. <span style=\"color: rgb(206, 0, 0);\"><span style=\"font-weight: bold;\">{{PolicyLink}}</span></span><br></p>', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_is_popsh', 'gdpr_is_popsh', 'Y', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gpbr_bg_op', 'gpbr_bg_op', '95', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_bar_ani', 'gdpr_bar_ani', 'slideInUp', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_bar_cani', 'gdpr_bar_cani', 'slideOutDown', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gpbr_dis_event', 'gpbr_dis_event', 'S', 'T', '', 'Y');
INSERT INTO `app_setting_api` VALUES ('gdpr', 'gdpr_ud_active', 'gdpr_ud_active', 'Y', 'T', '', 'Y');

-- ----------------------------
-- Table structure for app_user
-- ----------------------------
DROP TABLE IF EXISTS `app_user`;
CREATE TABLE `app_user`  (
  `pvid` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `user` char(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `title` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `email` char(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `pass` char(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `role` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'FK(role_list,role_id,title)',
  `panel` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'A=Active, I=Inactive',
  `add_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `contact_number` char(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `img_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tzone` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'drop(Asia/Dhaka=Dhaka Bangladesh)',
  `gender` char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'radio(M=Male,F=Female)',
  `address` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `region` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `city` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zip` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `country` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'drop(US=United States)',
  `dob` char(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0000-00-00' COMMENT 'date of birth',
  `is_enable_chat` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Y' COMMENT 'bool(Y=Yes,N=No)',
  PRIMARY KEY (`user`) USING BTREE,
  UNIQUE INDEX `user`(`pvid`, `user`) USING BTREE,
  UNIQUE INDEX `email`(`pvid`, `email`) USING BTREE,
  INDEX `user_status`(`pvid`, `user`, `status`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app_user
-- ----------------------------
INSERT INTO `app_user` VALUES ('AA', 'AA', 'admin', 'Admin User', '', '515c201e1512b0b587ad2c89ab5fc1f9', 'R1', 'A', 'A', '2015-12-01 17:01:54', '', '', 'Asia/Dhaka', 'M', 'test', '', 'Dhaka', '1217', 'BD', '0000-00-00', 'Y');

-- ----------------------------
-- Table structure for canned_msg
-- ----------------------------
DROP TABLE IF EXISTS `canned_msg`;
CREATE TABLE `canned_msg`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `title` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `canned_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'textarea',
  `entry_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `added_by` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `canned_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'drop(T=Ticket,C=Chat)',
  `status` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of canned_msg
-- ----------------------------
INSERT INTO `canned_msg` VALUES (3, '', 'Thanks for patient', '<', '2017-12-21 18:56:05', 'AA', 'T', 'A');
INSERT INTO `canned_msg` VALUES (4, '', 'Test Reply', '<', '2017-12-21 19:14:18', 'AA', 'T', 'A');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `parent_category` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK(category,id,title)',
  `parent_category_path` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `show_on` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'B' COMMENT 'radio(B=Both,K=Only Knowledge,T=Only on Ticket)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `open_user_id` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `is_remote_typing` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `is_user_typing` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `end_by_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'radio(A=Staff,C=Client)',
  `end_by` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `current_admin_user` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `start_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `end_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
  `bw_name` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'Browser Idea',
  `country` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `last_msg_time` timestamp(0) NULL DEFAULT NULL,
  `last_msg_by` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'radio(A=Admin,U=User)',
  `last_page_list` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `ip` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `header_msg` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=Not Started, S=Started,E=End)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of chat
-- ----------------------------

-- ----------------------------
-- Table structure for chat_denied
-- ----------------------------
DROP TABLE IF EXISTS `chat_denied`;
CREATE TABLE `chat_denied`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` int(11) NOT NULL DEFAULT 0,
  `app_user_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chat_id`(`chat_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of chat_denied
-- ----------------------------

-- ----------------------------
-- Table structure for chat_msg
-- ----------------------------
DROP TABLE IF EXISTS `chat_msg`;
CREATE TABLE `chat_msg`  (
  `chat_id` int(10) UNSIGNED NOT NULL,
  `msg_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `temp_id` char(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `reply_user_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(S=System,U=User,A=Admin,N=No User)',
  `reply_user_id` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `form_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  UNIQUE INDEX `chat_id_msg_id`(`chat_id`, `msg_id`) USING BTREE,
  INDEX `chat_id`(`chat_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_msg
-- ----------------------------

-- ----------------------------
-- Table structure for custom_field
-- ----------------------------
DROP TABLE IF EXISTS `custom_field`;
CREATE TABLE `custom_field`  (
  `id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cat_id` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `help_text` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'radio(T=Textbox,N=Numeric,D=Dropdown,A=Date,R=Radio)',
  `opt_json_base` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_required` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `default_value` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `is_api_based` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `is_private` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `is_on_grid` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `api_name` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'like: EnvatoAPI',
  `on_submit_api_check` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Y' COMMENT 'bool(Y=Yes,N=No)',
  `fld_order` int(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of custom_field
-- ----------------------------

-- ----------------------------
-- Table structure for custom_page
-- ----------------------------
DROP TABLE IF EXISTS `custom_page`;
CREATE TABLE `custom_page`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `slag_title` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `page_body` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'textarea',
  `added_on` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active, I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'page' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of custom_page
-- ----------------------------
INSERT INTO `custom_page` VALUES (1, 'privacy-terms-condition-conditions', 'Privacy & terms condition conditions', 'Update your privacy policy in Page menu ( Admin Settings> Pages> select Page Edit)', '2018-09-19 23:27:34', 'A');

-- ----------------------------
-- Table structure for debug_log
-- ----------------------------
DROP TABLE IF EXISTS `debug_log`;
CREATE TABLE `debug_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'S' COMMENT 'radio(E=Error,S=Success)',
  `log_type` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'GEN' COMMENT 'drop(GEN=General,EML=Email,OTH=Others)',
  `title` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `log_data` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'S' COMMENT 'drop(F=Failed,S=Success)',
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `entry_type`(`entry_type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of debug_log
-- ----------------------------

-- ----------------------------
-- Table structure for email_templates
-- ----------------------------
DROP TABLE IF EXISTS `email_templates`;
CREATE TABLE `email_templates`  (
  `k_word` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `grp` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  `subject` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`k_word`) USING BTREE,
  UNIQUE INDEX `email_keyword`(`k_word`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email_templates
-- ----------------------------
INSERT INTO `email_templates` VALUES ('AFP', 'Admin', 'Admin or Staff  Forget Password', 'A', '[{{site_name}}] Password Recovery', '<p>Hi {{user_name}},<br><br>We receive a request to reset your password. To do so, <br>Please click the button below:<br><br>{{recover_button}}<br><br>If you did not request a password reset, please ignore this email<br>or reply to let us know. <br><br>Thanks<br>{{site_name}}<br><br><br></p>');
INSERT INTO `email_templates` VALUES ('AWE', 'Admin', 'Admin or Staff  Welcome message-New User', 'A', 'Welcome to [{{site_name}}]', '<h1>Welcome to {{site_name}},</h1><h3>Dear {{full_name}},</h3><p>Your Login information are given bellow:</p><p>{{login_info}}<br></p><p>Thanks<br>{{site_name}}<br></p><p><br></p>');
INSERT INTO `email_templates` VALUES ('APC', 'Admin', 'Admin Password Changed Successfully', 'A', '[{{site_name}}] Password Changed Successfully', '<p>Hi {{user_name}},<br><br>Your password has been change successfully<br><br>If you did not change the password,&nbsp; please contact with {{site_name}} admin as early as possible<br><br>Thanks<br>{{site_name}}<br><br><br></p>');
INSERT INTO `email_templates` VALUES ('UOT', 'Ticket', 'Ticket Open By User', 'A', '[{{site_name}}]Ticket opend # {{ticket_track_id}}', '<p>Dear {{ticket_user}},<br><br>Thanks for creating a ticket on {{site_name}}<br>Your ticket track id :<b> {{ticket_track_id}}</b><b><br></b>Your ticket link :<b> {{ticket_link}}</b><b><br></b><b><br></b></p><p><b>Ticket Title: </b>{{ticket_title}}<br><b>Ticket Body :<br></b>----------------Start---------------------<b><br></b></p><p>{{ticket_body}}<br>----------------End-----------------------</p><p>We\'ll be in touch shortly.<br></p><p><br>Thanks,<br>{{site_name}}<br></p><p><br></p>');
INSERT INTO `email_templates` VALUES ('GOT', 'Ticket', 'Ticket Open By Guest', 'A', '[{{site_name}}] Guest Ticket opend # {{ticket_track_id}}', '<p>Dear [Guest User]<br><br>Thanks for creating a ticket on {{site_name}}<br>Your ticket track id :<b> {{ticket_track_id}}<br></b>Your ticket link :<b> {{ticket_link}}</b><b><br></b></p><p><b>Ticket Title: </b>{{ticket_title}}<br><b>Ticket Body :<br></b></p><p>{{ticket_body}}</p><p><br></p>We\'ll be in touch shortly.<p><br>Thanks,</p><p>{{site_name}}<br></p>');
INSERT INTO `email_templates` VALUES ('UWE', 'Site', 'Site User Welcome Email after opening account', 'A', 'Welcome to [{{site_name}}]', '<h1>Welcome to {{site_name}},</h1><h3>Dear {{full_name}},</h3><p>Your Login information are given bellow:</p><p>{{login_info}}<br></p><p>Thanks<br>{{site_name}}<br></p><p><br></p>');
INSERT INTO `email_templates` VALUES ('TRO', 'Ticket', 'Ticket Reopen', 'A', '[{{site_name}}]  Ticket Re-Opened # {{ticket_track_id}}', '<p>Dear&nbsp; {{ticket_user}},<br>Your ticket has been re-opened.<br></p><p>Ticket details are given bellow:<br><b>Ticket Title: </b>{{ticket_title}}<br><b>Your ticket track id :</b> {{ticket_track_id}}<b><br>Your ticket link :</b> {{ticket_link}}</p><p><b><br></b>Thanks,<br>{{site_name}}<br></p>');
INSERT INTO `email_templates` VALUES ('UFP', 'Site', 'Site User Forget Password', 'A', '[{{site_name}}] Password Recovery', 'Hi {{user_name}},<br><br>We receive a request to reset your password. To do so, <br>Please click the button below:<br><br>{{recover_button}}<br><br>If you did not request a password reset, please ignore this email<br>or reply to let us know. <br><br>Thanks<br>{{site_name}}<br><br>');
INSERT INTO `email_templates` VALUES ('UPC', 'Site', 'Site User Password Changed Successfully', 'A', '[{{site_name}}] Password Changed Successfully', '<p>Hi {{user_name}},<br><br>Your password has been change successfully<br><br>If you did not change the password , please contact with {{site_name}} admin as early as possible<br><br>Thanks<br>{{site_name}}<br><br><br></p>');
INSERT INTO `email_templates` VALUES ('TRR', 'Ticket', 'Ticket Reply Received', 'A', '[{{site_name}}] Ticket Replied # {{ticket_track_id}}', '<p>Dear {{ticket_user}},<br>Our staff ( {{ticket_replied_user}} ) has replied on your ticket. Ticket details are given bellow:</p><p><b>Ticket Title: </b>{{ticket_title}}<br><b>Your ticket track id :</b> {{ticket_track_id}}<b><br>Your ticket link :</b> {{ticket_link}}<b><br></b></p><p>Thanks,<br>{{site_name}}</p>');
INSERT INTO `email_templates` VALUES ('TCL', 'Ticket', 'Ticket Closed or Feedback email', 'A', '[{{site_name}}]  Ticket has been closed # {{ticket_track_id}}', '<p>Dear {{ticket_user}},<br>Your ticket has been closed .Ticket details are given bellow:</p><p><b>Ticket Title: </b>{{ticket_title}}<br><b>Your ticket track id :</b> {{ticket_track_id}}<b><br>Your ticket link :</b> {{ticket_link}}</p><p>{{ticket_feedback_button}}<b><br></b></p><p><b><br></b>Thanks,<br>{{site_name}}<br></p>');
INSERT INTO `email_templates` VALUES ('ANT', 'Admin', 'Admin new ticket notification email', 'A', '[{{site_name}}] New ticket received# {{ticket_track_id}}', '<h5>Dear Admin,</h5><h5>New ticket has been received. Ticket information is given below:<br></h5><p>Ticket User&nbsp; :&nbsp; <b>{{ticket_user}}</b><br>Ticket track id&nbsp; :<b>&nbsp; {{ticket_track_id}}</b><b><br></b>Ticket title :<b>&nbsp; </b><b>{{ticket_title}}<br></b>Ticket link&nbsp; :<b>&nbsp; {{ticket_link}}</b><b><br></b></p><p><b><br></b></p><p><span style=\"font-size: 14px;\">Thanks</span><b><br></b><span style=\"font-size: 14px;\">{{site_name}}</span><b><br></b></p><p><br></p>');
INSERT INTO `email_templates` VALUES ('ANR', 'Admin', 'Admin new ticket reply notification email', 'A', '[{{site_name}}] New ticket reply received # {{ticket_track_id}}', '<h5>Dear Admin,</h5><h5>New ticket reply has been received. Ticket information is given below:<br></h5><p>Ticket User&nbsp; :&nbsp; <b>{{ticket_user}}<br></b>Replied User&nbsp; :&nbsp; <b>{{ticket_replied_user}}</b><br>Ticket track id&nbsp; :<b>&nbsp; {{ticket_track_id}}</b><b><br></b>Ticket title :<b>&nbsp; </b><b>{{ticket_title}}<br></b>Ticket link&nbsp; :<b>&nbsp; {{ticket_link}}<br><br>Reply Text<br>-------------------------------------<br></b>{{replied_text}}<br>---------------------------------------<br><span style=\"font-size: 14px;\">Thanks</span><b><br></b><span style=\"font-size: 14px;\">{{site_name}}</span><b><br></b></p><p><br></p>');
INSERT INTO `email_templates` VALUES ('TAC', 'Ticket', 'Ticket Auto Closing message', 'A', '[{{site_name}}]  Ticket has been auto closed # {{ticket_track_id}}', '<p>Dear {{ticket_user}},</p><p>{{ticket_closing_msg}}<br></p><p>If the issue is still exist then you can reopen the ticket anytime. </p><p>The ticket information are  given bellow:<br></p><p><b>Ticket Title: </b>{{ticket_title}}<br><b>Your ticket track id :</b> {{ticket_track_id}}<b><br>Your ticket link :</b> {{ticket_link}}</p><p><b><br></b></p><p><b><br></b>Thanks,<br>{{site_name}}<br></p>');
INSERT INTO `email_templates` VALUES ('AAT', 'Admin', 'Admin Ticket Assign notification email', 'A', '[{{site_name}}] New ticket has been assigned to you # {{ticket_track_id}}', '<h5>Dear {{ticket_assigned_user}},</h5><h5>New ticket has been assigned to you. Ticket information is given below:<br></h5><p>Ticket User&nbsp; :&nbsp; <b>{{ticket_user}}</b><br>Ticket track id&nbsp; :<b>&nbsp; {{ticket_track_id}}</b><b><br></b>Ticket title :<b>&nbsp; </b><b>{{ticket_title}}<br></b>Ticket link&nbsp; :<b>&nbsp; {{ticket_link}}</b><b><br></b></p><p><b><br></b></p><p><span style=\"font-size: 14px;\">Thanks</span><b><br></b><span style=\"font-size: 14px;\">{{site_name}}</span><b><br></b></p><p><br></p>');

-- ----------------------------
-- Table structure for expired_info
-- ----------------------------
DROP TABLE IF EXISTS `expired_info`;
CREATE TABLE `expired_info`  (
  `key` char(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of expired_info
-- ----------------------------

-- ----------------------------
-- Table structure for faq_category
-- ----------------------------
DROP TABLE IF EXISTS `faq_category`;
CREATE TABLE `faq_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `entry_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faq_category
-- ----------------------------

-- ----------------------------
-- Table structure for faq_list
-- ----------------------------
DROP TABLE IF EXISTS `faq_list`;
CREATE TABLE `faq_list`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_id` int(10) UNSIGNED NOT NULL COMMENT 'FK(faq_category,id,name)',
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ans` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `entry_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `ord` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faq_list
-- ----------------------------

-- ----------------------------
-- Table structure for guest_user
-- ----------------------------
DROP TABLE IF EXISTS `guest_user`;
CREATE TABLE `guest_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `last_name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `username` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` char(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `pass` char(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `is_verified_email` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `gender` char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `phone` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `address` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `region` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `city` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zip` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `country` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `dob` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'date of birth',
  `profile_url` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo_url` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `age` decimal(2, 0) NOT NULL DEFAULT 0,
  `login_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=Normal,F=Facebook,T=Twitter,G=Google,L=Linked In)',
  `join_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `tzone` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `last_login_time` timestamp(0) NULL DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'drop(A=Active,I=Inactive,L=Locked)',
  `user_social_session_data` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'client' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guest_user
-- ----------------------------

-- ----------------------------
-- Table structure for history_misslogin
-- ----------------------------
DROP TABLE IF EXISTS `history_misslogin`;
CREATE TABLE `history_misslogin`  (
  `user_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `hit_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `ip` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'locked_user' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of history_misslogin
-- ----------------------------

-- ----------------------------
-- Table structure for iplist
-- ----------------------------
DROP TABLE IF EXISTS `iplist`;
CREATE TABLE `iplist`  (
  `ip` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `added_on` timestamp(0) NULL DEFAULT NULL,
  `start_count_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `req_counter` decimal(3, 0) NOT NULL,
  `entry_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'radio(A=Auto, M=Manually',
  `country_code` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=Normal,L=Locked,C=Captcha)',
  `h_at_count` decimal(3, 0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ip`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of iplist
-- ----------------------------

-- ----------------------------
-- Table structure for knowledge
-- ----------------------------
DROP TABLE IF EXISTS `knowledge`;
CREATE TABLE `knowledge`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug_id` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cat_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `title` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `k_body` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'textarea',
  `v_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'View Count',
  `l_count` int(11) NOT NULL DEFAULT 0 COMMENT 'like count',
  `d_count` int(11) NOT NULL DEFAULT 0 COMMENT 'dislike count',
  `is_stickey` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `added_by` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'FK(app_user,id,title)',
  `k_tag` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `k_soundex` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `entry_time` timestamp(0) NULL DEFAULT NULL,
  `featured_video_link` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `last_update_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'U' COMMENT 'bool(P=Publish,U=Unpublish)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `is_stickey_status`(`is_stickey`, `status`) USING BTREE,
  INDEX `slug_id`(`slug_id`) USING BTREE,
  FULLTEXT INDEX `src_key`(`title`, `k_body`, `k_tag`, `k_soundex`)
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge
-- ----------------------------
INSERT INTO `knowledge` VALUES (1, 'sample', 0, 'sample', '<p>It\'s sample&nbsp; knowledge<br></p>', 0, 0, 0, 'N', 'AA', 'sample', 'S514', '2018-01-05 17:03:39', '', '2018-01-05 17:03:39', 'P');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `href_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'L' COMMENT 'radio(L=Link, P=Page)',
  `href` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'textarea',
  `text_icon` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `view_counter` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_new_window` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (2, 0, 'Our App', 'L', 'http://appsbd.com', 'fa-external-link', 0, 'Y', 'I');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'textarea',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `msg_for` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'B' COMMENT 'radio(B=Both, S=Site,A=Admin Panel)',
  `added_by` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `added_on` timestamp(0) NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for page_list
-- ----------------------------
DROP TABLE IF EXISTS `page_list`;
CREATE TABLE `page_list`  (
  `res_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `title` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `controller_title` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `directory` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `controller` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `method` char(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `panel` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'DROP(A=Admin,C=Customer)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'A=Active, I=Inactive',
  PRIMARY KEY (`res_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of page_list
-- ----------------------------
INSERT INTO `page_list` VALUES ('AA', 'Role  List', '05. User Settings', 'admin', 'app-permission', 'role-list', 'A', 'A');
INSERT INTO `page_list` VALUES ('AB', 'Role Access', '05. User Settings', 'admin', 'app-permission', 'role-access', 'A', 'A');
INSERT INTO `page_list` VALUES ('AC', 'New Role', '05. User Settings', 'admin', 'app-permission', 'role-add', 'A', 'A');
INSERT INTO `page_list` VALUES ('AD', 'Edit Role', '05. User Settings', 'admin', 'app-permission', 'role-edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('AE', 'Change Role Access', '05. User Settings', 'admin', 'app-permission-confirm', 'change-role-access', 'A', 'A');
INSERT INTO `page_list` VALUES ('AF', 'Resource', '05. User Settings', 'admin', 'app-permission', 'change-page-title', 'A', 'H');
INSERT INTO `page_list` VALUES ('AG', 'Setting List', 'App Setting', 'admin', 'app-setting', 'index', 'A', 'H');
INSERT INTO `page_list` VALUES ('AH', 'New Setting', 'App Setting', 'admin', 'app-setting', 'add', 'A', 'H');
INSERT INTO `page_list` VALUES ('AI', 'User List', '05. User Settings', 'admin', 'app-permission', 'user-list', 'A', 'A');
INSERT INTO `page_list` VALUES ('AJ', 'Dashboard', '08. My Dashboard', 'admin', 'dashboard', 'index', 'A', 'S');
INSERT INTO `page_list` VALUES ('AK', 'Update User', '05. User Settings', 'admin', 'app-permission', 'add-edit-appuser', 'A', 'A');
INSERT INTO `page_list` VALUES ('AL', 'Category List', '12. Category', 'admin', 'category', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('AM', 'New Category', '12. Category', 'admin', 'category', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('AN', 'Edit Category', '12. Category', 'admin', 'category', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('AO', 'Status Change', '12. Category', 'admin', 'category-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('AP', 'Knowledge List', '11. Knowledge', 'admin', 'knowledge', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('AQ', 'New Knowledge', '11. Knowledge', 'admin', 'knowledge', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('AR', 'Ticket List', '10. Ticket', 'admin', 'ticket', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('AS', 'New Ticket', '10. Ticket', 'admin', 'ticket', 'add', 'A', 'H');
INSERT INTO `page_list` VALUES ('AT', 'Role Delete', '05. User Settings', 'admin', 'app-permission-confirm', 'role-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('AU', 'Edit Knowledge', '11. Knowledge', 'admin', 'knowledge', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('AV', 'Status Change', '11. Knowledge', 'admin', 'knowledge-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('AW', 'Index', 'Site', '', 'site', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('AX', 'Not Found', 'Site', '', 'site', 'knowledge', 'C', 'A');
INSERT INTO `page_list` VALUES ('AY', 'About Support System', 'Knowledge', '', 'knowledge', 'details', 'C', 'A');
INSERT INTO `page_list` VALUES ('AZ', 'Counter', 'Knowledge', '', 'knowledge', 'counter', 'C', 'A');
INSERT INTO `page_list` VALUES ('BA', 'Index', 'Hauth', '', 'hauth', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('BB', 'Window', 'Hauth', '', 'hauth', 'window', 'C', 'A');
INSERT INTO `page_list` VALUES ('BC', 'Endpoint', 'Hauth', '', 'hauth', 'endpoint', 'C', 'A');
INSERT INTO `page_list` VALUES ('BD', 'Index', 'Social', '', 'social', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('BE', 'Login', 'Social', '', 'social', 'login', 'C', 'A');
INSERT INTO `page_list` VALUES ('BF', 'Endpoint', 'Social', '', 'social', 'endpoint', 'C', 'A');
INSERT INTO `page_list` VALUES ('BG', 'Social Login Error', 'Social', '', 'social', 'login-error', 'C', 'A');
INSERT INTO `page_list` VALUES ('BH', 'Client List', '14. Client', 'admin', 'client', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('BI', 'New Client', '14. Client', 'admin', 'client', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('BJ', 'Index', 'Test', '', 'test', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('BK', 'General Settings', '02. Admin Setting', 'admin', 'admin-setting', 'general', 'A', 'A');
INSERT INTO `page_list` VALUES ('BL', 'General', '02. Admin Setting', 'admin', 'admin-setting-confirm', 'general', 'A', 'A');
INSERT INTO `page_list` VALUES ('BM', 'S Auto Load Change', 'App Setting', 'admin', 'app-setting-confirm', 's-auto-load-change', 'A', 'S');
INSERT INTO `page_list` VALUES ('BN', 'Edit Setting', 'App Setting', 'admin', 'app-setting', 'edit', 'A', 'H');
INSERT INTO `page_list` VALUES ('BO', 'Modify', '02. Admin Setting', 'admin', 'admin-setting-confirm', 'modify', 'A', 'A');
INSERT INTO `page_list` VALUES ('BP', 'New Ticket', 'Ticket', '', 'ticket', 'open', 'C', 'A');
INSERT INTO `page_list` VALUES ('BQ', 'New Ticket', 'Ticket', '', 'ticket', 'open', 'C', 'A');
INSERT INTO `page_list` VALUES ('BR', 'Other API Settings', '03. API Setting', 'admin', 'api-setting', 'api', 'A', 'A');
INSERT INTO `page_list` VALUES ('BS', 'Custom Field List', '02. Admin Setting', 'admin', 'custom-field', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('BT', 'New Custom Field', '02. Admin Setting', 'admin', 'custom-field', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('BU', 'Edit Custom Field', '02. Admin Setting', 'admin', 'custom-field', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('BV', 'Modify', '03. API Setting', 'admin', 'api-setting-confirm', 'modify', 'A', 'S');
INSERT INTO `page_list` VALUES ('BW', 'Envato Setting', '03. API Setting', 'admin', 'api-setting', 'process-api', 'A', 'S');
INSERT INTO `page_list` VALUES ('BX', 'Status Change', '02. Admin Setting', 'admin', 'custom-field-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('BY', 'Api Check', 'Ticket', '', 'ticket', 'api-check', 'C', 'A');
INSERT INTO `page_list` VALUES ('BZ', 'Custom Field Delete', '02. Admin Setting', 'admin', 'custom-field-confirm', 'custom-field-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('CA', 'Category Delete', '12. Category', 'admin', 'category-confirm', 'category-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('CB', 'Index', 'Test', '', 'test', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('CC', 'Ticket Open By Guest', 'Ticket', '', 'ticket', 'opened', 'C', 'A');
INSERT INTO `page_list` VALUES ('CD', 'My Tickets', 'Panel', 'client', 'panel', 'dashboard', 'C', 'A');
INSERT INTO `page_list` VALUES ('CE', 'Ticket Tmp Img', 'Ticket', '', 'ticket', 'ticket-tmp-img', 'C', 'A');
INSERT INTO `page_list` VALUES ('CF', 'My Tickets', 'Panel', 'client', 'panel', 'profile', 'C', 'A');
INSERT INTO `page_list` VALUES ('CG', 'Active Ticket', 'Ticket', '', 'ticket', 'active-tickets', 'C', 'A');
INSERT INTO `page_list` VALUES ('CH', 'Close Ticket', 'Ticket', '', 'ticket', 'closed-tickets', 'C', 'A');
INSERT INTO `page_list` VALUES ('CI', 'Ticket Details', 'Ticket', '', 'ticket', 'details', 'C', 'A');
INSERT INTO `page_list` VALUES ('CJ', 'Ticket Img', 'Ticket', '', 'ticket', 'ticket-img', 'C', 'A');
INSERT INTO `page_list` VALUES ('CK', 'Field Deatils', 'Ticket', '', 'ticket', 'field-deatils', 'C', 'A');
INSERT INTO `page_list` VALUES ('CL', 'Field Details', 'Ticket', '', 'ticket', 'field-details', 'C', 'A');
INSERT INTO `page_list` VALUES ('CM', 'Ticket Reply', 'Ticket', '', 'ticket-confirm', 'ticket-reply', 'C', 'A');
INSERT INTO `page_list` VALUES ('CN', 'Re Open', 'Ticket', '', 'ticket', 're-open', 'C', 'A');
INSERT INTO `page_list` VALUES ('CO', 'Ticket Replied File', 'Ticket', '', 'ticket', 'ticket-replied-file', 'C', 'A');
INSERT INTO `page_list` VALUES ('CP', 'Edit Ticket', '10. Ticket', 'admin', 'ticket', 'edit', 'A', 'H');
INSERT INTO `page_list` VALUES ('CQ', 'Ticket Delete', '10. Ticket', 'admin', 'ticket-confirm', 'ticket-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('CR', 'Closed Ticket List', '10. Ticket', 'admin', 'ticket', 'closed-ticket', 'A', 'A');
INSERT INTO `page_list` VALUES ('CS', 'Assign Ticket', '10. Ticket', 'admin', 'ticket', 'set-assign', 'A', 'A');
INSERT INTO `page_list` VALUES ('CT', 'Assign Me', '10. Ticket', 'admin', 'ticket-confirm', 'assign-me', 'A', 'A');
INSERT INTO `page_list` VALUES ('CU', 'Paypal Settings', '03. API Setting', 'admin', 'api-setting', 'paypal-setting', 'A', 'A');
INSERT INTO `page_list` VALUES ('CV', 'Update Paypal', '03. API Setting', 'admin', 'api-setting-confirm', 'update-paypal', 'A', 'S');
INSERT INTO `page_list` VALUES ('CW', 'Social Settings', '03. API Setting', 'admin', 'api-setting', 'social-setting', 'A', 'A');
INSERT INTO `page_list` VALUES ('CX', 'Update Social', '03. API Setting', 'admin', 'api-setting-confirm', 'update-social', 'A', 'S');
INSERT INTO `page_list` VALUES ('CY', 'Email To Ticket Settings', '02. Admin Setting', 'admin', 'admin-setting', 'imap', 'A', 'A');
INSERT INTO `page_list` VALUES ('CZ', 'Email To Ticket', 'Cron', 'autoscript', 'cron', 'email-to-ticket', 'C', 'A');
INSERT INTO `page_list` VALUES ('DA', 'Email Templates List', '02. Admin Setting', 'admin', 'email-templates', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('DB', 'Update Email Template', '02. Admin Setting', 'admin', 'email-templates', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('DC', 'Status Change', '02. Admin Setting', 'admin', 'email-templates-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('DD', 'User Ticket', 'Ticket', '', 'ticket', 'user-ticket', 'C', 'A');
INSERT INTO `page_list` VALUES ('DE', 'Guest Ticket', 'Ticket', '', 'ticket', 'guest-ticket', 'C', 'A');
INSERT INTO `page_list` VALUES ('DF', 'Email Outgoing Settings', '02. Admin Setting', 'admin', 'admin-setting', 'email-out-settings', 'A', 'A');
INSERT INTO `page_list` VALUES ('DG', 'Debug Log List', '07. App Information', 'admin', 'debug-log', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('DH', 'Details Debug Log', '07. App Information', 'admin', 'debug-log', 'view-dtls', 'A', 'A');
INSERT INTO `page_list` VALUES ('DI', 'Process', 'Cron', 'autoscript', 'cron', 'process', 'C', 'A');
INSERT INTO `page_list` VALUES ('DJ', 'Edit Client', '14. Client', 'admin', 'client', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('DK', 'Ticket Payment', 'Ticket', '', 'ticket', 'ticket-payment', 'C', 'A');
INSERT INTO `page_list` VALUES ('DL', 'Paypal Payment Process', 'Ticket', '', 'ticket', 'paypal-payment-process', 'C', 'A');
INSERT INTO `page_list` VALUES ('DM', 'System Update Process', '07. App Information', 'admin', 'system-update', 'update', 'A', 'H');
INSERT INTO `page_list` VALUES ('DN', 'Application Update Info', '07. App Information', 'admin', 'system-update', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('DO', 'License Details', '07. App Information', 'admin', 'License', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('DP', 'Enter License Info', '07. App Information', 'admin', 'license', 'update', 'A', 'S');
INSERT INTO `page_list` VALUES ('DQ', 'Remove License Button', '07. App Information', 'admin', 'license', 'remove', 'A', 'A');
INSERT INTO `page_list` VALUES ('DR', 'Ticket Details', '10. Ticket', 'admin', 'ticket', 'details', 'A', 'S');
INSERT INTO `page_list` VALUES ('DS', 'Ticket Reply', '10. Ticket', 'admin', 'ticket-confirm', 'ticket-reply', 'A', 'A');
INSERT INTO `page_list` VALUES ('DT', 'Knowledge List', 'Knowledge', '', 'knowledge', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('DU', 'Change Category', '10. Ticket', 'admin', 'ticket', 'change-category', 'A', 'S');
INSERT INTO `page_list` VALUES ('DV', 'Menu List', '02. Admin Setting', 'admin', 'menu', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('DW', 'New Menu', '02. Admin Setting', 'admin', 'menu', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('DX', 'Menu Status Change', '02. Admin Setting', 'admin', 'menu-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('DY', 'Edit Menu', '02. Admin Setting', 'admin', 'menu', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('DZ', 'Menu Delete', '02. Admin Setting', 'admin', 'menu-confirm', 'menu-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('EA', 'New Window Status Change', '02. Admin Setting', 'admin', 'menu-confirm', 'is-new-window-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('EB', 'Topbar Icon List', '02. Admin Setting', 'admin', 'topbar-icon', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('EC', 'New Topbar Icon', '02. Admin Setting', 'admin', 'topbar-icon', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('ED', 'Topbar Icon Delete', '02. Admin Setting', 'admin', 'topbar-icon-confirm', 'topbar-icon-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('EE', 'Topbar Icon Status Change', '02. Admin Setting', 'admin', 'topbar-icon-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('EF', 'Edit Topbar Icon', '02. Admin Setting', 'admin', 'topbar-icon', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('EG', 'Search', 'Site', '', 'site', 'search', 'C', 'A');
INSERT INTO `page_list` VALUES ('EH', 'Search Result', 'Knowledge', '', 'knowledge', 'search-result', 'C', 'A');
INSERT INTO `page_list` VALUES ('EI', 'IP List', '02. Admin Setting', 'admin', 'iplist', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('EJ', 'New IP Entry', '02. Admin Setting', 'admin', 'iplist', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('EK', 'Ipblock', 'App Secuity', '', 'App-secuity', 'ipblock', 'C', 'A');
INSERT INTO `page_list` VALUES ('EL', 'Support System', 'App Security', '', 'App-security', 'ipblock', 'C', 'A');
INSERT INTO `page_list` VALUES ('EM', 'Ipblock', 'Site Security', '', 'site-security', 'ipblock', 'C', 'A');
INSERT INTO `page_list` VALUES ('EN', 'My Ticket List', '10. Ticket', 'admin', 'ticket', 'my-ticket', 'A', 'S');
INSERT INTO `page_list` VALUES ('EO', 'My Closed Ticket', '10. Ticket', 'admin', 'ticket', 'my-closed', 'A', 'S');
INSERT INTO `page_list` VALUES ('EP', 'Security Settings', '02. Admin Setting', 'admin', 'admin-setting', 'security', 'A', 'A');
INSERT INTO `page_list` VALUES ('EQ', 'Modify Security', '02. Admin Setting', 'admin', 'admin-setting-confirm', 'modify-security', 'A', 'A');
INSERT INTO `page_list` VALUES ('ER', 'Locked User List', '02. Admin Setting', 'admin', 'locked-user', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('ES', 'Unlock Admin User', '02. Admin Setting', 'admin', 'locked-user-confirm', 'locked-user-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('ET', 'Edit IP', '02. Admin Setting', 'admin', 'iplist', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('EU', 'Block IP Reset', '02. Admin Setting', 'admin', 'iplist-confirm', 'iplist-reset', 'A', 'A');
INSERT INTO `page_list` VALUES ('EV', 'System Message Dismiss', '16.  System Message', 'admin', 'system-msg-confirm', 'system-msg-dismiss', 'A', 'A');
INSERT INTO `page_list` VALUES ('EW', 'Viewed', 'Notification', 'admin', 'notification', 'viewed', 'A', 'S');
INSERT INTO `page_list` VALUES ('EX', 'Announcements List', '09. Announcements', 'admin', 'notice', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('EY', 'New Announcements', '09. Announcements', 'admin', 'notice', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('EZ', 'Edit Announcements', '09. Announcements', 'admin', 'notice', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('FA', 'Admin Message List', '15. Message', 'admin', 'admin-message', 'index', 'A', 'S');
INSERT INTO `page_list` VALUES ('FB', 'New Admin Message', '15. Message', 'admin', 'admin-message', 'add', 'A', 'S');
INSERT INTO `page_list` VALUES ('FC', 'Sent Message By Me', '15. Message', 'admin', 'admin-message', 'sent', 'A', 'S');
INSERT INTO `page_list` VALUES ('FD', 'Edit Admin Message', '15. Message', 'admin', 'admin-message', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('FE', 'Announcements Status Change', '09. Announcements', 'admin', 'notice-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('FF', 'New Email Templates', '02. Admin Setting', 'admin', 'email-templates', 'add', 'A', 'H');
INSERT INTO `page_list` VALUES ('FG', 'Details', '15. Message', 'admin', 'admin-message', 'details', 'A', 'S');
INSERT INTO `page_list` VALUES ('FH', 'Reply', '15. Message', 'admin', 'admin-message-confirm', 'reply', 'A', 'S');
INSERT INTO `page_list` VALUES ('FI', 'Show', 'Notification', 'admin', 'notification', 'show', 'A', 'S');
INSERT INTO `page_list` VALUES ('FJ', 'Notification List', 'Notification', 'admin', 'notification', 'show-list', 'A', 'S');
INSERT INTO `page_list` VALUES ('FK', 'Change User Status', '05. User Settings', 'admin', 'app-permission-confirm', 'change-user-status', 'A', 'A');
INSERT INTO `page_list` VALUES ('FL', 'Reset User Pass', '05. User Settings', 'admin', 'app-permission-confirm', 'reset-user-pass', 'A', 'A');
INSERT INTO `page_list` VALUES ('FM', 'Application Update Process', '07. App Information', 'admin', 'system-update', 'process-update', 'A', 'A');
INSERT INTO `page_list` VALUES ('FN', 'System Updating', '07. App Information', 'admin', 'system-update', 'updating', 'A', 'S');
INSERT INTO `page_list` VALUES ('FO', 'Test', '07. App Information', 'admin', 'system-update', 'test', 'A', 'H');
INSERT INTO `page_list` VALUES ('FP', 'Feedback', 'Ticket', '', 'ticket', 'feedback', 'C', 'A');
INSERT INTO `page_list` VALUES ('FQ', 'Re Open', '10. Ticket', 'admin', 'ticket', 're-open', 'A', 'A');
INSERT INTO `page_list` VALUES ('FR', 'Knowledge List', 'Category', '', 'category', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('FS', 'Not Found', 'Category', '', 'category', 'details', 'C', 'A');
INSERT INTO `page_list` VALUES ('FT', 'Theme Settings', '02. Admin Setting', 'admin', 'admin-setting', 'theme', 'A', 'A');
INSERT INTO `page_list` VALUES ('FU', 'Modify Theme', '02. Admin Setting', 'admin', 'admin-setting-confirm', 'modify-theme', 'A', 'A');
INSERT INTO `page_list` VALUES ('FV', 'Upload', 'Image Upload', 'admin', 'image-upload', 'upload', 'A', 'S');
INSERT INTO `page_list` VALUES ('FW', 'Manager', 'Image Upload', 'admin', 'image-upload', 'manager', 'A', 'S');
INSERT INTO `page_list` VALUES ('FX', 'Delete', 'Image Upload', 'admin', 'image-upload', 'delete', 'A', 'S');
INSERT INTO `page_list` VALUES ('FY', 'Delete Feature', '11. Knowledge', 'admin', 'knowledge-confirm', 'delete-feature', 'A', 'S');
INSERT INTO `page_list` VALUES ('FZ', 'My Paid Ticket', '10. Ticket', 'admin', 'ticket', 'my-paid-ticket', 'A', 'S');
INSERT INTO `page_list` VALUES ('GA', 'All Paid Ticket', '10. Ticket', 'admin', 'ticket', 'all-paid-ticket', 'A', 'A');
INSERT INTO `page_list` VALUES ('GB', 'My Assigned All Tickets', '10. Ticket', 'admin', 'ticket', 'my-assigned-ticket', 'A', 'A');
INSERT INTO `page_list` VALUES ('GC', 'Server Requirment Failed', 'Server Requiment', '', 'server-requiment', 'index', 'C', 'A');
INSERT INTO `page_list` VALUES ('GD', 'Resource Missmatch', 'Server Requiment', '', 'server-requiment', 'resource-missmatch', 'C', 'A');
INSERT INTO `page_list` VALUES ('GE', 'Change Timezone', '08. My Dashboard', 'admin', 'dashboard', 'set-timezone', 'A', 'S');
INSERT INTO `page_list` VALUES ('GF', 'Canned Msg List', '13. Canned Msg', 'admin', 'canned-msg', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('GG', 'New Canned Msg', '13. Canned Msg', 'admin', 'canned-msg', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('GH', 'Edit Canned Message', '13. Canned Msg', 'admin', 'canned-msg', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('GI', 'Canned Msg Delete', '13. Canned Msg', 'admin', 'canned-msg-confirm', 'canned-msg-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('GJ', 'Admin Dashboard', '01. Admin Report', 'admin', 'admin-report', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('GK', 'All Unassigned All Tickets', '10. Ticket', 'admin', 'ticket', 'unassigned-ticket', 'A', 'A');
INSERT INTO `page_list` VALUES ('GL', 'Ticket Payment List', '04. Payment List', 'admin', 'ticket-payment', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('GM', 'Ticket Payment Details', '04. Payment List', 'admin', 'ticket-payment', 'details', 'A', 'A');
INSERT INTO `page_list` VALUES ('GN', 'Ticket Feedback List', '06. Ticket Feedback', 'admin', 'ticket-feedback', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('GO', 'Details Info Of IP', '02. Admin Setting', 'admin', 'iplist', 'detials', 'A', 'S');
INSERT INTO `page_list` VALUES ('GP', 'Sort Menu', '05. User Settings', 'admin', 'app-permission', 'sort-controller-title', 'A', 'H');
INSERT INTO `page_list` VALUES ('GQ', 'Copy Role Access', '05. User Settings', 'admin', 'app-permission', 'copy-access', 'A', 'A');
INSERT INTO `page_list` VALUES ('GR', 'Reset Role Access', '05. User Settings', 'admin', 'app-permission', 'reset-access', 'A', 'A');
INSERT INTO `page_list` VALUES ('GS', 'Ticket Replied File', 'Ticket', 'admin', 'ticket', 'ticket-replied-file', 'A', 'S');
INSERT INTO `page_list` VALUES ('GT', 'Is Stickey/Pinned Status Change', '11. Knowledge', 'admin', 'knowledge-confirm', 'is-stickey-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('GU', 'Re Check', 'System Update', 'admin', 'system-update', 're-check', 'A', 'S');
INSERT INTO `page_list` VALUES ('GV', 'Status Change', '13. Canned Msg', 'admin', 'canned-msg-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('GW', 'Admin Notification Settings', '02. Admin Setting', 'admin', 'admin-setting', 'notification', 'A', 'A');
INSERT INTO `page_list` VALUES ('GX', 'Modify Notification', 'Admin Setting Confirm', 'admin', 'admin-setting-confirm', 'modify-notification', 'A', 'S');
INSERT INTO `page_list` VALUES ('GY', 'Notification', 'Dashboard', 'admin', 'dashboard', 'notification', 'A', 'S');
INSERT INTO `page_list` VALUES ('HF', 'Client Profile', 'Client', 'admin', 'client', 'profile', 'A', 'S');
INSERT INTO `page_list` VALUES ('HG', 'Ticket Img', 'Ticket', 'admin', 'ticket', 'ticket-img', 'A', 'S');
INSERT INTO `page_list` VALUES ('HN', 'Set User Password', '05. User Settings', 'admin', 'app-permission', 'set-user-pass', 'A', 'S');
INSERT INTO `page_list` VALUES ('HO', 'WebChat Panel', '17. Web Chat', 'admin', 'admin-chat', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('HP', 'Chat Response', '17. Web Chat', 'admin', 'admin-chat', 'chat-response', 'A', 'S');
INSERT INTO `page_list` VALUES ('HQ', 'User Chat Close', '17. Web Chat', 'admin', 'admin-chat-confirm', 'user-chat-close', 'A', 'S');
INSERT INTO `page_list` VALUES ('HR', 'User Answer', '17. Web Chat', 'admin', 'admin-chat-confirm', 'user-answer', 'A', 'S');
INSERT INTO `page_list` VALUES ('HS', 'Edit Chat Canned Message', '17. Web Chat', 'admin', 'chat-canned-msg', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('HT', 'New Chat Canned Msg', '17. Web Chat', 'admin', 'chat-canned-msg', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('HU', 'Chat Canned Msg List', '17. Web Chat', 'admin', 'chat-canned-msg', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('HV', 'New Admin Note', 'Admin Note', 'admin', 'admin-note', 'add', 'A', 'S');
INSERT INTO `page_list` VALUES ('HW', 'Get Notes', 'Admin Note', 'admin', 'admin-note', 'get-notes', 'A', 'S');
INSERT INTO `page_list` VALUES ('HX', 'Chat Settings', '02. Admin Setting', 'admin', 'admin-setting', 'webchat-settings', 'A', 'A');
INSERT INTO `page_list` VALUES ('HY', 'Reset User Pass', '14. Client', 'admin', 'client-confirm', 'reset-user-pass', 'A', 'A');
INSERT INTO `page_list` VALUES ('HZ', 'Update Chat Status', 'Dashboard', 'admin', 'dashboard', 'update-chat-status', 'A', 'S');
INSERT INTO `page_list` VALUES ('IA', 'Update Notification Trey', 'Dashboard', 'admin', 'dashboard', 'update-notification-trey', 'A', 'S');
INSERT INTO `page_list` VALUES ('IB', 'Delete Attach File', '11. Knowledge', 'admin', 'knowledge-confirm', 'del-attach-file', 'A', 'A');
INSERT INTO `page_list` VALUES ('IC', 'Edit Ticket Reply', '10. Ticket', 'admin', 'ticket', 'edit-reply', 'A', 'S');
INSERT INTO `page_list` VALUES ('ID', 'Load Ticket Reply', '10. Ticket', 'admin', 'ticket', 'load-ticket-reply', 'A', 'S');
INSERT INTO `page_list` VALUES ('IE', 'Ticket Open By Admin', '10. Ticket', 'admin', 'ticket', 'opened', 'A', 'S');
INSERT INTO `page_list` VALUES ('IF', 'Admin Ticket Creation', '10. Ticket', 'admin', 'ticket', 'open', 'A', 'A');
INSERT INTO `page_list` VALUES ('IG', 'Ticket Assign Rule List', '17. Ticket Assign Rule', 'admin', 'ticket-assign-rule', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('IH', 'Edit Ticket Assign Rule', '17. Ticket Assign Rule', 'admin', 'ticket-assign-rule', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('II', 'New Ticket Assign Rule', '17. Ticket Assign Rule', 'admin', 'ticket-assign-rule', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('IJ', '17. Ticket Assign Rule', '17. Ticket Assign Rule', 'admin', 'ticket-assign-rule-confirm', 'ticket-assign-rule-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('IK', 'Status Change', '17. Ticket Assign Rule', 'admin', 'ticket-assign-rule-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('IL', 'Rate It', 'System Update', 'admin', 'system-update', 'rate-it', 'A', 'S');
INSERT INTO `page_list` VALUES ('IM', 'Rate Status', 'System Update', 'admin', 'system-update', 'rate-status', 'A', 'S');
INSERT INTO `page_list` VALUES ('IN', 'Please Rate It !!', 'System Update', 'admin', 'system-update', 'thank-you', 'A', 'S');
INSERT INTO `page_list` VALUES ('IO', 'Remote Login List', '03. API Setting', 'admin', 'remote-server', 'index', 'A', 'A');
INSERT INTO `page_list` VALUES ('IP', 'New Remote Login', '03. API Setting', 'admin', 'remote-server', 'add', 'A', 'A');
INSERT INTO `page_list` VALUES ('IQ', 'Edit Remote Login', '03. API Setting', 'admin', 'remote-server', 'edit', 'A', 'A');
INSERT INTO `page_list` VALUES ('IR', 'Delete Remote Login', '03. API Setting', 'admin', 'remote-server-confirm', 'remote-server-delete', 'A', 'A');
INSERT INTO `page_list` VALUES ('IS', 'Remote Login Status Change', '03. API Setting', 'admin', 'remote-server-confirm', 'status-change', 'A', 'A');
INSERT INTO `page_list` VALUES ('JE', 'New Work Log', '10. Ticket', 'admin', 'work-log', 'add', 'A', 'S');
INSERT INTO `page_list` VALUES ('JF', 'Get Notes', '10. Ticket', 'admin', 'work-log', 'get-notes', 'A', 'S');

-- ----------------------------
-- Table structure for payment_log
-- ----------------------------
DROP TABLE IF EXISTS `payment_log`;
CREATE TABLE `payment_log`  (
  `payment_id` char(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `ticket_payment_id` int(10) NOT NULL DEFAULT 0,
  `amount_cr` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `amount_dr` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `first_2_digit` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `last_4_digit` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `transaction_id` char(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `process_time` datetime(0) NOT NULL,
  `transaction_time` char(22) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `update_time` datetime(0) NOT NULL,
  `result` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `result_msg` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `note` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `response_reason` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `transation_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'A=Auth Capture, O=Auth Only, C= Refund Credit, V= Refund Void',
  `paid_by` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PP' COMMENT 'radio(PP=Paypal, AU=Authorize,ST=Stripe)',
  `pp_payer_email` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'Paypal payer email',
  `name_on_card` char(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `country` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `approval_code` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'Sale Id for PayPal',
  `ref_transaction_id` char(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'For refund Transaction',
  INDEX `merchant_id_customer_id`(`ticket_payment_id`) USING BTREE,
  INDEX `merchant_id_payment_id`(`payment_id`, `transaction_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of payment_log
-- ----------------------------

-- ----------------------------
-- Table structure for remote_server
-- ----------------------------
DROP TABLE IF EXISTS `remote_server`;
CREATE TABLE `remote_server`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `private_key` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `login_url` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'textarea',
  `valid_url` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'textarea',
  `button_text_color` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `button_color` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `button_txt` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `server_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'L' COMMENT 'radio(L=Login Server,F=Field Validation)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of remote_server
-- ----------------------------

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access`  (
  `pvid` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `role_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `res_id` char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'A=Allow, D=Deny',
  UNIQUE INDEX `pvid`(`pvid`, `role_id`, `res_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of role_access
-- ----------------------------
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AO', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AN', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AM', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AL', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AV', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AU', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AQ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AP', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GA', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'FQ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DS', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'BX', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DB', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DA', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'CT', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'CS', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'CR', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AR', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'FE', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EZ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EY', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EX', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'FM', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GN', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'AB', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'AK', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GM', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'AD', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GL', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EU', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'ET', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'ES', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'AC', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'AI', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'AB', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GJ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'ER', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EQ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EP', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EV', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'AR', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'CR', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'CS', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'CT', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'DS', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'FQ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GA', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GN', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GF', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GG', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GH', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GM', 'N');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GL', 'N');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DJ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'BI', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'BH', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GI', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GH', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GG', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GF', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'CA', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EJ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EI', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'EA', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DX', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DZ', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DY', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DW', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'DV', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'HO', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'HO', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R4', 'GB', 'Y');
INSERT INTO `role_access` VALUES ('AA', 'R3', 'GB', 'Y');

-- ----------------------------
-- Table structure for role_list
-- ----------------------------
DROP TABLE IF EXISTS `role_list`;
CREATE TABLE `role_list`  (
  `pv_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `role_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `title` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `grade` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '3' COMMENT '0=supper power, 1>2>3>4....',
  UNIQUE INDEX `pv_id`(`pv_id`, `role_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'app_permission,role' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of role_list
-- ----------------------------
INSERT INTO `role_list` VALUES ('AA', 'R1', 'Super Admin', '0');
INSERT INTO `role_list` VALUES ('AA', 'R3', 'Supervisor', '5');
INSERT INTO `role_list` VALUES ('AA', 'R4', 'Agent', '5');

-- ----------------------------
-- Table structure for sale_file
-- ----------------------------
DROP TABLE IF EXISTS `sale_file`;
CREATE TABLE `sale_file`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key_rand` char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `extn` char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `file_name` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `is_paid` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `amount` decimal(5, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `total_sold` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `hour_of_avaiable` int(3) UNSIGNED NOT NULL DEFAULT 0,
  `has_expiry` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'Y' COMMENT 'bool(Y=Yes,N=No)',
  `expiry_date` timestamp(0) NULL DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sale_file
-- ----------------------------

-- ----------------------------
-- Table structure for sale_file_payment_log
-- ----------------------------
DROP TABLE IF EXISTS `sale_file_payment_log`;
CREATE TABLE `sale_file_payment_log`  (
  `payment_id` char(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `file_id` int(11) NOT NULL DEFAULT 0,
  `amount_cr` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `amount_dr` decimal(5, 2) NOT NULL DEFAULT 0.00,
  `first_2_digit` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `last_4_digit` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `transaction_id` char(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `process_time` datetime(0) NOT NULL,
  `transaction_time` char(22) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `update_time` datetime(0) NOT NULL,
  `result` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `result_msg` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `note` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `response_reason` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `transation_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'A=Auth Capture, O=Auth Only, C= Refund Credit, V= Refund Void',
  `paid_by` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PP' COMMENT 'radio(PP=Paypal, AU=Authorize,ST=Stripe)',
  `pp_payer_email` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'Paypal payer email',
  `name_on_card` char(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `country` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `approval_code` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'Sale Id for PayPal',
  `ref_transaction_id` char(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'For refund Transaction',
  INDEX `merchant_id_customer_id`(`file_id`) USING BTREE,
  INDEX `merchant_id_payment_id`(`payment_id`, `transaction_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sale_file_payment_log
-- ----------------------------

-- ----------------------------
-- Table structure for sale_user_file
-- ----------------------------
DROP TABLE IF EXISTS `sale_user_file`;
CREATE TABLE `sale_user_file`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dl_key` char(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `payment_id` char(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `file_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `rand_key` char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `valid_until` timestamp(0) NULL DEFAULT NULL,
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sale_user_file
-- ----------------------------

-- ----------------------------
-- Table structure for site_user
-- ----------------------------
DROP TABLE IF EXISTS `site_user`;
CREATE TABLE `site_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `last_name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `username` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` char(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `pass` char(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `is_verified_email` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `gender` char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `phone` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `address` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `region` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `city` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `zip` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `country` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `dob` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'date of birth',
  `profile_url` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo_url` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `age` decimal(2, 0) NOT NULL DEFAULT 0,
  `login_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'radio(N=Normal,F=Facebook,T=Twitter,G=Google,L=Linked In)',
  `join_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `tzone` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `last_login_time` timestamp(0) NULL DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'drop(A=Active,I=Inactive,L=Locked)',
  `user_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'U' COMMENT 'radio(G=Guest,U=User)',
  `user_social_session_data` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'client' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of site_user
-- ----------------------------

-- ----------------------------
-- Table structure for site_user_custom_field
-- ----------------------------
DROP TABLE IF EXISTS `site_user_custom_field`;
CREATE TABLE `site_user_custom_field`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `custom_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `fld_title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fld_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'radio(T=Textbox,N=Numeric,D=Dropdown,A=Date,R=Radio)',
  `fld_value` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fld_value_text` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_api_based` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `api_name` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `api_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of site_user_custom_field
-- ----------------------------

-- ----------------------------
-- Table structure for system_msg
-- ----------------------------
DROP TABLE IF EXISTS `system_msg`;
CREATE TABLE `system_msg`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `msg` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `is_sup` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No);',
  `added_on` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `added_by` char(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `msg_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'S' COMMENT 'radio(D=Danger,W=Warning,S=Success)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'radio(A=Active,D=Dissmised)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 59 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of system_msg
-- ----------------------------
INSERT INTO `system_msg` VALUES (11, 'SERVER', 'This is title', 'This Is test', 'N', '2017-12-07 10:56:30', '', 'W', 'D');
INSERT INTO `system_msg` VALUES (12, 'SERVER', 'This is title', 'This Is test', 'N', '2017-12-07 10:58:05', '', 'S', 'D');
INSERT INTO `system_msg` VALUES (13, 'SERVER', 'This is title', 'This Is test', 'O', '2017-12-07 11:00:45', '', 'S', 'D');
INSERT INTO `system_msg` VALUES (55, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:48:37', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (32, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:47:38', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (33, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 22:39:23', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (34, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 22:44:21', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (35, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:00:22', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (36, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:26:26', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (37, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:28:11', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (38, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:30:01', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (39, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:30:50', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (40, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:32:06', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (41, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:35:56', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (42, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-08 23:36:43', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (43, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-09 00:40:28', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (49, 'SSM7', 'New Feature Release', 'Hosd kfjad fldkjfa ksdal ldkjf kjdlfjalsdjf ldjf jdfdsk fjdkjf ldjlf jsadf', 'O', '2017-12-09 18:11:23', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (47, 'SSM8', 'New Feature Release', 'this is a test Anal, thsiis si a adult. kjdsjflasd jlkum dslfjlsdfjldsf sd', 'O', '2017-12-09 18:07:22', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (51, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:38:25', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (52, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:41:22', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (53, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:44:23', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (54, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:46:14', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (56, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-10 09:48:49', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (57, 'UPDATE', 'App Update', 'New app update available, version :1.2, Please update this app. <a href=\"http://192.168.10.71/Projects/support-system/admin/system-update.html\" class=\"btn btn-success btn-xs\"><i class=\"fa fa-refresh\"></i> View Update Details</a>', 'O', '2017-12-13 10:05:55', 'AA', 'S', 'D');
INSERT INTO `system_msg` VALUES (58, 'imapc', 'Cron Job', 'Did you added this command (<b>wget --quiet -O /dev/null http://192.168.10.71/Projects/support-system/autoscript/cron/email-to-ticket.html</b>) into your server cron job list in a short interval?', 'Y', '2017-12-13 21:08:16', 'AA', 'W', 'D');

-- ----------------------------
-- Table structure for testimonial
-- ----------------------------
DROP TABLE IF EXISTS `testimonial`;
CREATE TABLE `testimonial`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `designation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `testimonial` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,B=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of testimonial
-- ----------------------------

-- ----------------------------
-- Table structure for ticket
-- ----------------------------
DROP TABLE IF EXISTS `ticket`;
CREATE TABLE `ticket`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_track_id` char(18) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cat_id` char(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `title` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ticket_body` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'textarea',
  `ticket_user` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `opened_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `re_open_time` timestamp(0) NULL DEFAULT NULL,
  `re_open_by` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `re_open_by_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'radio(A=Staff,U=Ticket User,G=Guest Ticke User)',
  `user_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'U' COMMENT 'radio(G=Guest,U=User,A=Staff)',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'drop(N=New,C=Closed,P=In Progress,R=Re-Open)',
  `assigned_on` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'FK(app_user,id,title)',
  `assigned_date` timestamp(0) NULL DEFAULT NULL,
  `last_replied_by` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'FK(app_user,id,title)',
  `last_replied_by_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'radio(G=Guest,U=User,A=Staff)',
  `last_reply_time` timestamp(0) NULL DEFAULT NULL,
  `ticket_rating` decimal(1, 0) UNSIGNED NOT NULL DEFAULT 0,
  `priroty` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'L' COMMENT 'drop(L=Low,M=Medium,H=High,U=Urgent)',
  `is_public` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `is_open_using_email` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `is_paid_ticket` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `reply_counter` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_user_seen_last_reply` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ticket_track_id`(`ticket_track_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_assign_rule
-- ----------------------------
DROP TABLE IF EXISTS `ticket_assign_rule`;
CREATE TABLE `ticket_assign_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_ids` char(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rule_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'radio(A=Assign,N=Notifiy)',
  `rule_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'bool(A=Active,I=Inactive)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ticket_assign_rule
-- ----------------------------
INSERT INTO `ticket_assign_rule` VALUES (1, '*', 'N', 'AA', 'A');

-- ----------------------------
-- Table structure for ticket_custom_field
-- ----------------------------
DROP TABLE IF EXISTS `ticket_custom_field`;
CREATE TABLE `ticket_custom_field`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `custom_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `fld_title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fld_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'T' COMMENT 'radio(T=Textbox,N=Numeric,D=Dropdown,A=Date,R=Radio)',
  `fld_value` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fld_value_text` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_api_based` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `api_name` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `api_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket_custom_field
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_feedback
-- ----------------------------
DROP TABLE IF EXISTS `ticket_feedback`;
CREATE TABLE `ticket_feedback`  (
  `ticket_id` int(10) NOT NULL,
  `f_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'P' COMMENT 'radio(P=Positive, N=Nagative)',
  `f_msg` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'textarea',
  PRIMARY KEY (`ticket_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ticket_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_log
-- ----------------------------
DROP TABLE IF EXISTS `ticket_log`;
CREATE TABLE `ticket_log`  (
  `ticket_id` int(11) NOT NULL DEFAULT 0,
  `log_id` int(11) NOT NULL DEFAULT 0,
  `log_by` char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `log_by_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'radio(A=Staff,U=Ticket User,G=Guest Ticke User)',
  `log_msg` char(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `ticket_status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'P' COMMENT 'drop(N=New,C=Closed,P=In Progress,R=Re-Open,W=Waiting For User)',
  `entry_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  UNIQUE INDEX `ticket_id`(`ticket_id`, `log_id`) USING BTREE,
  INDEX `ticket_id_2`(`ticket_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ticket_log
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_payment
-- ----------------------------
DROP TABLE IF EXISTS `ticket_payment`;
CREATE TABLE `ticket_payment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reply_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `amount` decimal(7, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `payment_currency` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'USD' COMMENT 'USD,EUR,GBP',
  `payment_des` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_id` char(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_by` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `refund_msg` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_method` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'P' COMMENT 'radio(P=PayPal,S=Stripe,A=Authorize)',
  `create_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `process_date` timestamp(0) NULL DEFAULT NULL,
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'P' COMMENT 'drop(P=Pending,A=Paid,F=Failed,R=Refunded)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket_payment
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_reply
-- ----------------------------
DROP TABLE IF EXISTS `ticket_reply`;
CREATE TABLE `ticket_reply`  (
  `ticket_id` int(11) NOT NULL DEFAULT 0,
  `reply_id` int(11) NOT NULL DEFAULT 0,
  `asigned_by` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'Ticket current asigned by',
  `replied_by` char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'FK(app_user,id,name)',
  `replied_by_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'radio(A=Staff,U=Ticket User,G=Guest Ticke User)',
  `reply_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'textarea',
  `reply_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  `ticket_status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'P' COMMENT 'drop(N=New,C=Closed,P=In Progress,R=Re-Open)',
  `is_private` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Y' COMMENT 'boot(Y=Yes,N=No)',
  `payment_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_user_seen` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N' COMMENT 'bool(Y=Yes,N=No)',
  `seen_time` timestamp(0) NULL DEFAULT NULL,
  UNIQUE INDEX `ticket_id`(`ticket_id`, `reply_id`) USING BTREE,
  INDEX `ticket_id_2`(`ticket_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket_reply
-- ----------------------------

-- ----------------------------
-- Table structure for topbar_icon
-- ----------------------------
DROP TABLE IF EXISTS `topbar_icon`;
CREATE TABLE `topbar_icon`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `sub_title` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon_class` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon_order` int(2) UNSIGNED NOT NULL DEFAULT 0,
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y' COMMENT 'bool(Y=Yes,N=No)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of topbar_icon
-- ----------------------------
INSERT INTO `topbar_icon` VALUES (1, '24/7 Support', 'Call (347) XXX-XXXX', 'fa-phone', 1, 'Y');
INSERT INTO `topbar_icon` VALUES (2, 'Best Support', 'We are always best', 'fa-star-o', 2, 'Y');

-- ----------------------------
-- Table structure for user_online_log
-- ----------------------------
DROP TABLE IF EXISTS `user_online_log`;
CREATE TABLE `user_online_log`  (
  `user_id` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `u_type` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A',
  `last_time` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `u_type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of user_online_log
-- ----------------------------
INSERT INTO `user_online_log` VALUES ('AA', 'A', '2018-07-18 09:22:52');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `pvid` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `role_id` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `title` char(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'A' COMMENT 'A=Active, I=Inactive',
  UNIQUE INDEX `pvid`(`pvid`, `role_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of user_role
-- ----------------------------

-- ----------------------------
-- Table structure for work_log
-- ----------------------------
DROP TABLE IF EXISTS `work_log`;
CREATE TABLE `work_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `note` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `w_time` decimal(4, 0) UNSIGNED NOT NULL DEFAULT 0,
  `entry_date` timestamp(0) NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;
