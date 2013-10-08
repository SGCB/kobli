[% IF ( CAN_user_circulate ) %][% IF ( CircAutocompl ) %]<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
    $( "#findborrower" ).autocomplete({
        source: "/cgi-bin/koha/circ/ysearch.pl",
        minLength: 3,
        select: function( event, ui ) {
            $( "#findborrower" ).val( ui.item.cardnumber );
            $("#patronsearch").submit();
            return false;
        }
    })
    .data( "autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( "<a>" + item.surname + ", " + item.firstname + " (" + item.cardnumber + ") <small>" + item.address + " " + item.city + " " + item.zipcode + " " + item.country + "</small></a>" )
        .appendTo( ul );
    };

});
//]]>
</script>[% END %] <div id="circ_search" class="residentsearch">
 <p class="tip">Inserte el número de carnet del usuario o parte de su apellido</p>
 <form action="/cgi-bin/koha/circ/circulation.pl" id="patronsearch" method="post">
 [% IF ( CircAutocompl ) %] <div class="autocomplete">
 <input autocomplete="off" id="findborrower" name="findborrower" size="40" class="focus" type="text" /> <input value="Enviar" id="autocsubmit" type="submit" class="submit" />
 <input name="branch" value="[% branch %]" type="hidden" />
 <input name="printer" value="" type="hidden" />
 [% IF ( stickyduedate ) %] <input type="hidden" name="duedatespec" value="[% duedatespec %]" />
 <input type="hidden" name="stickyduedate" value="[% stickyduedate %]" />
 [% END %] </div>
 [% ELSE %] <input id="findborrower" name="findborrower" size="40" class="focus" type="text" />
 <input name="branch" value="[% branch %]" type="hidden" />
 <input name="printer" value="" type="hidden" />
 [% IF ( stickyduedate ) %] <input type="hidden" name="duedatespec" value="[% duedatespec %]" />
 <input type="hidden" name="stickyduedate" value="[% stickyduedate %]" />
 [% END %] <input value="Enviar" class="submit" type="submit" />
 [% END %] </form>
 </div>
 [% END %] 