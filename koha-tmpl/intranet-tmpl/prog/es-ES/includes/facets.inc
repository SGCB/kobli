[% IF ( opacfacets ) %]
[% IF ( facets_loop ) %]
<div id="search-facets">
<h4>Perfecciona tu búsqueda</h4>
<ul>
 <li>Disponibilidad<ul><li>[% IF ( available ) %]Showing only <strong>disponible</strong> items. <a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]">Show all items</a>[% ELSE %]Limit to <a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]&amp;limit=available">currently available items.</a>[% END %]</li></ul>
 [% IF ( related ) %] <li>(related searches: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %]
 </li>

 [% FOREACH facets_loo IN facets_loop %]
 <li id="[% facets_loo.type_id %]">
[% facets_loo.type_label %] [% IF ( facets_loo.type_label_Authors ) %]Autores[% END %] [% IF ( facets_loo.type_label_Titles ) %]Títulos[% END %] [% IF ( facets_loo.type_label_Topics ) %]Temas[% END %] [% IF ( facets_loo.type_label_Places ) %]Lugares[% END %] [% IF ( facets_loo.type_label_Series ) %]Publicaciones periódicas[% END %] [% IF ( facets_loo.type_label_Libraries ) %]Bibliotecas[% END %] <ul>
 [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %]
 <li class="showmore"><a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">Show more</a></li>
[% END %]
</ul></li>
[% END %]
</ul>
</div>
[% END %]
[% END %]
