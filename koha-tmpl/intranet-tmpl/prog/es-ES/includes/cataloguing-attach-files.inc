<script type="text/javascript">
$(function() {
    $("#coverimagefile").change(function () {
        var value = $(this).val();
        if (value != '') {
            var ext = value.substring(value.lastIndexOf('.') + 1, value.length);
            if (ext.toLowerCase() != 'jpg' && ext.toLowerCase() != 'jpeg' && ext.toLowerCase() != 'gif' && ext.toLowerCase() != 'png') {
                $(this).css("background-color","yellow");
                alert("Image doesn't have jpg/jpeg/gif/png extension.");
                $(this).val('');
                $(this).css("background-color","white");
            }
        }
    });
    $("#a_coverimage").click(function () {
        window.open('[% urlcoverimage %]','coverimagepopup','width=500,height=600,resizable=yes');
    });
});

var errorAjaxDelete = false;

function send_ajax_delete(biblionumber, itemnumber, type)
{
    if (biblionumber && confirm("Do you really want to delete the " + type + "?")) {
        $.ajax({
            type: "POST",
            url: "/cgi-bin/koha/cataloguing/delete_cover_doc.pl",
            dataType: "xml",
            async: true,
            "data": {biblionumber: biblionumber, itemnumber: itemnumber, type: type},
            "success": receive_ok_delete
        });
        $("*").ajaxError(function(evt, request, settings){
            if (!errorAjaxDelete) {
                alert("AJAX error: receiving data from " + settings.url);
                errorAjaxDelete = true;
            }
        });
    }
}//send_ajax_delete

function receive_ok_delete(data, textStatus)
{
    var xmlDocInd = data.documentElement;
    errorAjaxDelete = false;
    var nodeError = xmlDocInd.getElementsByTagName('Error')[0];
    if (nodeError && nodeError.hasChildNodes()) {
        var resp = nodeError.firstChild.nodeValue;
        var numberError;
        var type;
        if (resp.indexOf(",") > 0) {
            var arr = resp.split(",");
            numberError = arr[0];
            type = arr[1];
        } else {
            numberError = resp;
        }
        switch (parseInt(numberError, 10)) {
            case 1:
                if (type == "cover") {
                    var obj;
                    if ((obj = document.getElementById('existingcoverimage')) && obj.parentNode) {
                        obj.parentNode.removeChild(obj);
                    }
                    alert("Cover image deleted.");
                } else if (type == "document") {
                    var obj;
                    if ((obj = document.getElementById('existingdocument')) && obj.parentNode) {
                        obj.parentNode.removeChild(obj);
                    }
                    var $inputs = $('input:text[id^="tag_952_subfield_u_"]');
                    $inputs.each(function() {
                        $(this).val("");
                    });
                    alert("Additional document deleted.");
                }
            break;
        }
    }
}//receive_ok_delete

</script>
<ul class="doc-biblio">
 [% IF ( showCoverImageLR ) %] <li id="imagecoverbiblio"><br /><label for="coverimagefile">Imagen de cubierta: </label>
 <input type="file" name="coverimagefile" id="coverimagefile" />
 </li>
 [% IF ( existingcoverimage ) %] <li id="existingcoverimage">
 [% IF ( urlcoverimagemin ) %] <a href="javascript://" id="a_coverimage" title="Ver imagen de la cubierta"><img src="[% urlcoverimagemin %]" border="0" id="coverimage" name="coverimage" />Ver imagen de la cubierta</a>
 [% ELSE %] <a href="javascript://" id="a_coverimage" title="Ver imagen de la cubierta">Ver imagen de la cubierta</a>
 [% END %]&nbsp;&nbsp; <a href="javascript://" onclick="send_ajax_delete('[% biblionumber %]', '', 'cover')" title="Eliminar imagen de cubierta">Eliminar imagen de cubierta</a>
 </li>
 [% END %] [% END %] <li id="documentbiblio"><label for="documentbibliofile">Documento Adicional<i>(max. 10MB)</i>: </label>
 <input name="documentbibliofile" type="file" id="documentbibliofile" title="Documento adicional (max 10MB)" />
 </li>
 [% IF ( existingdocument ) %] <li id="existingdocument">
 [% IF ( urldocument ) %]<a href="[% urldocument %]" target="_blank">Ver documento adicional</a>
 &nbsp;&nbsp;
 <a href="javascript://" onclick="send_ajax_delete('[% biblionumber %]', '[% itemnumber %]', 'document')" title="Eliminar Documento Adicional">Eliminar Documento Adicional</a>
 [% END %] </li>
 [% END %] <li>&nbsp;</li>
 [% IF ( errorUploadFile ) %] <li><h3>[% errorUploadFile %]</h3></li>
 [% END %] </ul>