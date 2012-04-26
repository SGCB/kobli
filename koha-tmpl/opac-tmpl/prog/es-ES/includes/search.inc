[% IF ( OpacPublic ) %] <div id="opac_search">
[% UNLESS ( advsearch ) %]<form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
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
 [% END %] [% IF ( ms_se ) %] <option selected="selected" value="se">Publicación periódica</option>
 [% ELSE %] <option value="se">Publicación periódica</option>
 [% END %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum">Signatura topográfica</option>
 [% ELSE %] <option value="callnum">Signatura topográfica</option>
 [% END %]</select>
[% IF ( ms_value ) %] <input type="text" id = "transl1" name="q" value="[% ms_value |html %]" class="left"/><div id="translControl"></div>
[% ELSE %] <input type="text" id = "transl1" name="q" class="left"/><div id="translControl"></div>
[% END %] [% IF ( OpacAddMastheadLibraryPulldown ) %] <select name="limit" id="masthead_search" class="left">
 <option value="">Todas las bibliotecas</option>
 [% FOREACH BranchesLoo IN BranchesLoopOpac %] <option [% IF ( BranchesLoo.selected ) %]SELECTED[% END %] value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% END %] </select>
 [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Ir" type="submit" id="searchsubmit" class="left" />
[% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] [% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink" class=""><i></i><span><i></i><span></span>Listas </span></a>[% END %] </form>
[% ELSE %] <div id="lists">
[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink" class=""><i></i><span><i></i><span></span>Listas </span></a>[% END %][% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] </div>
[% END %] </div>
[% END %]