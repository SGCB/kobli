[% IF ( OpacPublic ) %]
<div id="opac_search">
[% UNLESS ( advsearch ) %]<form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
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
		[% IF ( ms_callnum ) %]
        <option selected="selected" value="callnum">Call Number</option>
		[% ELSE %]
        <option value="callnum">Call Number</option>
		[% END %]</select>
[% IF ( ms_value ) %]
        <input type="text" id = "transl1" name="q" value="[% ms_value |html %]" class="left"/><div id="translControl"></div>
[% ELSE %]
        <input type="text" id = "transl1" name="q" class="left"/><div id="translControl"></div>
[% END %]
   [% IF ( OpacAddMastheadLibraryPulldown ) %]
      <select name="limit" id="masthead_search" class="left">
         <option value="">All Libraries</option>
         [% FOREACH BranchesLoo IN BranchesLoopOpac %]
            <option [% IF ( BranchesLoo.selected ) %]SELECTED[% END %] value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
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

[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink" class=""><i></i><span><i></i><span></span>Lists </span></a>[% END %]
    </form>
[% ELSE %]
<div id="lists">
[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink" class=""><i></i><span><i></i><span></span>Lists </span></a>[% END %][% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %]
</div>
[% END %]
</div>
[% END %]