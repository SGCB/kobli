<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="[% IF ( IntranetFavicon ) %][% IntranetFavicon %][% ELSE %][% interface %]/[% theme %]/img/favicon.ico[% END %]" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="[% interface %]/lib/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="[% interface %]/lib/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" media="print" href="[% themelang %]/css/print.css" />
[% INCLUDE intranetstylesheet.inc %] [% IF ( bidi ) %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/right-to-left.css" />
[% END %] [% IF ( IntranetUserCSS ) %]<style type="text/css">[% IntranetUserCSS %]</style>[% END %] <script type="text/javascript" src="[% interface %]/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.hotkeys.min.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.cookie.min.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.highlight-3.js"></script>
<script type="text/javascript" src="[% themelang %]/lib/jquery/plugins/jquery.qtip.js"></script>
<script type="text/javascript" src="[% interface %]/lib/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.validate.min.js"></script>

[% IF ( login ) %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/login.css" />
[% END %]

<!-- koha core js -->
<script type="text/javascript" src="[% themelang %]/js/staff-global.js"></script>
[% INCLUDE 'validator-strings.inc' %] [% IF ( intranetuserjs ) %] <script type="text/javascript">
    //<![CDATA[
    [% intranetuserjs %]
    //]]>
    </script>
[% END %] [% IF ( virtualshelves || intranetbookbag ) %] <script type="text/javascript">
    //<![CDATA[
        var MSG_BASKET_EMPTY = _("Su cesta está vacía");
        var MSG_RECORD_IN_BASKET = _("Este ítem ya está en su cesta");
        var MSG_RECORD_ADDED = _("Este ítem ha sido añadido a su cesta");
        var MSG_NRECORDS_ADDED = _(" ítem(s) incluidos en su bolsa");
        var MSG_NRECORDS_IN_BASKET = _("ya en su cesta");
        var MSG_NO_RECORD_SELECTED = _("Ningún ítem fue seleccionado");
        var MSG_NO_RECORD_ADDED = _("Ningún ítem ha sido agregado a su cesta");
        var MSG_CONFIRM_DEL_BASKET = _("¿Está seguro de querer vaciar su cesta?");
        var MSG_CONFIRM_DEL_RECORDS = _("¿Está seguro de querer eliminar los ítems seleccionados?");
        var MSG_IN_YOUR_CART = _("Items en su cesta:");
        var MSG_NON_RESERVES_SELECTED = _("Uno o más ítems seleccionados no se pueden reservar.");
    //]]>
    </script>
<script type="text/javascript" src="[% themelang %]/js/basket.js"></script>
[% END %] [% IF LocalCoverImages %] <script type="text/javascript" src="[% themelang %]/js/localcovers.js"></script>
<script type="text/javascript">
//<![CDATA[
var NO_LOCAL_JACKET = _("No hay imagen de cubierta disponible ");
//]]>
</script>
[% END %] 