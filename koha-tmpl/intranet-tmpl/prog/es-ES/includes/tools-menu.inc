<script type="text/javascript">//<![CDATA[
    $(document).ready(function() {
        var path = location.pathname.substring(1);
        var url = window.location.toString();
        var params = '';
        if ( url.match(/\?(.+)$/) ) {
            params = "?" + RegExp.$1;
        }
        $('#navmenulist a[href$="/' + path + params + '"]').css('font-weight','bold');
    });
//]]>
</script>
<div id="navmenu">
<div id="navmenulist">
<ul>
 <li><a href="/cgi-bin/koha/tools/tools-home.pl">Herramientas</a></li>
</ul>
<h5>Usuarios y circulación</h5>
<ul>
 [% IF ( CAN_user_tools_moderate_comments ) %] <li><a href="/cgi-bin/koha/reviews/reviewswaiting.pl">Comentarios</a></li>
 [% END %] [% IF ( CAN_user_tools_import_patrons ) %] <li><a href="/cgi-bin/koha/tools/import_borrowers.pl">Importar usuarios</a></li>
 [% END %] [% IF ( CAN_user_tools_edit_notices ) %] <li><a href="/cgi-bin/koha/tools/letter.pl">Avisos &amp; Recibos</a></li>
 [% END %] [% IF ( CAN_user_tools_edit_notice_status_triggers ) %] <li><a href="/cgi-bin/koha/tools/overduerules.pl">Disparadores de avisos de retraso/estado</a></li>
 [% END %] [% IF ( CAN_user_tools_label_creator ) %] <li><a href="/cgi-bin/koha/patroncards/home.pl">Creador de carnet de usuario</a></li>
 [% END %] [% IF ( CAN_user_tools_delete_anonymize_patrons ) %] <li><a href="/cgi-bin/koha/tools/cleanborrowers.pl">Lote usuario texto borrado/anonimato</a></li>
 [% END %] [% IF ( CAN_user_tools_edit_patrons ) %] <li><a href="/cgi-bin/koha/tools/modborrowers.pl">Lote modificaciones de usuario</a></li>
 [% END %] [% IF ( CAN_user_tools_moderate_tags ) %] <li><a href="/cgi-bin/koha/tags/review.pl">Moderación de etiquetas</a></li>
 [% END %] [% IF ( CAN_user_tools_batch_upload_patron_images ) %] <li><a href="/cgi-bin/koha/tools/picture-upload.pl">Subir imágenes de usuarios</a></li>
 [% END %] </ul>
<h5>Catálogo</h5>
<ul>
 [% IF ( CAN_user_tools_items_batchdel ) %] <li><a href="/cgi-bin/koha/tools/batchMod.pl?del=1">Eliminar ítems en lote</a></li>
 [% END %] [% IF ( CAN_user_tools_items_batchmod ) %] <li><a href="/cgi-bin/koha/tools/batchMod.pl">Modificación de ítems en lote</a></li>
 [% END %] [% IF ( CAN_user_tools_export_catalog ) %] <li><a href="/cgi-bin/koha/tools/export.pl">Exportar datos </a></li>
 [% END %] [% IF ( CAN_user_tools_inventory ) %] <li><a href="/cgi-bin/koha/tools/inventory.pl">Inventario/existencias</a></li>
 [% END %] [% IF ( CAN_user_tools_label_creator ) %] <li><a href="/cgi-bin/koha/labels/label-home.pl">Creador de etiquetas</a></li>
 <li><a href="/cgi-bin/koha/labels/spinelabel-home.pl">Creador rápido de tejuelos</a></li>
 [% END %]
<!--
 [% IF ( CAN_user_tools_rotating_collections ) %]
 <li><a href="/cgi-bin/koha/rotating_collections/rotatingCollections.pl">Rotating collections</a></li>
 [% END %]
-->
 [% IF ( CAN_user_tools_stage_marc_import ) %]
 <li><a href="/cgi-bin/koha/tools/stage-marc-import.pl">MARC preparado para importar</a></li>
 [% END %] [% IF ( CAN_user_tools_manage_staged_marc ) %] <li><a href="/cgi-bin/koha/tools/manage-marc-import.pl">Administración de MARC preparado</a></li>
 [% END %] [% IF ( CAN_user_tools_upload_local_cover_images ) %] <li><a href="/cgi-bin/koha/tools/upload-cover-image.pl">Cargar imágenes de cubierta locales</a></li>
 [% END %] </ul>
<h5>Herramientas adicionales</h5>
<ul>
 [% IF ( CAN_user_tools_edit_calendar ) %] <li><a href="/cgi-bin/koha/tools/holidays.pl">Calendario</a></li>
 [% END %] [% IF ( CAN_user_tools_manage_csv_profiles ) %] <li><a href="/cgi-bin/koha/tools/csv-profiles.pl">Perfiles CSV</a></li>
 [% END %] [% IF ( CAN_user_tools_view_system_logs ) %] <li><a href="/cgi-bin/koha/tools/viewlog.pl">Visor del log</a></li>
 [% END %] [% IF ( CAN_user_tools_edit_news ) %] <li><a href="/cgi-bin/koha/tools/koha-news.pl">Noticias</a></li>
 [% END %] [% IF ( CAN_user_tools_schedule_tasks ) %] <li><a href="/cgi-bin/koha/tools/scheduler.pl">Planificador de tareas</a></li>
 [% END %] [% IF ( CAN_user_tools_edit_quotes ) %] <li><a href="/cgi-bin/koha/tools/quotes.pl">Editor de citas</a></li>
 [% END %] [% IF ( CAN_user_tools_upload_prefs_images ) %] <li><a href="/cgi-bin/koha/tools/prefs-images-upload.pl">Subir imágenes del OPAC</a></li>
 [% END %] </ul></div></div>
