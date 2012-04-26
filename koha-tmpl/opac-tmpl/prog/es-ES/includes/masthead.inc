<div id="header-wrapper"><div id="members">
 [% IF ( opacuserlogin ) %] <ul>
[% UNLESS ( loggedinusername ) %] <li><a href="/cgi-bin/koha/opac-user.pl">Inicia sesión en tu cuenta</a></li>[% END %] [% IF ( loggedinusername ) %] <li><span class="members">Bienvenido, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></span></li>

 [% END %] [% IF ( ShowOpacRecentSearchLink ) %] <li><a href="/cgi-bin/koha/opac-search-history.pl" title="View your search history">Historial de búsqueda</a> [<a href="/cgi-bin/koha/opac-search-history.pl?action=delete" class="logout" title="Borrar el historial de búsqueda" onclick="return confirm(_('Are you sure you want to delete your search history?'));">x</a>]</li>
 [% END %] [% IF ( loggedinusername ) %]<li><a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">Cerrar sesión</a></li>[% END %] </ul> 
 [% END %] </div>
 [% IF ( opacheader ) %]
 [% opacheader %]
 [% END %]
[% IF ( opaclanguagesdisplay ) %]
 [% IF ( languages_loop && opaclanguagesdisplay ) %]
 [% UNLESS ( one_language_enabled ) %]
 <div id="changelanguage" class="ft">
 <div class="lang" style="float:left;padding: 0.1em 0;"><strong>Languages:&nbsp;</strong></div>
 <ul id="i18nMenu" class="footermenu">
 [% FOREACH languages_loo IN languages_loop %] [% IF ( languages_loo.group_enabled ) %] [% IF ( languages_loo.plural ) %] <li class="more" style="float:left;"><a class="sublangs" id="show[% languages_loo.rfc4646_subtag %]" href="#">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a><div id="sub[% languages_loo.rfc4646_subtag %]">
 <div class="bd"><ul>
 [% FOREACH sublanguages_loo IN languages_loo.sublanguages_loop %] [% IF ( sublanguages_loo.enabled ) %] [% IF ( sublanguages_loo.sublanguage_current ) %] <li> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</li>
 [% ELSE %] <li><a href="/cgi-bin/koha/changelanguage.pl?language=[% sublanguages_loo.rfc4646_subtag %]"> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</a></li>
 [% END %] [% END %] [% END %] </ul></div></div></li>

 [% ELSE %] [% IF ( languages_loo.group_enabled ) %] [% IF ( languages_loo.current ) %] <li style="float:left;">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</li>
 [% ELSE %] <li style="float:left;"><a href="/cgi-bin/koha/changelanguage.pl?language=[% languages_loo.rfc4646_subtag %]">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a></li>
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
 [% END %] [% IF ( opacsmallimageright ) %] <h1 id="librarylogo" ><img alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Catálogo en línea Koha[% END %]" src="[% opacsmallimageright %]" /></h1>
 [% END %] <div id="fluid">

[% IF ( OpacPublic ) %] <div id="fluid-offset">

<div id="moresearches">
<a href="/cgi-bin/koha/opac-search.pl">Advanced search</a>
[% IF ( OpacBrowser ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-browser.pl">Browse by hierarchy</a>[% END %] [% IF ( OpacAuthorities ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-authorities-home.pl">Buscar por autor o tema</a>[% END %] [% IF ( opacuserlogin && reviewson && OpacShowRecentComments ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-showreviews.pl">Comentarios recientes</a>[% END %] [% IF ( TagsEnabled ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags.pl">Tag cloud</a>[% END %] [% IF ( OpacCloud ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags_subject.pl">Nube de temas</a>[% END %] [% IF ( OpacTopissue ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-topissues.pl">Most popular</a>[% END %] [% IF ( suggestion ) %] [% IF ( AnonSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Purchase suggestions</a>
 [% ELSIF ( OPACViewOthersSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Purchase suggestions</a>
 [% END %] [% END %] </div>
 </div>
</div>

[% END %] <!-- OpacPublic --> 

[% IF ( opacbookbag ) %]<div id="cartDetails">Tu cesta está vacía.</div>[% END %] [% IF ( virtualshelves ) %] <div id="listsmenu" class="yuimenu" style="display: none">
 <div class="bd">
 <h4>Listas públicas</h4>
 [% IF ( pubshelves ) %] <ul class="first-of-type">
 [% FOREACH pubshelvesloo IN pubshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]">[% pubshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves">[View All]</a></li>
 </ul>
 [% ELSE %]
 No public lists
 [% END %]
 [% IF ( opacuserlogin ) %]
 <h4>Your lists</h4>
 [% IF ( loggedinusername ) %] [% IF ( barshelves ) %] <ul class="first-of-type">
 [% FOREACH barshelvesloo IN barshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]">[% barshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[View all]</a></li>
 </ul>
 [% ELSE %] <ul class="first-of-type">
 <li>No private lists</li>
 <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[New list]</a></li></ul>
 [% END %] [% ELSE %] <ul class="first-of-type"><li><a href="/cgi-bin/koha/opac-user.pl">Log in to create your own lists</a></li></ul>
 [% END %] [% END %] </div>
</div><!-- /listmenu /virtualshelves -->
[% END %]
<div id="listsDetails"></div>
</div>
</div>
<div id="breadcrumbs" class="yui-g">
[% IF ( searchdesc ) %]<p>[% IF ( total ) %]<strong>Your search returned [% total |html %] results.</strong> [% IF ( related ) %] (related searches: [% FOREACH relate IN related %][% relate.related_search %][% END %]). [% END %]
<a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %]&amp;count=[% countrss |html %]&amp;sort_by=acqdate_dsc&amp;format=rss2"><img alt="Suscribirse a esta búsqueda" src="/opac-tmpl/prog/images/feed-icon-16x16.png" title="Suscribirse a esta búsqueda" border="0" /></a>
[% ELSE %] <strong>No results found!</strong>
<p>
 [% IF ( searchdesc ) %]
 No results found for that in [% LibraryName %] catalog. <a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %]&amp;format=rss2"><img alt="Suscribirse a esta búsqueda" src="/opac-tmpl/prog/images/feed-icon-16x16.png" title="Suscribirse a esta búsqueda" border="0" /></a>
 [% ELSE %] No has especificado ningún criterio de búsqueda. [% END %] </p>
[% IF ( OPACNoResultsFound ) %] <div id="noresultsfound">
[% OPACNoResultsFound %] </div>
[% END %] </div>
[% END %]</p>[% END %]</div>
