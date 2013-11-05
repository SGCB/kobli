[% IF ( OpacPublic ) %]
<div id="opac_search">
[% UNLESS ( advsearch ) %]<form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
    <label for="masthead_search" class="left"> Search 
  [% UNLESS Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %]
            [% IF ( mylibraryfirst ) %] (in [% mylibraryfirst %] only)[% END %]
	[% END %]
    </label>

	<select name="idx" id="masthead_search" class="left">
	[% IF ( ms_kw ) %]
        <option selected="selected" value="">Library catalog</option>
		[% ELSE %]
        <option value="">Library catalog</option>
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
        <input type="text" id = "transl1" name="q" value="[% ms_value |html %]" class="left"/><div id="translControl"></div>
[% ELSE %]
        <input type="text" id = "transl1" name="q" class="left"/><div id="translControl"></div>
[% END %]
   [% IF Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 %]
      <select name="branch_group_limit" id="masthead_search" class="left">
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
[% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %]

[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Lists</a>[% END %]
    </form>
[% ELSE %]
<div style="width:80%;*margin-bottom:-30px;">
[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Lists</a>[% END %][% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %]
</div>
[% END %]</div>
[% END %]