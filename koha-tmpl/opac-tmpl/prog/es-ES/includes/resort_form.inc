<option value="relevance">Relevancia</option>
<optgroup label="Popularidad">
[% IF ( sort_by == "popularity_dsc" ) %] <option value="popularity_dsc" selected="selected">Popularidad (de mayor a menor)</option>[% ELSE %] <option value="popularity_dsc">Popularidad (de mayor a menor)</option>
[% END %] [% IF ( sort_by == "popularity_asc" ) %] <option value="popularity_asc" selected="selected">Popularidad (de menor a mayor)</option>[% ELSE %] <option value="popularity_asc">Popularidad (de menor a mayor)</option>
[% END %] </optgroup>
<optgroup label="Autor">
[% IF ( sort_by == "author_az" || sort_by == "author_asc" ) %] <option value="author_az" selected="selected">Autor (A-Z)</option>
[% ELSE %] <option value="author_az">Autor (A-Z)</option>
[% END %] [% IF ( sort_by == "author_za" || sort_by == "author_dsc" ) %] <option value="author_za" selected="selected">Autor (Z-A)</option>
[% ELSE %] <option value="author_za">Autor (Z-A)</option>
[% END %] </optgroup>
<optgroup label="Signatura topográfica">
[% IF ( sort_by == "call_number_asc" ) %] <option value="call_number_asc" selected="selected">Signatura topográfica (9-0 a A-Z)</option>
[% ELSE %] <option value="call_number_asc">Signatura topográfica (9-0 a A-Z)</option>
[% END %] [% IF ( sort_by == "call_number_dsc" ) %] <option value="call_number_dsc" selected="selected">Signatura topográfica (Z-A a 9-0)</option>
[% ELSE %] <option value="call_number_dsc">Signatura topográfica (Z-A a 9-0)</option>
[% END %] </optgroup>
<optgroup label="Fechas">
[% IF ( sort_by == "pubdate_dsc" ) %] <option value="pubdate_dsc" selected="selected">Fecha de publicación: de recientes a antiguos</option>
[% ELSE %] <option value="pubdate_dsc">Fecha de publicación: de recientes a antiguos</option>
[% END %] [% IF ( sort_by == "pubdate_asc" ) %] <option value="pubdate_asc" selected="selected">Fecha de publicación: de antiguos a recientes</option>
[% ELSE %] <option value="pubdate_asc">Fecha de publicación: de antiguos a recientes</option>
[% END %] [% IF ( sort_by == "acqdate_dsc" ) %] <option value="acqdate_dsc" selected="selected">Fecha de adquisición: de recientes a antiguos</option>
[% ELSE %] <option value="acqdate_dsc">Fecha de adquisición: de recientes a antiguos</option>
[% END %] [% IF ( sort_by == "acqdate_asc" ) %] <option value="acqdate_asc" selected="selected">Fecha de adquisición: de antiguos a recientes</option>
[% ELSE %] <option value="acqdate_asc">Fecha de adquisición: de antiguos a recientes</option>
[% END %] </optgroup>
<optgroup label="Título">
[% IF ( sort_by == "title_az" || sort_by == "title_asc" ) %] <option value="title_az" selected="selected">Título (A-Z)</option>
[% ELSE %] <option value="title_az">Título (A-Z)</option>
[% END %] [% IF ( sort_by == "title_za" || sort_by == "title_dsc" ) %] <option value="title_za" selected="selected">Título (Z-A)</option>
[% ELSE %] <option value="title_za">Título (Z-A)</option>
[% END %] </optgroup>

