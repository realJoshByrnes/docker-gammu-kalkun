<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

$active_group = "default";
$active_record = TRUE;

$db['default']['hostname'] = "kalkun-db";

// MySQL
$db['default']['username'] = "kalkun";
$db['default']['password'] = "kalkun";
$db['default']['database'] = "kalkun";
$db['default']['dbdriver'] = "mysqli";

$db['default']['dbprefix'] = "";
$db['default']['pconnect'] = FALSE;
$db['default']['db_debug'] = TRUE;
$db['default']['cache_on'] = FALSE;
$db['default']['cachedir'] = "";
$db['default']['char_set'] = "utf8";
$db['default']['dbcollat'] = "utf8_general_ci";

/* End of file database.php */
/* Location: ./application/config/database.php */