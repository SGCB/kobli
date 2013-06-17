#!/usr/bin/perl

use strict;
use warnings;

use CGI;

#-------------------------------------------------------------------------------

# example of new cataloging plugin style without redefines
# if addbiblio calls this script, the global $building_plugin exists
# when copying this example, pick two new names to prevent redefining

our $building_plugin;
if(defined $building_plugin) {
    pass_script_for_myexample_plugin(); #TODO: pick a new name !
}
else {
    run_myexample_plugin(); #TODO: pick a new name !
}

#-------------------------------------------------------------------------------

sub pass_script_for_myexample_plugin { #TODO: pick a new name

    #via global $building_plugin, you receive three parameters:
    my $subfieldid = $building_plugin->{subfieldid};
    #uncomment following lines, if you need them
    #my $tabno = $building_plugin->{tabno};
    #my $oldrecord = $building_plugin->{record};

    #now return function name and javascript via global $building_plugin
    #your javascript normally contains a Blur, Clic and Focus function
    #call your plugin NO LONGER via plugin_launcher but directly
    #see also marc21_leader.pl
    my $function_name= $subfieldid; #valid choice, but may be different
    my $javascript=qq|
<script type=\"text/javascript\">
//<![CDATA[
function Focus$function_name(subfield_managed) {
    return 1;
}
function Blur$function_name(subfield_managed) {
    document.getElementById(\"$subfieldid\").value= '12345';
    return 1;
}
function Clic$function_name(i) {
    return 1;
}
//]]>
</script>
|;
#as you may be aware, this example just puts 12345 in your field and does not
#call a popup

    #FUNDAMENTAL: pass back via global hashref
    $building_plugin->{function}= $function_name;
    $building_plugin->{javascript}= $javascript;
}


#-------------------------------------------------------------------------------

sub run_myexample_plugin { #TODO: pick a new name !
    my $query=new CGI;

    #does nothing now
    #rest of your plugin script comes here
}

1;
