[% IF ( OpacPublic ) %] <div id="opac_search">
 [% UNLESS ( advsearch ) %]<form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
 <label for="masthead_search" class="left"> Buscar [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (en [% mylibraryfirst %] solamente)[% END %] [% END %] </label>
 <select name="idx" id="masthead_search" class="left">
 [% IF ( ms_kw ) %] <option selected="selected" value="">Library catalog</option>
 [% ELSE %] <option value="">Library catalog</option>
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
 [% END %] [% END %] </select>
 [% IF ( ms_value ) %] <input type="text" title="Type search term" id = "transl1" name="q" value="[% ms_value |html %]" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
 [% ELSE %] <input type="text" title="Type search term" id = "transl1" name="q" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
 [% END %] [% IF ( OpacAddMastheadLibraryPulldown ) %] <select name="branch_group_limit" id="select_library" class="left">
 <option value="">Todas las bibliotecas</option>
 [% IF BranchCategoriesLoop %]<optgroup label="Libraries">[% END %] [% FOREACH BranchesLoo IN BranchesLoop %] [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %] </option>
 [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% END %] [% END %] [% IF BranchCategoriesLoop %] </optgroup>
 <optgroup label="Groups">
 [% FOREACH bc IN BranchCategoriesLoop %] [% IF ( bc.selected ) %] <option selected="selected" value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% ELSE %] <option value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% END %] [% END %] </optgroup>
 </select>
 [% END %] [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Ir" type="submit" id="searchsubmit" class="left" />
 [% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] [% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Listas</a>[% END %] </form>
 [% ELSE %] <div style="width:80%;*margin-bottom:-30px;">
 [% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Listas</a>[% END %] [% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] </div>
 [% END %] </div>
[% END %]