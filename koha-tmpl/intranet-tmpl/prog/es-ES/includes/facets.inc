[% IF ( opacfacets ) %] [% IF ( facets_loop ) %] <div id="search-facets">
<h4>Refinar su búsqueda</h4>
<ul>
 <li id="availability_facet">Disponibilidad<ul><li>[% IF ( available ) %]Mostrando solamente <strong>disponible</strong> ítems. <a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]">Mostrar todos los ítems:</a>[% ELSE %]Limitar a <a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]&amp;limit=available">ítems actualmente disponibles</a>[% END %]</li></ul>
 [% IF ( related ) %] <li>(búsquedas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %] </li>

 [% FOREACH facets_loo IN facets_loop %] [% IF facets_loo.facets.size > 0 %] <li id="[% facets_loo.type_id %]">
[% facets_loo.type_label %] [% IF ( facets_loo.type_label_Authors ) %]Autores[% END %] [% IF ( facets_loo.type_label_Titles ) %]Títulos[% END %] [% IF ( facets_loo.type_label_Topics ) %]Temas[% END %] [% IF ( facets_loo.type_label_Places ) %]Lugares[% END %] [% IF ( facets_loo.type_label_Series ) %]Series[% END %] [% IF ( facets_loo.type_label_ItemTypes ) %]Tipos de ítem[% END %] [% IF ( facets_loo.type_label_Libraries ) %]Bibliotecas[% END %] [% IF ( facets_loo.type_label_Location ) %]Localizaciones[% END %] <ul>
 [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %] <li class="showmore"><a href="/cgi-bin/koha/catalogue/search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">Mostar más</a></li>
[% END %] </ul></li>
[% END %] [% END %] </ul>
</div>
[% END %] [% END %] 