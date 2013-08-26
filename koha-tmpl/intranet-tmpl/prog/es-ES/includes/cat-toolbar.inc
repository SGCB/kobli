 <script type="text/javascript">
	//<![CDATA[
	[% IF ( CAN_user_editcatalogue_edit_catalogue ) %]
	/* this function open a popup to search on z3950 server.  */
	function PopupZ3950() {
		var strQuery = GetZ3950Terms();
		if(strQuery){
			window.open("/cgi-bin/koha/cataloguing/z3950_search.pl?biblionumber=[% biblionumber %]"+strQuery,"z3950search",'width=740,height=450,location=yes,toolbar=no,scrollbars=yes,resize=yes');
		} 
	}
    function PopupZ3950Confirmed() {
        if (confirm(_("Tenga en cuenta que esta búsqueda Z39.50 podría reemplazar el registro actual."))){
            PopupZ3950();
        }
    }

	/* provide Z3950 search points */
	function GetZ3950Terms(){
		var strQuery="&frameworkcode=";
		[% FOREACH z3950_search_param IN z3950_search_params %]
			strQuery += "&" + "[% z3950_search_param.name |html %]" + "=" + "[% z3950_search_param.encvalue |html %]";
		[% END %]
		return strQuery;
	}
	[% END %]
	function addToCart() { addRecord('[% biblionumber %]'); }
	function addToShelf() {	window.open('/cgi-bin/koha/virtualshelves/addbybiblionumber.pl?biblionumber=[% biblionumber %]','Add_to_virtualshelf','width=500,height=400,toolbar=false,scrollbars=yes');
	}
    function printBiblio() {window.print(); }
[% IF ( CAN_user_editcatalogue_edit_catalogue ) %]
    function confirm_deletion() {
        var count = [% count %];
        var holdcount = [% holdcount %];

        var is_confirmed;
	if (count > 0){
            is_confirmed = alert( count + " " +_("ítem(s) adjuntado(s) a este registro. Se deben borrar todos los ítems antes de borrarlo.") );
        } else if ( holdcount > 0 ) {
            is_confirmed = confirm( holdcount + " " + _("reservar(s) encontrada(s) en este registro. ¿Estás seguro de querer borrarlo?"));
        } else {
            is_confirmed = confirm(_("¿Está seguro de querer borrar este registro? "));
        }

        if (is_confirmed) {
            if ( count > 0 || holdcount > 0 ){
                return false;
            } else {
                window.location="/cgi-bin/koha/cataloguing/addbiblio.pl?op=delete&amp;biblionumber=[% biblionumber %]";
            }
	} else {
            return false;
	}
    }
[% END %]

[% IF ( CAN_user_editcatalogue_edit_items ) %]
    function confirm_items_deletion() {
        var count = [% count %];
        var holdcount = [% holdcount %];

        if ( holdcount > 0 ) {
            alert( holdcount + " " + _("reserva(s) en este registro. Se deben borrar todas las rservas antes de borrar los items.") );
        } else if ( count > 0 ) {
            if( confirm( _("¿Está seguro de querer borrar el") + " " + count + " " + _("Adjuntar ítems?") ) ) {
                window.location="/cgi-bin/koha/cataloguing/additem.pl?op=delallitems&amp;biblionumber=[% biblionumber %]";
            } else {
                return false;
            }
        } else {
            alert(_("Este registro no tiene ítems."));
            return false;
        }
    }
[% END %]
	 $(document).ready(function() {
        $("#z3950copy").click(function(){
            PopupZ3950();
            return false;
        });
        $("#deletebiblio").click(function(){
            confirm_deletion();
            return false;
        });
        $("#deleteallitems").click(function(){
            confirm_items_deletion();
            return false;
        });
        $("#printbiblio").click(function(){
            printBiblio();
            return false;
        });
        $("#addtocart").click(function(){
            addToCart();
            $(".btn-group").removeClass("open");
            return false;
        });
        $("#addtoshelf").click(function(){
            addToShelf();
            $(".btn-group").removeClass("open");
            return false;
        });
        $("#export").remove(); // Hide embedded export form if JS menus available
	 });
	//]]>
	</script>

<div id="toolbar" class="btn-toolbar">

<form method="post" name="f" id="f" action="/cgi-bin/koha/cataloguing/addbiblio.pl" onsubmit="return Check();">

[% IF ( CAN_user_editcatalogue_edit_catalogue || CAN_user_editcatalogue_edit_items || CAN_user_serials_create_subscription ) %] <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-plus"></i> Nuevo: <span class="caret"></span></button>
 <ul class="dropdown-menu">
 [% IF ( CAN_user_editcatalogue_edit_catalogue ) %] <li><a id="newbiblio" href="/cgi-bin/koha/cataloguing/addbiblio.pl">Nuevo registro</a></li>
 [% END %] [% IF ( CAN_user_editcatalogue_edit_items ) %] <li><a id="newitem" href="/cgi-bin/koha/cataloguing/additem.pl?biblionumber=[% biblionumber %]#additema">Nuevo ítem</a></li>
 [% END %] [% IF ( CAN_user_serials_create_subscription ) %] <li><a id="newsub" href="/cgi-bin/koha/serials/subscription-add.pl?biblionumber_for_new_subscription=[% biblionumber %]">Nueva suscripción</a></li>
 [% END %] [% IF ( EasyAnalyticalRecords && CAN_user_editcatalogue_edit_catalogue ) %] <li><a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=[% biblionumber %]&amp;analyze=1">Analizar ítems</a></li>
 [% END %] [% IF CAN_user_editcatalogue_edit_catalogue %] <li><a href="/cgi-bin/koha/cataloguing/addbiblio.pl?parentbiblionumber=[% biblionumber %]">Nuevo registro de infante</a></li>
 [% END %] </ul>
 </div>
[% END %] <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-pencil"></i> Editar <span class="caret"></span></button>
 <ul class="dropdown-menu">
 [% IF ( CAN_user_editcatalogue_edit_catalogue ) %] <li><a id="editbiblio" href="/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=[% biblionumber %]&amp;frameworkcode=[% current_framework %]&amp;op=">Editar registro</a></li>
 [% END %] [% IF ( CAN_user_editcatalogue_edit_items ) %] <li><a id="edititems" href="/cgi-bin/koha/cataloguing/additem.pl?biblionumber=[% biblionumber %]">Editar ítems</a></li>
 [% END %] [% IF ( CAN_user_tools_items_batchmod ) %]<li><a href="/cgi-bin/koha/tools/batchMod.pl?op=show&amp;biblionumber=[% biblionumber %]&amp;src=CATALOGUING">Editar ítems en un lote</a></li>[% END %] [% IF ( CAN_user_tools_items_batchdel ) %]<li><a href="/cgi-bin/koha/tools/batchMod.pl?del=1&amp;op=show&amp;biblionumber=[% biblionumber %]&amp;src=CATALOGUING">Borrar ítems en lote</a></li>[% END %] [% IF ( CAN_user_editcatalogue_edit_items ) %]<li><a href="/cgi-bin/koha/cataloguing/moveitem.pl?biblionumber=[% biblionumber %]">Adjuntar ítem</a></li>[% END %] [% IF ( EasyAnalyticalRecords ) %][% IF ( CAN_user_editcatalogue_edit_items ) %]<li><a href="/cgi-bin/koha/cataloguing/linkitem.pl?biblionumber=[% biblionumber %]">Enlace a ítem</a>[% END %][% END %] [% IF ( LocalCoverImages || OPACLocalCoverImages) %][% IF ( CAN_user_tools_upload_local_cover_images ) %]<li><a href="/cgi-bin/koha/tools/upload-cover-image.pl?biblionumber=[% biblionumber %]&amp;filetype=image">Cargar imagen</a>[% END %][% END %] [% IF ( CAN_user_editcatalogue_edit_catalogue ) %] <li><a id="duplicatebiblio" href="/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=[% biblionumber %]&amp;frameworkcode=[% current_framework %]&amp;op=duplicate">Editar como nuevo (duplicar)</a></li>
 <li><a href="#" id="z3950copy">Reemplazar registro vía Z39.50</a></li>

 [% IF ( count ) %]<li class="disabled">[% ELSE %]<li>[% END %] <a id="deletebiblio" href="/cgi-bin/koha/cataloguing/addbiblio.pl?op=delete&amp;biblionumber=[% biblionumber %]">Eliminar registro</a></li>
 [% END %] [% IF ( CAN_user_editcatalogue_edit_items ) %] [% UNLESS ( count ) %]<li class="disabled">[% ELSE %]<li>[% END %]<li>
 <a href="#" id="deleteallitems">Eliminar todos los ítems</a></li>
 [% END %] </ul>
 </div>

 <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-download-alt"></i> Guardar<span class="caret"></span></button>
 <ul class="dropdown-menu">
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=bibtex&amp;op=export&amp;bib=[% biblionumber %]">BIBTEX</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=dc&amp;op=export&amp;bib=[% biblionumber %]">Dublin Core (XML)</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=marcxml&amp;op=export&amp;bib=[% biblionumber %]">MARCXML</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=marc8&amp;op=export&amp;bib=[% biblionumber %]">MARC (non-Unicode/MARC-8)</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=utf8&amp;op=export&amp;bib=[% biblionumber %]">MARC (Unicode/UTF-8)</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=marcstd&amp;op=export&amp;bib=[% biblionumber %]">MARC (Unicode/UTF-8, Standard)</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=mods&amp;op=export&amp;bib=[% biblionumber %]">MODS (XML)</a></li>
 <li><a href="/cgi-bin/koha/catalogue/export.pl?format=ris&amp;op=export&amp;bib=[% biblionumber %]">RIS</a></li>
 </ul>
 </div>

[% IF ( virtualshelves && intranetbookbag ) %] <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown">Agregar a<span class="caret"></span></button>
 <ul class="dropdown-menu">
 <li><a href="#" id="addtocart">Cesta</a></li>
 <li><a id="addtoshelf" href="/cgi-bin/koha/virtualshelves/addbybiblionumber.pl?biblionumber=[% biblionumber %]">Lista</a></li>
 </ul>
 </div>
[% ELSIF ( virtualshelves ) %] <div class="btn-group"><a id="addtoshelf" class="btn btn-small" href="/cgi-bin/koha/virtualshelves/addbybiblionumber.pl?biblionumber=[% biblionumber %]"><i class="icon-list"></i> Agregar a una lista</a> </div>
[% ELSIF ( intranetbookbag ) %] <div class="btn-group"><a id="addtocart" class="btn btn-small"><i class="icon-shopping-cart"></i> Agregar a un carrito</a> </div>
[% END %] <div class="btn-group"><a id="printbiblio" class="btn btn-small"><i class="icon-print"></i> Imprimir</a></div>

[% IF ( CAN_user_reserveforothers ) %] [% UNLESS ( norequests ) %] [% IF ( holdfor ) %] <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown">
 <i class="icon-hold"></i>
 Reservar <span class="caret"></span>
 </button>
 <ul class="dropdown-menu">
 <li><a href="/cgi-bin/koha/reserve/request.pl?biblionumber=[% biblionumber %]">Hacer reserva</a></li>
 <li><a href="/cgi-bin/koha/reserve/request.pl?biblionumber=[% biblionumber %]&amp;findborrower=[% holdfor_cardnumber %]">Hacer reserva para [% holdfor_firstname %] [% holdfor_surname %] ([% holdfor_cardnumber %])</a></li>
 </ul>
 </div>
 [% ELSE %] <div class="btn-group"><a id="placehold" class="btn btn-small" href="/cgi-bin/koha/reserve/request.pl?biblionumber=[% biblionumber %]"><i class="icon-hold"></i> Hacer reserva</a></div>
 [% END %] [% END %] [% END %] </form>
</div>

