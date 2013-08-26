<div id="header-wrapper">

<div id="opac-custom-header">
[% IF ( opacheader ) %] [% opacheader %] [% END %] </div>

<div id="opac-main-search" class="yui-g">

<a class="logo" href="/cgi-bin/koha/opac-main.pl">
 [% UNLESS ( opacsmallimage ) %] [% UNLESS ( LibraryName ) %] <img alt="Catálogo en línea Koha" src="/opac-tmpl/ccsr/images/logo-koha.png" />
 [% ELSE %] <img alt="[% LibraryName %] Catálogo en línea" src="/opac-tmpl/ccsr/images/logo-koha.png" />
 [% END %] [% ELSE %] [% UNLESS ( LibraryName ) %] <img alt="Catálogo en línea Koha" src="[% opacsmallimage %]" />
 [% ELSE %] <img alt="[% LibraryName %] Catálogo en línea" src="[% opacsmallimage %]" />
 [% END %] [% END %] </a>

<div id="fluid">

[% IF ( OpacPublic ) %] <div id="fluid-offset">
[% UNLESS ( advsearch ) %] [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %] [% IF ( OpacShowFiltersPulldownMobile and not OpacShowLibrariesPulldownMobile ) or ( not OpacShowFiltersPulldownMobile and OpacShowLibrariesPulldownMobile ) %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="multi-libraries single-field-mobile">
 [% ELSE %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="multi-libraries">
 [% END %] [% ELSE %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="single-library">
[% END %] <label for="masthead_search" class="left"> Buscar [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (solo en [% mylibraryfirst %])[% END %] [% END %] </label>
 [% IF ( OpacShowFiltersPulldownMobile ) %] <div id="filters">
 [% ELSE %] <div id="filters" class="mobile-hidden">
 [% END %] <select name="idx" id="masthead_search" class="left">
 [% IF ( ms_kw ) %] <option selected="selected" value="">Catálogo</option>
 [% ELSE %] <option value="">Catálogo</option>
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
 </div>

<div class="input-wrapper">
[% IF ( ms_value ) %] <input type="text" id = "transl1" name="q" value="[% ms_value |html %]" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% ELSE %] <input type="text" id = "transl1" name="q" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% END %] </div>

 [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %] [% IF ( OpacShowLibrariesPulldownMobile ) %] <div id="libraries">
 [% ELSE %] <div id="libraries" class="mobile-hidden">
 [% END %] <select name="branch_group_limit" id="select_library" class="left">
 <option value="">Todas las bibliotecas</option>
 <optgroup label="Bibliotecas">
 [% FOREACH BranchesLoo IN BranchesLoop %] [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>[% END %] [% END %] </optgroup>
 [% IF BranchCategoriesLoop %] <optgroup label="Grupos">
 [% FOREACH bc IN BranchCategoriesLoop %] [% IF ( bc.selected ) %] <option selected="selected" value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% ELSE %] <option value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% END %] [% END %] </optgroup>
 [% END %] </select>

 </div>
 [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Ir" type="submit" id="searchsubmit" class="left" />

 <div class="clear"></div>

 </form>
[% ELSE %] <!--advsearch -->
 [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %]
 [% IF ( OpacShowFiltersPulldownMobile and not OpacShowLibrariesPulldownMobile ) or ( not OpacShowFiltersPulldownMobile and OpacShowLibrariesPulldownMobile ) %]
 <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="multi-libraries single-field-mobile">
 [% ELSE %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="multi-libraries">
 [% END %] [% ELSE %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="single-library">
 [% END %] <label for="masthead_search" class="left"> Buscar [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (solo en [% mylibraryfirst %])[% END %] [% END %] </label>
 [% IF ( OpacShowFiltersPulldownMobile ) %] <div id="filters" class="transparent">
 [% ELSE %] <div id="filters" class="transparent mobile-hidden">
 [% END %] <select name="idx" id="masthead_search" class="left" disabled="disabled">
 <option selected="selected" value="">Catálogo</option>
 </select>
 </div>

<div class="input-wrapper">
 <input type="text" id = "transl1" name="q" class="left transparent" style="width: 35%; font-size: 111%;" disabled="disabled"/><div id="translControl"></div>
</div>

 [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %] [% IF ( OpacShowLibrariesPulldownMobile ) %] <div id="libraries">
 [% ELSE %] <div id="libraries" class="mobile-hidden">
 [% END %] <select name="limit" id="select_library" class="left transparent">
 <option value="">Todas las bibliotecas</option>
 </select>
 </div>
 [% END %] <input disabled="disabled" value="Ir" type="submit" id="searchsubmit" class="left transparent" />

 <div class="clear"></div>

 </form>
[% END %] <div id="moresearches">
<a href="/cgi-bin/koha/opac-search.pl">Búsqueda avanzada</a>
[% IF Koha.Preference( 'UseCourseReserves' ) == 1 %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-course-reserves.pl">Curso de reservas</a>[% END %] [% IF ( OpacBrowser ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-browser.pl">Explorar por jerarquía</a>[% END %] [% IF ( OpacAuthorities ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-authorities-home.pl">Búsqueda de autoridades</a>[% END %] [% IF ( opacuserlogin && ( Koha.Preference( 'reviewson' ) == 1 ) && ( Koha.Preference( 'OpacShowRecentComments' ) == 1 ) ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-showreviews.pl">Comentarios recientes</a>[% END %] [% IF ( TagsEnabled ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags.pl">Nube de etiquetas</a>[% END %] [% IF ( OpacCloud ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags_subject.pl">Nube de temas</a>[% END %] [% IF ( OpacTopissue ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-topissues.pl">Más populares</a>[% END %] [% IF ( suggestion ) %] [% IF ( AnonSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Sugerencias de compra</a>
 [% ELSIF ( OPACViewOthersSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Sugerencias de compra</a>
 [% END %] [% END %] </div>
 </div>
</div>

<div id="libraryname">
 <h1></h1>
</div>

[% END %] <!-- OpacPublic -->

</div>
</div>

<div id="container">
<div id="ctn_lt">
<div id="ctn_rt">
<div id="ctn_lb">
<div id="ctn_rb">

<div id="breadcrumbs" class="yui-g">
<p><a href="/cgi-bin/koha/opac-main.pl" title="Inicio">Inicio</a>
[% IF ( searchdesc ) %]<span class="rsaquo"> &rsaquo; </span><a href="/cgi-bin/koha/opac-search.pl" title="Buscar">Buscar</a><span class="rsaquo"> &rsaquo; </span>
[% IF ( total ) %]<strong>Su búsqueda retornó [% total |html %] resultados.</strong>
[% IF ( related ) %] (búsquedas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %]). [% END %] <a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %]&amp;count=[% countrss |html %]&amp;sort_by=acqdate_dsc&amp;format=rss2" class="rsssearchlink">
<img alt="Suscribirse a esta búsqueda" src="/opac-tmpl/ccsr/images/feed-icon-16x16.png" title="Suscribirse a esta búsqueda" class="rsssearchicon" border="0" /></a>
[% ELSE %] <strong>¡No se encontraron resultados!</strong>
<p>
 [% IF ( searchdesc ) %] Sin resultados para ello en el catálogo [% LibraryName %]. <a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %]&amp;format=rss2" class="rsssearchlink"><img alt="Suscribirse a esta búsqueda" src="/opac-tmpl/ccsr/images/feed-icon-16x16.png" title="Suscribirse a esta búsqueda" class="rsssearchicon" border="0" /></a>
 [% ELSE %] Usted no especificó ningún criterio de búsqueda. [% END %] </p>
<div id="noresultsfound">
[% OPACNoResultsFound %] </div>

</div>
[% END %]</p>[% END %]</div>

<div class="ctn_in">
