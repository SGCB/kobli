[% UNLESS ( no_add ) %] <div id="toolbar">
 <script type="text/javascript">
	//<![CDATA[

	// prepare DOM for YUI Toolbar

	 $(document).ready(function() {
[% IF ( AddPatronLists_categorycode ) %]
[% ELSE %]
	 	$("#addchild").parent().remove();
		$("#addprofessional").parent().remove();
		$("#addorganisation").parent().remove();
		$("#addstaff").parent().remove();
		$("#addstatistical").parent().remove();
[% END %]
	    $("#newmenuc").empty();
	    yuiToolbar();
	 });

	// YUI Toolbar Functions

	function yuiToolbar() {

		var newmenu = [
[% IF ( AddPatronLists_categorycode ) %]
[% FOREACH categorie IN categories %]
{ text: "[% categorie.description %]",  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;categorycode=[% categorie.categorycode %]" },
[% END %]
[% ELSE %]
            { text: _("Socio adulto"),  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=A" },
            { text: _("Socio infantil"),  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=C" },
            { text: _("Socio profesional"),  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=P" },
			{ text: _("Institución"),  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=I" },
			{ text: _("Administrativo"),  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=S" },
			{ text: _("Estadístico"),  url: "/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=X" },
[% END %]
		]

	    new YAHOO.widget.Button({
	        type: "menu",
	        label: _("Nuevo socio "),
	        name: "newmenubutton",
	        menu: newmenu,
	        container: "newmenuc"
	    });

	}

	//]]>
	</script>
 <ul class="toolbar">
 <li id="newmenuc">
 <form action="/cgi-bin/koha/members/memberentry.pl" method="get">
 <input type="hidden" name="op" value="add" />
 <label for="newcategorycode">Nuevo socio: </label><select name="categorycode" id="newcategorycode">
 [% IF ( AddPatronLists_categorycode ) %] [% FOREACH categorie IN categories %]<option value="[% categorie.categorycode %]">[% categorie.description %]</option>[% END %] [% ELSE %] <option value="A">Socio adulto</option>
 <option value="C">Socio infantil</option>
 <option value="P">Socio profesional</option>
 <option value="I">Institución</option>
 <option value="S">Administrativo</option>
 <option value="X">Estadístico</option>
 [% END %] </select>
 <input value="Ir" type="submit" class="submit" />
 </form>
 </li>
</ul>
</div>
[% END %]