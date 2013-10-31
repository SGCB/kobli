<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
    [% IF ( CAN_user_borrowers ) %]
        $("#deletepatron").click(function(){
                confirm_deletion();
                $(".btn-group").removeClass("open");
                return false;
            });
        $("#renewpatron").click(function(){
            confirm_reregistration();
            $(".btn-group").removeClass("open");
            return false;
        });
        [% IF ( is_child ) %]$("#updatechild").click(function(){
            update_child();
            $(".btn-group").removeClass("open");
        });[% END %]
    [% END %]

    $("#exportcheckins").click(function(){
        export_barcodes();
        $(".btn-group").removeClass("open");
        return false;
    });
    $("#printsummary").click(function(){
        printx_window("page");
        $(".btn-group").removeClass("open");
        return false;
    });
    $("#printslip").click(function(){
        printx_window("slip");
        $(".btn-group").removeClass("open");
        return false;
    });
    $("#printquickslip").click(function(){
        printx_window("qslip");
        $(".btn-group").removeClass("open");
        return false;
    });
    $("#searchtohold").click(function(){
        searchToHold();
        return false;
    })
});
function confirm_deletion() {
    var is_confirmed = window.confirm(_("¿Está seguro de querer borrar este usuario? Esto no puede deshacerse."));
    if (is_confirmed) {
        window.location='/cgi-bin/koha/members/deletemem.pl?member=[% borrowernumber %]';
    }
}

[% IF ( is_child ) %]function confirm_updatechild() {
    var is_confirmed = window.confirm(_("¿Está seguro de querer promover este niño a categoría adulto? Esto no puede deshacerse."));
    if (is_confirmed) {
        window.location='/cgi-bin/koha/members/update-child.pl?op=update&borrowernumber=[% borrowernumber %]&catcode=[% catcode %]&catcode_multi=[% CATCODE_MULTI %]';
    }
}

function update_child() {
    [% IF ( CATCODE_MULTI ) %]
        window.open('/cgi-bin/koha/members/update-child.pl?op=multi&borrowernumber=[% borrowernumber %]','UpdateChild','width=400,height=300,toolbar=no,scrollbars=yes,resizable=yes');
    [% ELSE %]
        confirm_updatechild();
    [% END %]
}
[% END %]

function confirm_reregistration() {
    var is_confirmed = window.confirm(_("¿Está seguro de querer renovar el registro de este usuario? "));
    if (is_confirmed) {
    window.location = '/cgi-bin/koha/members/setstatus.pl?borrowernumber=[% borrowernumber %]&amp;cardnumber=[% cardnumber %]&amp;desintation=[% destination %]&amp;reregistration=y';
    }
}
function export_barcodes() {
    window.open('/cgi-bin/koha/members/readingrec.pl?borrowernumber=[% borrowernumber %]&amp;op=export_barcodes');
}
var slip_re = /slip/;
function printx_window(print_type) {
    var handler = print_type.match(slip_re) ? "printslip" : "moremember";
    window.open("/cgi-bin/koha/members/" + handler + ".pl?borrowernumber=[% borrowernumber %]&amp;print=" + print_type, "printwindow");
    return false;
}
function searchToHold(){
    var date = new Date();
    date.setTime(date.getTime() + (10 * 60 * 1000));
    $.cookie("holdfor", "[% borrowernumber %]", { path: "/", expires: date });
    location.href="/cgi-bin/koha/catalogue/search.pl";
}
//]]>
</script>

<div id="toolbar" class="btn-toolbar">
 [% IF ( CAN_user_borrowers ) %] [% IF ( category_type ) %] [% IF ( guarantor ) %] <a id="editpatron" class="btn btn-small" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;destination=circ&amp;borrowernumber=[% borrowernumber %]&amp;guarantorid=[% guarantorborrowernumber %]&amp;category_type=[% category_type %]">
 [% ELSE %] <a id="editpatron" class="btn btn-small" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;destination=circ&amp;borrowernumber=[% borrowernumber %]&amp;category_type=[% category_type %]">
 [% END %] <i class="icon-pencil"></i> Editar</a>
 [% ELSE %] <!-- try with categorycode if no category_type -->
 [% IF ( categorycode ) %]
 <a id="editpatron" class="btn btn-small" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;destination=circ&amp;borrowernumber=[% borrowernumber %]&amp;categorycode=[% categorycode %]"><i class="icon-pencil"></i> Editar</a>
 [% ELSE %] <!-- if no categorycode, set category_type to A by default -->
 <a id="editpatron" class="btn btn-small" href="/cgi-bin/koha/members/memberentry.pl?op=modify&amp;destination=circ&amp;borrowernumber=[% borrowernumber %]&amp;category_type=A"><i class="icon-pencil"></i> Editar</a>
 [% END %] [% END %] [% END %] [% IF ( CAN_user_borrowers ) %] [% IF ( adultborrower AND activeBorrowerRelationship ) %] <a id="addchild" class="btn btn-small" href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;guarantorid=[% borrowernumber %]&amp;category_type=C"><i class="icon-plus"></i> Agregar infante</a>
 [% END %] [% IF ( CAN_user_borrowers ) %] <a id="changepassword" class="btn btn-small" href="/cgi-bin/koha/members/member-password.pl?member=[% borrowernumber %]"><i class="icon-lock"></i> Cambiar contraseña</a>
 [% END %] [% END %] <a id="duplicate" class="btn btn-small" href="/cgi-bin/koha/members/memberentry.pl?op=duplicate&amp;borrowernumber=[% borrowernumber %]&amp;category_type=[% category_type %]"><i class="icon-copy"></i>Duplicado</a>
 <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-print"></i> Imprimir<span class="caret"></span></button>
 <ul class="dropdown-menu">
 [% IF ( CAN_user_borrowers ) %]<li><a id="printsummary" href="#">Imprimir resumen</a></li>[% END %] <li><a id="printslip" href="#">Imprimir recibo</a></li>
 <li><a id="printquickslip" href="#">Imprimir recibo</a></li>
 </ul>
 </div>
 <a id="searchtohold" class="btn btn-small" href="#"><i class="icon-search"></i> Buscar para reservar</a>
 <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown">Más<span class="caret"></span></button>
 <ul class="dropdown-menu">
 [% IF ( CAN_user_borrowers ) %] <li><a id="renewpatron" href="/cgi-bin/koha/members/setstatus.pl?borrowernumber=[% borrowernumber %]&amp;cardnumber=[% cardnumber %]&amp;destination=[% destination %]&amp;reregistration=y">Renovar usuario</a></li>
 [% ELSE %] <li class="disabled"><a id="renewpatron" href="#">Renovar usuario</a></li>
 [% END %] [% IF ( CAN_user_permissions ) %] <li><a id="patronflags" href="/cgi-bin/koha/members/member-flags.pl?member=[% borrowernumber %]">Establecer permisos</a></li>
 [% ELSE %] <li class="disabled"><a id="patronflags" href="#">Establecer permisos</a></li>
 [% END %] [% IF ( CAN_user_borrowers ) %] <li><a id="deletepatron" href="#">Eliminar</a></li>
 [% ELSE %] <li class="disabled"><a id="deletepatron" href="#">Eliminar</a></li>
 [% END %] [% IF ( is_child ) %] <li><a id="updatechild" href="#">Actualizar usuario niño a adulto</a></li>
 [% ELSE %] <li class="disabled"><a id="updatechild" href="#">Actualizar usuario niño a adulto</a></li></li>
 [% END %] <li><a id="exportcheckins" href="#">Exportar los préstamos del día en códigos de barras </a></li>
 </ul>
 </div>
</div>
