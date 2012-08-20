<div id="toolbar"><script type="text/javascript">
	//<![CDATA[

	// prepare DOM for YUI Toolbar
	 $(document).ready(function() {
            $("#periods_menuc").empty();
            $("#budgets_menuc").empty();
            $("#planning_menuc").empty();

	    yuiToolbar();
	 });

	// YUI Toolbar Functions
	function yuiToolbar() {   
                var periods_menu = [
                        { text: _("Mostrar todos los presupuestos raíz"), url: "/cgi-bin/koha/admin/aqbudgetperiods.pl" },
                        { text: _("Nuevo presupuesto raíz"), url: "/cgi-bin/koha/admin/aqbudgetperiods.pl?op=add_form" },
                        { text: _("Duplicar el presupuesto raíz"),  },
                ]
            new YAHOO.widget.Button({
                type: "menu",
                label: _("Presupuesto raiz"),
                name: "periods_button",
                menu: periods_menu,
                container: "periods_menuc"
            });  
	}

	//]]>
	</script>
 <ul class="toolbar">
 <li id="periods_menuc"><a id="periods_menu" href="/cgi-bin/koha/admin/aqbudgetperiods.pl?op=add_form">Presupuestos</a></li> 
 <li id="budgets_menuc"><a id="budgets_menu" href="/cgi-bin/koha/cataloguing/aqbudgets.pl">Fondos</a></li> 
 <li id="planning_menuc"><a id="planning_menu" href="/cgi-bin/koha/admin/aqplan.pl?budget_period_id=[% budget_period_id %]">Planificación de presupuesto</a></li> 

</ul>
</div>
