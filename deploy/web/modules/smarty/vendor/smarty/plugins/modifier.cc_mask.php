<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     modifier.cc_mask.php
 * Type:     modifier
 * Name:     cc_mask
 * Purpose:  mask credit card number
 * -------------------------------------------------------------
 */
function smarty_modifier_cc_mask($number) {
    return str_repeat("X", strlen($number) - 12) . substr($number, -4);
}