<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     modifier.format_field.php
 * Type:     modifier
 * Name:     format_field
 * Purpose:  format database field names for input labels
 * -------------------------------------------------------------
 */
function smarty_modifier_format_field($string) {
    return ucwords(str_replace('_', ' ', $string));
}