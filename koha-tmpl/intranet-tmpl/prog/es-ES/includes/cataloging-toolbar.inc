

<div id="toolbar">
<script type="text/javascript">
	//<![CDATA[

	// prepare DOM for YUI Toolbar

	 $(document).ready(function() {
	    $("#newmenuc").empty();
	    yuiToolbar();
        yuiZ3950button();
	 });

	// YUI Toolbar Functions

	function yuiToolbar() {
	
		var newmenu = [
			{ text: _("Plantilla predeterminada"), url: "/cgi-bin/koha/cataloguing/addbiblio.pl?frameworkcode=" },
			[% FOREACH frameworkcodeloo IN frameworkcodeloop %]{ text: "[% frameworkcodeloo.frameworktext %]", url: "/cgi-bin/koha/cataloguing/addbiblio.pl?frameworkcode=[% frameworkcodeloo.value %]"},
[% END %]
		]

	    new YAHOO.widget.Button({
	        type: "menu",
            label: _("Nuevo registro"),
	        name: "newmenubutton",
	        menu: newmenu,
	        container: "newmenuc"
	    });  
	}

    /* this function open a popup to search on z3950 server.  */
    function PopupZ3950() {
        var strQuery = GetZ3950Terms();
        if(strQuery){
            window.open("/cgi-bin/koha/cataloguing/z3950_search.pl?biblionumber=[% biblionumber %]"+strQuery,"z3950search",'width=760,height=450,location=yes,toolbar=no,scrollbars=yes,resize=yes');
        }
    }
    /* provide Z3950 search points */
    function GetZ3950Terms(){
        var strQuery="&frameworkcode=";
        [% FOREACH z3950_search_param IN z3950_search_params %]
            strQuery += "&" + "[% z3950_search_param.name %]" + "=" + "[% z3950_search_param.encvalue %]";
        [% END %]
        return strQuery;
    }
    /* prepare DOM for Z39.50 Search Button */
    function yuiZ3950button() {
        new YAHOO.widget.Button({
                id: "z3950search",
                type: "button",
                label: _("Búsqueda Z39.50"),
                container: "newmenuc",
                onclick: {fn:function(){PopupZ3950()}}
        });
    }
	//]]>
	</script>
 
 <div id="newmenuc">
 <form name="f" action="addbiblio.pl" method="post">
 <label for="frameworkcode">Nuevo registro con hoja de trabajo:</label>
 <select name="frameworkcode" id="frameworkcode">
 <option value="">Predeterminado</option>
 [% FOREACH frameworkcodeloo IN frameworkcodeloop %] <option value="[% frameworkcodeloo.value %]">
 [% frameworkcodeloo.frameworktext %] </option>
 [% END %] </select>
 <input value="Agregar registro sin buscar" type="submit" />
 </form>
 <a id="z3950search" onclick="PopupZ3950(); return false;">Búsqueda Z39.50</a>

 </div>
</div>
