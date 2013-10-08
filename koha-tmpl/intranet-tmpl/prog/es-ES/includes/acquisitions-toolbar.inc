<script type="text/javascript">
//<![CDATA[
function confirm_deletion() {
    if (confirm(_("¿Está seguro de querer borrar este proveedor? "))) {
        window.location="/cgi-bin/koha/acqui/supplier.pl?booksellerid=[% booksellerid %]&op=delete";
    }
}
//]]>
</script>
<div id="toolbar" class="btn-toolbar">
 [% IF ( booksellerid ) %] <div class="btn-group">
 <a class="btn btn-small dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-plus"></i> Nuevo: <span class="caret"></span>
 </a>
 <ul class="dropdown-menu">
 [% IF ( CAN_user_acquisition_order_manage ) %] <li><a href="/cgi-bin/koha/acqui/basketheader.pl?booksellerid=[% booksellerid %]&amp;op=add_form">Bolsa</a></li>
 [% END %] [% IF ( CAN_user_acquisition_contracts_manage ) %] <li><a href="/cgi-bin/koha/admin/aqcontract.pl?op=add_form&amp;booksellerid=[% booksellerid %]">Contrato</a></li>
 [% END %] [% IF ( CAN_user_acquisition_vendors_manage ) %] <li><a href="/cgi-bin/koha/acqui/supplier.pl?op=enter">Proveedor</a></li>
 [% END %] </ul>
 </div>
 [% IF ( CAN_user_acquisition_vendors_manage ) %] <div class="btn-group"><a class="btn btn-small" id="editsupplier" href="/cgi-bin/koha/acqui/supplier.pl?booksellerid=[% booksellerid %]&amp;op=enter"><i class="icon-pencil"></i> Editar proveedor</a></div>
 [% UNLESS ( basketcount OR subscriptioncount ) %] <div class="btn-group"><a class="btn btn-small" id="deletesupplier" href="javascript:confirm_deletion()"><i class="icon-remove"></i> Eliminar proveedor</a></div>
 [% END %] [% END %] [% IF ( CAN_user_acquisition_order_receive && basketcount ) %] <div class="btn-group"><a class="btn btn-small" id="receive" href="/cgi-bin/koha/acqui/parcels.pl?booksellerid=[% booksellerid %]"><i class="icon-inbox"></i> Recibir envíos</a></div>
 [% END %] [% ELSE %] <div class="btn-group"><a class="btn btn-small" href="/cgi-bin/koha/acqui/supplier.pl?op=enter"><i class="icon-plus"></i> Nuevo proveedor</a></div>
 <div class="btn-group"><a class="btn btn-small" id="exportbutton" href="/cgi-bin/koha/acqui/acqui-history.pl"><i class="icon-list"></i> Histórico de adquisiciones</a></div>
 [% END %] </div>
