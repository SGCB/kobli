#!/usr/bin/perl

# Copyright 2013 Spanish Ministry of Education, Culture and Sport
#
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use Modern::Perl;

use C4::Context;

# This is a new style cataloging plugin, using $building_plugin

our $building_plugin;
if(defined $building_plugin) {
    marc21_field001_plugin_javascript();
}
else { #nothing to do (no popup)
}

#-------------------------------------------------------------------------------

sub marc21_field001_plugin_javascript {
    my $field_number= $building_plugin->{subfieldid};
    my $function_name= $field_number;

    #depending on preference, adjust Focus function
    my $autoControlNumber = C4::Context->preference('autoControlNumber');
    my $focusline='';
    if( $autoControlNumber ne 'OFF' ) {
        $focusline= "document.getElementById(\"$field_number\").value='$autoControlNumber';\n";
    }
    $focusline.='return 1;';

    #build the actual javascript
    my $res = "
<script type=\"text/javascript\">
//<![CDATA[
oldValue = document.getElementById(\"$field_number\").value;
function Blur$function_name(subfield_managed) {
    if(oldValue != document.getElementById(\"$field_number\").value){
        $focusline
    }
    return 1;
}
function Focus$function_name(subfield_managed) {
    if(!document.getElementById(\"$field_number\").value){
        $focusline
    }
    return 1;
}
function Clic$function_name(index) {
    $focusline
}
//]]>
</script>
";

    #return to caller via global hash
    $building_plugin->{function}= $function_name;
    $building_plugin->{javascript}= $res;
}

1;
