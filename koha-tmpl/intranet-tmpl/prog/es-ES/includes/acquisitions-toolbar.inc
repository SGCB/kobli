<div id="toolbar"><script type="text/javascript">
    //<![CDATA[

    // prepare DOM for YUI Toolbar

    $(document).ready(function() {
        yuiToolbar();
    });

    // YUI Toolbar Functions

    function yuiToolbar() {   
    
        new YAHOO.widget.Button("newperiod");
        new YAHOO.widget.Button("newbudget");
        new YAHOO.widget.Button("newsupplier");
        new YAHOO.widget.Button("newbasket");
        new YAHOO.widget.Button("editsupplier");
        new YAHOO.widget.Button("deletesupplier");
        new YAHOO.widget.Button("receive");
        new YAHOO.widget.Button("newcontract");
        new YAHOO.widget.Button("editcontracts");

        var manageorders = [
            [% IF ( CAN_user_acquisition_order_manage ) %]
              [% IF (active) %]
                { text: _("Nueva bolsa"), url: "/cgi-bin/koha/acqui/basketheader.pl?booksellerid=[% booksellerid %]&op=add_form"},
              [% END %]
                { text: _("Bolsas"), url: "/cgi-bin/koha/acqui/booksellers.pl?booksellerid=[% booksellerid %]"},
                { text: _("Bolsas de grupos"), url: "/cgi-bin/koha/acqui/basketgroup.pl?booksellerid=[% booksellerid %]"},
            [% END %]
            { text: _("Recibir envíos"), url: "/cgi-bin/koha/acqui/parcels.pl?booksellerid=[% booksellerid %]" },
            [% IF ( basketno ) %]
                { text: _("Precios inciertos"), url: "/cgi-bin/koha/acqui/uncertainprice.pl?booksellerid=[% booksellerid %]&basketno=[% basketno %]&owner=1"}
            [% ELSE %]
                { text: _("Precios inciertos"), url: "/cgi-bin/koha/acqui/uncertainprice.pl?booksellerid=[% booksellerid %]&owner=1"}
            [% END %]
        ]
        [% IF ( booksellerid ) %]
            [% IF ( basketcount ) %]
                new YAHOO.widget.Button({type: "menu", label: _("Administrar pedidos"), name: "manageorders", menu: manageorders, container: "toolbar-list"});
            [% END %]
        [% END %]
    }

    //]]>
    </script>
 <ul id="toolbar-list" class="toolbar">
 [% IF ( booksellerid ) %] [% IF ( CAN_user_acquisition_vendors_manage ) %] <li><a id="editsupplier" href="/cgi-bin/koha/acqui/supplier.pl?booksellerid=[% booksellerid %]&amp;op=enter">Editar</a></li>
 [% UNLESS ( basketcount OR subscriptioncount ) %] <li><a id="deletesupplier" href="javascript:confirm_deletion()">Eliminar</a></li>
 [% END %] <li><a id="newcontract" href="/cgi-bin/koha/admin/aqcontract.pl?op=add_form&amp;booksellerid=[% booksellerid %]">Nuevo contrato</a></li>
 <li><a id="editcontracts" href="/cgi-bin/koha/admin/aqcontract.pl?booksellerid=[% booksellerid %]">Contratos</a></li>
 [% IF (active && !basketcount) %] <li><a id="newbasket" href="/cgi-bin/koha/acqui/basketheader.pl?booksellerid=[% booksellerid %]&amp;op=add_form">Nueva bolsa</a></li>
 [% END %] [% END %] [% ELSE %] <li><a id="newbudget" href="/cgi-bin/koha/acqui/supplier.pl?op=enter">Nuevo proveedor</a></li>
 [% END %] </ul>
</div>
