<div id="header-wrapper"><div id="members">
 [% IF ( opacuserlogin ) %] <ul>
[% UNLESS ( loggedinusername ) %] <li><a href="/cgi-bin/koha/opac-user.pl">Ingresar a su cuenta</a></li>[% END %] [% IF ( loggedinusername ) %] <li><span class="members">Bienvenido, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></span></li>

 [% END %] [% IF ( ShowOpacRecentSearchLink ) %] <li><a href="/cgi-bin/koha/opac-search-history.pl" title="Ver su historial de búsqueda">Historial de búsqueda</a> [<a href="/cgi-bin/koha/opac-search-history.pl?action=delete" class="logout" title="Borrar historial de búsqueda" onclick="return confirm(_('Are you sure you want to delete your search history?'));">x</a>]</li>
 [% END %] [% IF ( loggedinusername ) %]<li><a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">Salir</a></li>[% END %] </ul> 
 [% END %] </div>
 [% IF ( opacheader ) %]
 [% opacheader %]
 [% END %]
[% IF ( opaclanguagesdisplay ) %]
 [% IF ( languages_loop && opaclanguagesdisplay ) %]
 [% UNLESS ( one_language_enabled ) %]
 <div id="changelanguage" class="ft">
 <div class="lang" style="float:left;padding: 0.1em 0;"><strong>Idiomas:&nbsp;</strong></div>
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
 [% IF ( opacsmallimage ) %] <h1 id="libraryname" ><a href="/cgi-bin/koha/opac-main.pl" title="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]"><img src="[% opacsmallimage %]" alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]" />[% IF ( LibraryName ) %]<span>[% LibraryName %]</span>[% ELSE %]<span>Koha Online Catalog</span>[% END %]</a></h1>
 [% ELSE %] <h1 id="libraryname">
 <a href="/cgi-bin/koha/opac-main.pl" title="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]">[% IF ( LibraryName ) %]<span>[% LibraryName %]</span>[% ELSE %]<span>Koha Online Catalog</span>[% END %]</a></h1>
 [% END %] [% IF ( opacsmallimageright ) %] <h1 id="librarylogo" ><a href="/cgi-bin/koha/opac-main.pl" ><img src="[% opacsmallimageright %]" alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]" /></a></h1>
 [% END %] <div id="fluid">

[% IF ( OpacPublic ) %] <div id="fluid-offset">
[% UNLESS ( advsearch ) %]<form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
 <label for="masthead_search" class="left"> Buscar [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (en [% mylibraryfirst %] solamente)[% END %] [% END %] </label>

 <select name="idx" id="masthead_search" class="left">
 [% IF ( ms_kw ) %] <option selected="selected" value="">Catálogo de biblioteca</option>
 [% ELSE %] <option value="">Catálogo de biblioteca</option>
 [% END %] [% IF ( ms_ti ) %] <option selected="selected" value="ti">Título</option>
 [% ELSE %] <option value="ti">Título</option>
 [% END %] [% IF ( ms_au ) %] <option selected="selected" value="au">Autor</option>
 [% ELSE %] <option value="au">Autor</option>
 [% END %] [% IF ( ms_su ) %] <option selected="selected" value="su">Tema</option>
 [% ELSE %] <option value="su">Tema</option>
 [% END %] [% IF ( ms_nb ) %] <option selected="selected" value="nb">ISBN</option>
 [% ELSE %] <option value="nb">ISBN</option>
 [% END %] [% IF ( ms_se ) %] <option selected="selected" value="se">Series</option>
 [% ELSE %] <option value="se">Series</option>
 [% END %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum">Signatura topográfica</option>
 [% ELSE %] <option value="callnum">Signatura topográfica</option>
 [% END %]</select>
[% IF ( ms_value ) %] <input type="text" id = "transl1" name="q" value="[% ms_value |html %]" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% ELSE %] <input type="text" id = "transl1" name="q" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% END %] [% IF ( OpacAddMastheadLibraryPulldown ) %] <select name="limit" id="select_library" class="left">
 <option value="">Todas las bibliotecas</option>
 [% FOREACH BranchesLoo IN BranchesLoop %] [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>[% END %] [% END %] </select>
 [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Ir" type="submit" id="searchsubmit" class="left" />
[% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] [% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Listas</a>[% END %] </form>
[% ELSE %] <div style="width:80%;*margin-bottom:-30px;">
[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Listas</a>[% END %][% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] </div>
[% END %] <div id="moresearches">
<a href="/cgi-bin/koha/opac-search.pl">Búsqueda avanzada</a>
[% IF ( OpacBrowser ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-browser.pl">Explorar por jerarquía</a>[% END %] [% IF ( OpacAuthorities ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-authorities-home.pl">Explorar por autor o tema</a>[% END %] [% IF ( opacuserlogin && reviewson && OpacShowRecentComments ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-showreviews.pl">Comentarios recientes</a>[% END %] [% IF ( TagsEnabled ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags.pl">Nube de etiquetas</a>[% END %] [% IF ( OpacCloud ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags_subject.pl">Nube de temas</a>[% END %] [% IF ( OpacTopissue ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-topissues.pl">Más populares</a>[% END %] [% IF ( suggestion ) %] [% IF ( AnonSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Sugerencias de compra</a>
 [% ELSIF ( OPACViewOthersSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Sugerencias de compra</a>
 [% END %] [% END %] </div>
 </div>
</div>

[% END %] <!-- OpacPublic --> 

[% IF ( opacbookbag ) %]<div id="cartDetails">Su bolsa de libros está vacía.</div>[% END %] [% IF ( virtualshelves ) %] <div id="listsmenu" class="yuimenu" style="display: none">
 <div class="bd">
 <h4>Listas públicas</h4>
 [% IF ( pubshelves ) %] <ul class="first-of-type">
 [% FOREACH pubshelvesloo IN pubshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]">[% pubshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves">[Ver todo]</a></li>
 </ul>
 [% ELSE %] Sin listas públicas [% END %] [% IF ( opacuserlogin ) %] <h4>Sus listas</h4>
 [% IF ( loggedinusername ) %] [% IF ( barshelves ) %] <ul class="first-of-type">
 [% FOREACH barshelvesloo IN barshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]">[% barshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Ver todo]</a></li>
 </ul>
 [% ELSE %] <ul class="first-of-type">
 <li>No hay listas privadas </li>
 <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Nueva lista]</a></li></ul>
 [% END %] [% ELSE %] <ul class="first-of-type"><li><a href="/cgi-bin/koha/opac-user.pl">Ingrese para crear sus propias listas</a></li></ul>
 [% END %] [% END %] </div>
</div><!-- /listmenu /virtualshelves -->
[% END %]
<div id="listsDetails"></div>
</div>
</div>
<div id="breadcrumbs" class="yui-g">
[% IF ( searchdesc ) %]<p>[% IF ( total ) %]<strong>Su búsqueda retornó [% total |html %] resultados.</strong> [% IF ( related ) %] (búsquedas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %]). [% END %] <a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %]&amp;count=[% countrss |html %]&amp;sort_by=acqdate_dsc&amp;format=rss2"><img alt="Suscribirse a esta búsqueda" src="/opac-tmpl/prog/images/feed-icon-16x16.png" title="Suscribirse a esta búsqueda" border="0" /></a>
[% ELSE %] <strong>No se encontraron resultados!</strong>
<p>
 [% IF ( searchdesc ) %] Sin resultados para ello en el catálogo [% LibraryName %]. <a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %]&amp;format=rss2"><img alt="Suscribirse a esta búsqueda" src="/opac-tmpl/prog/images/feed-icon-16x16.png" title="Suscribirse a esta búsqueda" border="0" /></a>
 [% ELSE %] Usted no especificó ningún criterio de búsqueda. [% END %] </p>
[% IF ( OPACNoResultsFound ) %] <div id="noresultsfound">
[% OPACNoResultsFound %] </div>
[% END %] </div>
[% END %]</p>[% END %]</div>
