<script type="text/javascript">
    //<![CDATA[
    // prepare DOM for YUI Toolbar
    $(document).ready(function() {
        $("#layoutsc").empty();
        $("#templatesc").empty();
        $("#profilesc").empty();
        $("#batches").empty();
        yuiToolbar();
     });

    // YUI Toolbar Functions
    function yuiToolbar() {
        var layouts = [
                {text: _("Administrar diseños"), url: "/cgi-bin/koha/patroncards/manage.pl?card_element=layout" },
                {text: _("Nuevo diseño"), url: "/cgi-bin/koha/patroncards/edit-layout.pl?op=new" }
        ];

        var templates = [
                {text: _("Administrar plantillas"), url: "/cgi-bin/koha/patroncards/manage.pl?card_element=template" },
                {text: _("Nueva plantilla"), url: "/cgi-bin/koha/patroncards/edit-template.pl?op=new" }
        ];

        var profiles = [
                {text: _("Administrar perfiles"), url: "/cgi-bin/koha/patroncards/manage.pl?card_element=profile" },
                {text: _("Nuevo perfil"), url: "/cgi-bin/koha/patroncards/edit-profile.pl?op=new" }
        ];

        var batches = [
                {text: _("Administrar lotes"), url: "/cgi-bin/koha/patroncards/manage.pl?card_element=batch" },
                {text: _("Nuevo lote"), url: "/cgi-bin/koha/patroncards/edit-batch.pl?op=new" }
        ];

        new YAHOO.widget.Button({
            type: "menu",
            label: _("Diseños"),
            name: "layouts",
            menu: layouts,
            container: "layoutsc"
        });

        new YAHOO.widget.Button({
            type: "menu",
            label: _("Plantillas"),
            name: "templates",
            menu: templates,
            container: "templatesc"
        });

        new YAHOO.widget.Button({
            type: "menu",
            label: _("Perfiles"),
            name: "profiles",
            menu: profiles,
            container: "profilesc"
        });

        new YAHOO.widget.Button({
            type: "menu",
            label: _("Lotes"),
            name: "batches",
            menu: batches,
            container: "batchesc"
        });
    }
//]]>
</script>
<div id="toolbar">
 <ul class="toolbar">
 <li id="layoutsc"><a id="layouts" href="#">Diseños</a></li>
 <li id="templatesc"><a id="templates" href="#">Plantillas</a></li>
 <li id="profilesc"><a id="profiles" href="#">Perfiles</a></li>
 <li id="batchesc"><a id="batches" href="#">Lotes</a></li>
 </ul>
</div>
