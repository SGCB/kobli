<div id="toolbar">
 <script type="text/javascript">
	//<![CDATA[

function confirm_deletion() {
    var is_confirmed = window.confirm(_('¿Estás seguro de que quieres eliminar este socio? Esta operación es irreversible.'));
    if (is_confirmed) {
            window.location='/cgi-bin/koha/members/deletemem.pl?member=[% borrowernumber %]';
    }
}
function confirm_updatechild() {
    var is_confirmed = window.confirm(_('¿Estás seguro de que quieres actualizar este niño a categoría de adulto? Esta operación es irreversible.'));

    if (is_confirmed) {
            window.location='/cgi-bin/koha/members/update-child.pl?op=update&borrowernumber=[% borrowernumber %]&catcode=[% catcode %]&catcode_multi=[% CATCODE_MULTI %]';
    }
}

function confirm_reregistration() {
    var is_confirmed = window.confirm(_('¿Estás seguro de que quieres renovar el registro de este socio?'));
    if (is_confirmed) {
    window.location='/cgi-bin/koha/members/moremember.pl?reregistration=y&borrowernumber=[% borrowernumber %]';
    }
}

function update_child() {
[% IF ( CATCODE_MULTI ) %]
 window.open('update-child.pl?op=multi&borrowernumber=[% borrowernumber %]','UpdateChild','width=400,height=300,toolbar=no,scrollbars=yes,resizable=yes');
[% ELSE %]
 confirm_updatechild();
[% END %]
}

	// prepare DOM for YUI Toolbar

	 $(document).ready(function() {
	    $("#printslip,#patronflags,#deletepatron").parent().remove();
		$("#moremenuc,#printmenuc,#searchtoholdc").empty();
	    yuiToolbar();
	 });

	// YUI Toolbar Functions
	function printx_window(print_type) {
		window.open("/cgi-bin/koha/members/moremember.pl?borrowernumber=[% borrowernumber %]&amp;print=" + print_type, "printwindow");
		return false;
	}
	function searchToHold(){
		var date = new Date();
		date.setTime(date.getTime() + (10 * 60 * 1000));
	    $.cookie("holdfor", "[% borrowernumber %]", { path: "/", expires: date });
	    location.href="/cgi-bin/koha/catalogue/search.pl";
	}
	function yuiToolbar() {
	    var printmenu = [
            { text: _("Print summary"), onclick: {fn: function(){printx_window("page")}} },
            { text: _("Print slip"), onclick: {fn: function(){printx_window("slip")}} },
            { text: _("Print quick slip"), onclick: {fn: function(){printx_window("qslip")}} }
	    ];

		var moremenu = [
            { text: _("Renew patron"),  onclick: { fn: confirm_reregistration } },
            { text: _("Set permissions"), url: "/cgi-bin/koha/members/member-flags.pl?member=[% borrowernumber %]"[% UNLESS ( CAN_user_permissions ) %], disabled: true[% END %]},
			{ text: _("Eliminar"), onclick: { fn: confirm_deletion}[% UNLESS ( CANDELETEUSER ) %], disabled: true[% END %] },
            { text: _("Update child to adult patron") , onclick: { fn: update_child }[% UNLESS ( is_child ) %], disabled: true[% END %]}
		];

	    new YAHOO.widget.Button({
	        type: "menu",
	        label: _("Imprimir"),
	        name: "printmenubutton",
	        menu: printmenu,
	        container: "printmenuc"
	    });

	    new YAHOO.widget.Button({
	        id: "searchtohold",
	        type: "button",
	        label: _("Buscar para reservar"),
	        container: "searchtoholdc",
			onclick: {fn: searchToHold }
		});

	    new YAHOO.widget.Button({
	        type: "menu",
	        label: _("Más"),
	        name: "moremenubutton",
	        menu: moremenu,
	        container: "moremenuc"
	    });

	    [% IF ( adultborrower ) %]new YAHOO.widget.Button("addchild");[% END %]
	    new YAHOO.widget.Button("editpatron");
	    new YAHOO.widget.Button("addnote");
            [% IF CAN_user_staffaccess %]new YAHOO.widget.Button("changepassword");  [% END %]
	    new YAHOO.widget.Button("duplicate");
	    new YAHOO.widget.Button("printslip");
		new YAHOO.widget.Button("printpage");
	}

	//]]>

	</script>
 <ul class="toolbar">
 [% IF ( category_type ) %]
 [% IF ( guarantor ) %]
 <li><a id="editpatron" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;borrowernumber=[% borrowernumber %]&amp;guarantorid=[% guarantorborrowernumber %]&amp;category_type=[% category_type %]">
 [% ELSE %]
 <li><a id="editpatron" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;borrowernumber=[% borrowernumber %]&amp;category_type=[% category_type %]">
 [% END %]Editar</a></li>
 [% ELSE %] <!-- try with categorycode if no category_type -->
 [% IF ( categorycode ) %]
 <li><a id="editpatron" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;borrowernumber=[% borrowernumber %]&amp;categorycode=[% categorycode %]">Editar</a></li>
 [% ELSE %] <!-- if no categorycode, set category_type to A by default -->
 <li><a id="editpatron" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;borrowernumber=[% borrowernumber %]&amp;category_type=A">Editar</a></li>
 [% END %]
 [% END %]
 [% IF ( adultborrower AND activeBorrowerRelationship ) %]<li><a id="addchild" href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;guarantorid=[% borrowernumber %]&amp;category_type=C">Agregar niño</a></li>[% END %]
 [% IF CAN_user_staffaccess %]<li><a id="changepassword" href="/cgi-bin/koha/members/member-password.pl?member=[% borrowernumber %]">Change password</a></li> [% END %]
 <li><a id="duplicate" href="/cgi-bin/koha/members/memberentry.pl?op=duplicate&amp;borrowernumber=[% borrowernumber %]&amp;category_type=[% category_type %]">Duplicado</a></li>
 <li id="printmenuc"><a id="printpage" href="/cgi-bin/koha/members/moremember.pl?borrowernumber=[% borrowernumber %]&amp;print=page">Print summary</a></li>
 <li><a id="printslip" href="/cgi-bin/koha/members/moremember.pl?borrowernumber=[% borrowernumber %]&amp;print=slip">Print slip</a></li>
 <li id="searchtoholdc"><a id="searchtohold" href="#">Buscar para reservar</a></li>
 <li id="moremenuc"><a id="renewpatron" href="/cgi-bin/koha/members/moremember.pl?reregistration=y&amp;borrowernumber=[% borrowernumber %]">Renew account</a></li>[% IF ( CAN_user_permissions ) %]<li><a id="patronflags" href="/cgi-bin/koha/members/member-flags.pl?member=[% borrowernumber %]">Set permissions</a></li>[% END %]<li><a id="deletepatron" href="javascript:confirm_deletion();">Eliminar</a></li>
</ul></div>
