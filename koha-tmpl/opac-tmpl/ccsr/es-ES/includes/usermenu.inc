[% IF ( opacuserlogin ) %][% IF ( loggedinusername ) %] <div id="menu">
<ul>
 [% IF ( userview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-user.pl">mi resumen</a></li>
 [% IF ( OPACFinesTab ) %] [% IF ( accountview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-account.pl">mis multas</a></li>
 [% END %] [% IF ( userupdateview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-memberentry.pl">mis detalles personales</a></li>
 [% IF ( TagsEnabled ) %] [% IF ( tagsview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-tags.pl?mine=1">mis etiquetas</a></li>
 [% END %] [% IF ( OpacPasswordChange ) %] [% IF ( passwdview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-passwd.pl">cambiar mi contraseña</a></li>
 [% END %] [% IF ( ShowOpacRecentSearchLink ) %] [% IF ( searchhistoryview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-search-history.pl">mi historial de búsqueda</a></li>
 [% END %] [% IF ( opacreadinghistory ) %] [% IF ( readingrecview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-readingrecord.pl">mi historial de lecturas</a></li>
 [% IF ( OPACPrivacy ) %] [% IF ( privacyview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-privacy.pl">mi privacidad</a></li>
 [% END %] [% END %] [% IF ( suggestion ) %] [% UNLESS ( AnonSuggestions ) %] [% IF ( suggestionsview ) %]<li class="active suggestions">[% ELSE %]<li class="suggestions">[% END %]<a href="/cgi-bin/koha/opac-suggestions.pl">mis sugerencias de compra</a></li>
 [% END %] [% END %] [% IF ( EnhancedMessagingPreferences ) %] [% IF ( messagingview ) %]<li class="active messaging">[% ELSE %]<li class="messaging">[% END %]<a href="/cgi-bin/koha/opac-messaging.pl">mis mensajes</a></li>
 [% END %] [% IF ( virtualshelves ) %] [% IF ( listsview ) %]<li class="active privateshelves">[% ELSE %]<li class="privateshelves">[% END %]<a href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">mis listas</a></li>
 [% END %] </ul>
</div>
[% END %][% ELSE %][% END %] 