[% IF ( opacfacets ) %]
[% IF ( facets_loop ) %]
<div id="facets">
[% UNLESS ( advsearch ) %]
    <div id="left_search">
  [% IF ( OpacPublic ) %]
  <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
    <h4 class="new_search">New search</h4>
    <label for="masthead_search" class="left"> Search 
    [% UNLESS ( OpacAddMastheadLibraryPulldown ) %]
            [% IF ( mylibraryfirst ) %] (in [% mylibraryfirst %] only)[% END %]
    [% END %]
    </label>

    <select name="idx" id="masthead_search" class="left">
    [% IF ( ms_kw ) %]
        <option selected="selected" value="">Library Catalog</option>
        [% ELSE %]
        <option value="">Library Catalog</option>
        [% END %]
        [% IF ( ms_ti ) %]
        <option selected="selected" value="ti">Title</option>
        [% ELSE %]
        <option value="ti">Title</option>
        [% END %]
        [% IF ( ms_au ) %]
        <option selected="selected" value="au">Author</option>
        [% ELSE %]
        <option value="au">Author</option>
        [% END %]
        [% IF ( ms_su ) %]
        <option selected="selected" value="su">Subject</option>
        [% ELSE %]
        <option value="su">Subject</option>
        [% END %]
        [% IF ( ms_nb ) %]
        <option selected="selected" value="nb">ISBN</option>
        [% ELSE %]
        <option value="nb">ISBN</option>
        [% END %]
        [% IF ( ms_se ) %]
        <option selected="selected" value="se">Series</option>
        [% ELSE %]
        <option value="se">Series</option>
        [% END %]
                [% IF ( numbersphr ) %]
                [% IF ( ms_callnum ) %]
        <option selected="selected" value="callnum,phr">Call number</option>
                [% ELSE %]
        <option value="callnum,phr">Call number</option>
                [% END %]
                [% ELSE %]
                [% IF ( ms_callnum ) %]
        <option selected="selected" value="callnum">Call number</option>
                [% ELSE %]
        <option value="callnum">Call number</option>
                [% END %]
                [% END %]</select>
[% IF ( ms_value ) %]
        <input type="text" title="Type search term" id = "transl1" name="q" value="[% ms_value |html %]" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% ELSE %]
        <input type="text" title="Type search term" id = "transl1" name="q" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% END %]
   [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %]
      <select name="branch_group_limit" id="select_library" class="left">
         <option value="">All libraries</option>
         [% IF BranchCategoriesLoop %]<optgroup label="Libraries">[% END %]
             [% FOREACH BranchesLoo IN BranchesLoop %]
                [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
                [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>[% END %]
             [% END %]
         [% IF BranchCategoriesLoop %]
             </optgroup>
             <optgroup label="Groups">
                 [% FOREACH bc IN BranchCategoriesLoop %]
                     [% IF ( bc.selected ) %]
                         <option selected="selected" value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
                     [% ELSE %]
                         <option value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
                     [% END %]
                 [% END %]
             </optgroup>
         [% END %]
      </select>
   [% ELSE %]
      [% IF ( opac_limit_override ) %]
          [% IF ( opac_search_limit ) %]
            <input name="limit" value="[% opac_search_limit %]" type="hidden" />
          [% END %]
      [% ELSE %]
          [% IF ( mylibraryfirst ) %] 
               <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
          [% END %]
      [% END %]
   [% END %]
    <input type="submit" value="Go" id="searchsubmit" class="left" />
    </form>
  [% END %]
  </div>
[% END %]
</div>
<div id="search-facets">
<h4>Refine your search</h4>
<ul>
    <li id="availability_facet">Availability<ul><li>[% IF ( available ) %]Showing only <strong>available</strong> items. <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]">Show all items</a>[% ELSE %]Limit to <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]&amp;limit=available">currently available items.</a>[% END %]</li></ul>
    [% IF ( related ) %] <li>(related searches: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %]
    </li>
    
[% FOREACH facets_loo IN facets_loop %]
[% IF facets_loo.facets.size > 0 %]
<li id="[% facets_loo.type_id %]">
[% IF ( facets_loo.type_label_Authors ) %]Authors[% END %]
[% IF ( facets_loo.type_label_Titles ) %]Titles[% END %]
[% IF ( facets_loo.type_label_Topics ) %]Topics[% END %]
[% IF ( facets_loo.type_label_Places ) %]Places[% END %]
[% IF ( facets_loo.type_label_Series ) %]Series[% END %]
[% IF ( facets_loo.type_label_ItemTypes ) %]Item types[% END %]
[% UNLESS ( singleBranchMode ) %]
[% IF ( facets_loo.type_label_Libraries ) %]Libraries[% END %]
[% END %]
[% IF ( facets_loo.type_label_Location ) %]Locations[% END %]
<ul>
        [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value |html %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %]
        <li class="showmore"><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">Show more</a></li>
[% END %]
</ul></li>
[% END %]
[% END %]
</ul>
</div>
<div id="opacresultssidebar">
</div>
[% END %]
[% END %]