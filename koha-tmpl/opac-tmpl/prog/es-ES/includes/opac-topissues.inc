<div id="search-facets">
<h4>Refina su búsqueda</h4>
<form method="get" action="/cgi-bin/koha/opac-topissues.pl">
 <fieldset>
 <ol> <li><label for="limit">Mostrar los primeros </label> <select name="limit" id="limit" style="width: 10em;">
 [% IF ( limit == 10 ) %]<option value ="10" selected="selected">10 títulos</option>[% ELSE %]<option value="10">10 títulos</option>[% END %] [% IF ( limit == 15 ) %]<option value ="15" selected="selected">15 títulos</option>[% ELSE %]<option value="15">15 títulos</option>[% END %] [% IF ( limit == 20 ) %]<option value ="20" selected="selected">20 títulos</option>[% ELSE %]<option value="20">20 títulos</option>[% END %] [% IF ( limit == 30 ) %]<option value ="30" selected="selected">30 títulos</option>[% ELSE %]<option value="30">30 títulos</option>[% END %] [% IF ( limit == 40 ) %]<option value ="40" selected="selected">40 títulos</option>[% ELSE %]<option value="40">40 títulos</option>[% END %] [% IF ( limit == 50 ) %]<option value ="50" selected="selected">50 títulos</option>[% ELSE %]<option value="50">50 títulos</option>[% END %] [% IF ( limit == 100 ) %]<option value ="100" selected="selected">100 títulos</option>[% ELSE %]<option value="100">100 títulos</option>[% END %] </select>
 </li>
 <li>
 <label for="branch">De: </label>
 <select name="branch" id="branch" style="width: 10em;">
 <option value="">Todas las bibliotecas</option>
 [% FOREACH branchloo IN branchloop %] [% IF ( branch == branchname ) %]<option value="[% branchloo.value %]" selected="selected">[% ELSE %]<option value="[% branchloo.value %]">[% END %] [% branchloo.branchname %] </option>
 [% END %] </select>
 </li>
 <li><label for="itemtype">Limitar a: </label>
 <select name="itemtype" id="itemtype" style="width: 10em;">
 [% IF ( ccodesearch ) %]<option value="">Todas las colecciones</option>[% ELSE %]<option value="">Todos los tipos de ítems</option>[% END %] [% FOREACH itemtypeloo IN itemtypeloop %] [% IF ( itemtypeloo.selected ) %]<option value="[% itemtypeloo.value %]" selected="selected">[% ELSE %]<option value="[% itemtypeloo.value %]">[% END %] [% itemtypeloo.description %] </option>
 [% END %] </select></li>
 <li>
 <label for="timeLimit">Adquirido en los últimos:</label> <select name="timeLimit" id="timeLimit">
 [% IF ( timeLimit == 3 ) %]<option value="3" selected="selected">3 meses</option>[% ELSE %]<option value="3">3 meses</option>[% END %] [% IF ( timeLimit == 6 ) %]<option value="6" selected="selected">6 meses</option>[% ELSE %]<option value="6">6 meses</option>[% END %] [% IF ( timeLimit == 12 ) %]<option value="12" selected="selected">12 meses</option>[% ELSE %]<option value="12">12 meses</option>[% END %] [% IF ( timeLimit == 999 ) %]<option value="999" selected="selected">Sin límite</option>[% ELSE %]<option value="999">Sin límite</option>[% END %] </select>
 </li></ol>
 <input type="hidden" name="do_it" value="1" />
 
 </fieldset><fieldset class="action"><input value="Enviar" type="submit" /></fieldset>
 </form>
</div>
