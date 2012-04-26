<div id="menu">
<ul>
[% IF ( acquisitions ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=acquisitions" title="Adquisiciones">Adquisiciones</a></li>
[% IF ( admin ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=admin" title="Administración">Administración</a></li>
[% IF ( authorities ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=authorities" title="Control de autoridades">Autoridades</a></li>
[% IF ( cataloguing ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=cataloguing" title="Catalogación">Catalogación</a></li>
[% IF ( circulation ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=circulation" title="Circulación">Circulación</a></li>
[% IF ( creators ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=creators" title="Creadores">Creadores</a></li>
[% IF ( enhanced_content ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=enhanced_content" title="Configuración de contenidos mejorados">Enhanced content</a></li>
[% IF ( i18n_l10n ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Internationalization and localization" href="/cgi-bin/koha/admin/preferences.pl?tab=i18n_l10n">I18N/L10N</a></li>
[% IF ( local_use ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/systempreferences.pl">Local use</a></li>
[% IF ( logs ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Transaction logs" href="/cgi-bin/koha/admin/preferences.pl?tab=logs">Logs</a></li>
[% IF ( opac ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=opac" title="Acceso público del catálogo en línea">OPAC</a></li>
[% IF ( patrons ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=patrons" title="Socios">Socios</a></li>
[% IF ( searching ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=searching" title="Buscar">Buscar</a></li>
[% IF ( serials ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=serials" title="Publicaciones periódicas">Publicaciones periódicas</a></li>
[% IF ( staff_client ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Staff client" href="/cgi-bin/koha/admin/preferences.pl?tab=staff_client">Staff client</a></li>
[% IF ( web_services ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Web services" href="/cgi-bin/koha/admin/preferences.pl?tab=web_services">Web services</a></li>
</ul>
</div>
