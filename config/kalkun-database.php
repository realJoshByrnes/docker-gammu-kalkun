<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'kalkun_mysql';
$query_builder = TRUE;

$db['kalkun_mysql'] = array(
    'dsn' => '',
    'hostname' => 'kalkun-db',
    'username' => 'kalkun',
    'password' => 'kalkun',
    'database' => 'kalkun',
    'dbdriver' => 'mysqli',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8mb4',
    'dbcollat' => 'utf8mb4_general_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE
);