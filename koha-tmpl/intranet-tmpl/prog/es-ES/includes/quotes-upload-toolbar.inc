<script type="text/javascript">
    var oSaveButton = '';
    var oDeleteButton = '';
    //<![CDATA[
    // prepare DOM for YUI Toolbar
    $(document).ready(function() {
        $("#save_quotes").empty();
        $("#delete_quote").empty();
        yuiToolbar();
     });

    // YUI Toolbar Functions
    function yuiGetData() {
        fnGetData(document.getElementById('quotes_editor'));
    }

    function yuiToolbar() {

        oSaveButton = new YAHOO.widget.Button({
            type: "button",
            label: _("Salvar comillas"),
            name: "save",
            container: "save_quotes",
        });

        oDeleteButton = new YAHOO.widget.Button({
            type: "button",
            label: _("Eliminar Comilla(s)"),
            name: "delete",
            container: "delete_quote",
        });
    }

//]]>
</script>
<div id="toolbar" style="visibility: hidden; position: absolute">
 <ul class="toolbar">
 <li id="save_quotes"><a id="save" href="#">Salvar comillas</a></li>
 <li id="delete_quote"><a id="delete" href="#">Eliminar Comilla(s)</a></li>
 </ul>
</div>
