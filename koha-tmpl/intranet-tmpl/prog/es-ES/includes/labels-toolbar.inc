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
                {text: _("Manage layouts"), url: "/cgi-bin/koha/labels/label-manage.pl?label_element=layout" },
                {text: _("New layout"), url: "/cgi-bin/koha/labels/label-edit-layout.pl?op=new" }
        ];

        var templates = [
                {text: _("Manage templates"), url: "/cgi-bin/koha/labels/label-manage.pl?label_element=template" },
                {text: _("New template"), url: "/cgi-bin/koha/labels/label-edit-template.pl?op=new" }
        ];

        var profiles = [
                {text: _("Manage profiles"), url: "/cgi-bin/koha/labels/label-manage.pl?label_element=profile" },
                {text: _("Nuevo perfil"), url: "/cgi-bin/koha/labels/label-edit-profile.pl?op=new" }
        ];

        var batches = [
                {text: _("Manage batches"), url: "/cgi-bin/koha/labels/label-manage.pl?label_element=batch" },
                {text: _("New batch"), url: "/cgi-bin/koha/labels/label-edit-batch.pl?op=new" }
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
