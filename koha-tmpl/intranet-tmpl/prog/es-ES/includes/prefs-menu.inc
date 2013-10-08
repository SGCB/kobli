<div id="menu">
<ul>
[% IF ( acquisitions ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=acquisitions" title="Adquisiciones">Adquisiciones</a></li>
[% IF ( admin ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=admin" title="Administración">Administración</a></li>
[% IF ( authorities ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=authorities" title="Control de autoridades">Autoridades</a></li>
[% IF ( cataloguing ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=cataloguing" title="Catalogación">Catalogación</a></li>
[% IF ( circulation ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=circulation" title="Circulación">Circulación</a></li>
[% IF ( creators ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=creators" title="Creadores">Creadores</a></li>
[% IF ( enhanced_content ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=enhanced_content" title="Configuración de contenidos mejorados">Contenido mejorado</a></li>
[% IF ( i18n_l10n ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=i18n_l10n" title="Internacionalización y localización">I18N/L10N</a></li>
[% IF ( local_use ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/systempreferences.pl">Uso local</a></li>
[% IF ( logs ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=logs" title="Registros de transacción">Logs</a></li>
[% IF ( opac ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=opac" title="Acceso público del catálogo en línea">OPAC</a></li>
[% IF ( patrons ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=patrons" title="Usuarios">Usuarios</a></li>
[% IF ( searching ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=searching" title="Buscar">Buscar</a></li>
[% IF ( serials ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=serials" title="Publicaciones periódicas">Publicaciones periódicas</a></li>
[% IF ( staff_client ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=staff_client" title="Cliente administrativo">Cliente administrativo</a></li>
[% IF ( web_services ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=web_services" title="Servicios Web">Servicios Web</a></li>
</ul>
</div>
