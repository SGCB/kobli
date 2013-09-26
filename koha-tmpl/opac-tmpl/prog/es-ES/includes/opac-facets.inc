[% IF ( opacfacets ) %] [% IF ( facets_loop ) %] <div id="facets">
[% UNLESS ( advsearch ) %] <div id="left_search">
 [% IF ( OpacPublic ) %] <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
 <h4 class="new_search">Nueva búsqueda</h4>
 <label for="masthead_search" class="left"> Buscar [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (en [% mylibraryfirst %] solamente)[% END %] [% END %] </label>

 <select name="idx" id="masthead_search" class="left">
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
 [% END %] [% IF ( numbersphr ) %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum,phr">Signatura topográfica</option>
 [% ELSE %] <option value="callnum,phr">Signatura topográfica</option>
 [% END %] [% ELSE %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum">Signatura topográfica</option>
 [% ELSE %] <option value="callnum">Signatura topográfica</option>
 [% END %] [% END %]</select>
[% IF ( ms_value ) %] <input value="[% ms_value |html %]" name="q" style="width: 35%; font-size: 111%;" class="left" id="transl1" title="Introduzca los términos de búsqueda" type="text" /><div id="translControl"></div>
[% ELSE %] <input name="q" style="width: 35%; font-size: 111%;" type="text" title="Introduzca los términos de búsqueda" id="transl1" class="left" /><div id="translControl"></div>
[% END %] [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %] <select name="branch_group_limit" id="select_library" class="left">
 <option value="">Todas las bibliotecas</option>
 [% IF BranchCategoriesLoop %]<optgroup label="Bibliotecas">[% END %] [% FOREACH BranchesLoo IN BranchesLoop %] [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>[% END %] [% END %] [% IF BranchCategoriesLoop %] </optgroup>
 <optgroup label="Grupos">
 [% FOREACH bc IN BranchCategoriesLoop %] [% IF ( bc.selected ) %] <option selected="selected" value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% ELSE %] <option value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% END %] [% END %] </optgroup>
 [% END %] </select>
 [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Ir" type="submit" id="searchsubmit" class="left" />
 </form>
 [% END %] </div>
[% END %] </div>
<div id="search-facets">
<h4>Refina su búsqueda</h4>
<ul>
 <li id="availability_facet">Disponibilidad<ul><li>[% IF ( available ) %]Mostrando sólo <strong>disponible</strong> ítems<a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]">Mostrar todos los ítems</a>[% ELSE %]Limitar a <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]&amp;limit=available">ítems disponibles actualmente.</a>[% END %]</li></ul>
 [% IF ( related ) %] <li>(búsquedas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %] </li>
 
[% FOREACH facets_loo IN facets_loop %] [% IF facets_loo.facets.size > 0 %] <li id="[% facets_loo.type_id %]">
[% IF ( facets_loo.type_label_Authors ) %]Autores[% END %] [% IF ( facets_loo.type_label_Titles ) %]Títulos[% END %] [% IF ( facets_loo.type_label_Topics ) %]Temas[% END %] [% IF ( facets_loo.type_label_Places ) %]Lugares[% END %] [% IF ( facets_loo.type_label_Series ) %]Series[% END %] [% IF ( facets_loo.type_label_ItemTypes ) %] Tipos de ítems[% END %] [% UNLESS ( singleBranchMode ) %] [% IF ( facets_loo.type_label_Libraries ) %]Bibliotecas[% END %] [% END %] [% IF ( facets_loo.type_label_Location ) %]Localizaciones[% END %] <ul>
 [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value |html %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %] <li class="showmore"><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">Mostrar más</a></li>
[% END %] </ul></li>
[% END %] [% END %] </ul>
</div>
<div id="opacresultssidebar">
</div>
[% END %] [% END %]