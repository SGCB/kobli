<div id="header-wrapper"><div id="members">
 [% IF ( opacuserlogin ) %] <ul>
[% UNLESS ( loggedinusername ) %] <li><a href="/cgi-bin/koha/opac-user.pl">Inicie sesión en su cuenta</a></li>[% END %] [% IF ( loggedinusername ) %] <li><span class="members">Bienvenido, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></span></li>

 [% END %] [% IF ( ShowOpacRecentSearchLink ) %] <li><a href="/cgi-bin/koha/opac-search-history.pl" title="Ver su historial de búsqueda">Historial de búsqueda</a> [<a href="/cgi-bin/koha/opac-search-history.pl?action=delete" class="logout" title="Borrar el historial de búsqueda" onclick="return confirm(MSG_DELETE_SEARCH_HISTORY);">x</a>]</li>
 [% END %] [% IF ( loggedinusername ) %]<li>[% IF persona %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1" onclick='navigator.id.logout();'>[% ELSE %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">[% END %]Cerrar sesión</a></li>[% END %] </ul> 
 [% END %] </div>
 [% IF ( opacheader ) %] [% opacheader %] [% END %] [% IF ( opaclanguagesdisplay ) %] [% IF ( languages_loop && opaclanguagesdisplay ) %] [% UNLESS ( one_language_enabled ) %] <div id="changelanguage" class="ft">
 <div class="lang"><strong>Idiomas: </strong></div>
 <ul id="i18nMenu" class="footermenu">
 [% FOREACH languages_loo IN languages_loop %] [% IF ( languages_loo.group_enabled ) %] [% IF ( languages_loo.plural ) %] <li class="more"><a class="sublangs" id="show[% languages_loo.rfc4646_subtag %]" href="#">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a><div id="sub[% languages_loo.rfc4646_subtag %]">
 <div class="bd"><ul>
 [% FOREACH sublanguages_loo IN languages_loo.sublanguages_loop %] [% IF ( sublanguages_loo.enabled ) %] [% IF ( sublanguages_loo.sublanguage_current ) %] <li> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</li>
 [% ELSE %] <li><a href="/cgi-bin/koha/opac-changelanguage.pl?language=[% sublanguages_loo.rfc4646_subtag %]"> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</a></li>
 [% END %] [% END %] [% END %] </ul></div></div></li>

 [% ELSE %] [% IF ( languages_loo.group_enabled ) %] [% IF ( languages_loo.current ) %] <li class="morelang">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</li>
 [% ELSE %] <li class="morelang"><a href="/cgi-bin/koha/opac-changelanguage.pl?language=[% languages_loo.rfc4646_subtag %]">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a></li>
 [% END %] [% END %] [% END %] [% END %] [% END %] </ul>
 </div>
 [% END %]
 [% END %]

[% END %]

 <!-- TMPL_IF NAME="opacheader" -->
 <!-- TMPL_VAR NAME="opacheader" -->
 <!-- /TMPL_IF -->
<div id="opac-main-search" class="yui-g">
 [% IF ( opacsmallimage ) %] <h1 id="libraryname" ><a href="/cgi-bin/koha/opac-main.pl" title="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Catálogo en línea Koha[% END %]"><img alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Catálogo en línea Koha[% END %]" src="[% opacsmallimage %]" />[% IF ( LibraryName ) %]<span>[% LibraryName %]</span>[% ELSE %]<span>Catálogo en línea Koha</span>[% END %]</a></h1>
 [% ELSE %] <h1 id="libraryname">
 <a href="/cgi-bin/koha/opac-main.pl" title="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Catálogo en línea Koha[% END %]">[% IF ( LibraryName ) %]<span>[% LibraryName %]</span>[% ELSE %]<span>Catálogo en línea Koha</span>[% END %]</a></h1>
 [% END %] [% IF ( opacsmallimageright ) %] <h1 id="librarylogo" ><a href="/cgi-bin/koha/opac-main.pl" ><img alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Catálogo en línea Koha[% END %]" src="[% opacsmallimageright %]" /></a></h1>
 [% END %] <div id="fluid">

[% IF ( OpacPublic ) %] <div id="fluid-offset">

<div id="moresearches">
<a href="/cgi-bin/koha/opac-search.pl">Búsqueda avanzada</a>
[% IF Koha.Preference( 'UseCourseReserves' ) == 1 %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-course-reserves.pl">Curso de reservas </a>[% END %] [% IF ( OpacBrowser ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-browser.pl">Navegar por jerarquía</a>[% END %] [% IF ( OpacAuthorities ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-authorities-home.pl">Búsqueda por autoridad</a>[% END %] [% IF ( opacuserlogin && ( Koha.Preference( 'reviewson' ) == 1 ) && ( Koha.Preference( 'OpacShowRecentComments' ) == 1 ) ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-showreviews.pl">Comentarios recientes</a>[% END %] [% IF ( TagsEnabled ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags.pl">Nube de etiquetas</a>[% END %] [% IF ( OpacCloud ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags_subject.pl">Nube de temas</a>[% END %] [% IF ( OpacTopissue ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-topissues.pl">Más populares</a>[% END %] [% IF ( suggestion ) %] [% IF ( AnonSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Sugerencias de compra</a>
 [% ELSIF ( OPACViewOthersSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Sugerencias de compra</a>
 [% END %] [% END %] </div>
 </div>
</div>

[% END %] <!-- OpacPublic --> 

[% IF ( opacbookbag ) %]<div id="cartDetails">Su cesta está vacía.</div>[% END %] [% IF ( virtualshelves ) %] <div id="listsmenu" class="yuimenu" style="display: none">
 <div class="bd">
 <h4>Listas públicas</h4>
 [% IF ( pubshelves ) %] <ul class="first-of-type">
 [% FOREACH pubshelvesloo IN pubshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]">[% pubshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves">[Ver todos]</a></li>
 </ul>
 [% ELSE %] No hay listas públicas [% END %] [% IF ( opacuserlogin ) %] <h4>Sus Listas</h4>
 [% IF ( loggedinusername ) %] [% IF ( barshelves ) %] <ul class="first-of-type">
 [% FOREACH barshelvesloo IN barshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]">[% barshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Ver todos]</a></li>
 </ul>
 [% ELSE %] <ul class="first-of-type">
 <li>No hay listas privadas.</li>
 <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Crear una nueva lista]</a></li></ul>
 [% END %] [% ELSE %] <ul class="first-of-type"><li><a href="/cgi-bin/koha/opac-user.pl">Inicie sesión en su cuenta para crear sus propias listas</a></li></ul>
 [% END %] [% END %] </div>
</div><!-- /listmenu /virtualshelves -->
[% END %]
<div id="listsDetails"></div>
</div>
</div>
