<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Fund Admin Resident Search Box -->

<div id="header_search">
 <div id="budgets_search" class="residentsearch">
 <p class="tip">Buscar fondos:</p>
 <form action="/cgi-bin/koha/admin/aqbudgets.pl" method="post">
 <label for="filter_budgetname">Código del fondo: </label><input type="text" name="filter_budgetname" id="filter_budgetname" size="20" value="[% filter_budgetname %]" />
 <label for="filter_budgetbranch">Biblioteca: </label>
 <select name="filter_budgetbranch" id="filter_budgetbranch" style="width:10em;">
 <option value=""></option>
 [% FOREACH branchloo IN branchloop %] [% IF ( branchloo.selected ) %] <option value="[% branchloo.value %]" selected="selected">[% branchloo.branchname %]</option>
 [% ELSE %] <option value="[% branchloo.value %]" >[% branchloo.branchname %]</option>
 [% END %] [% END %] </select>
 <input type="hidden"  name="budget_period_id" value="[% budget_period_id %]" />
 <input value="Enviar" name="filter" type="submit" class="submit" />
 </form>
 </div>

[% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Introduzca palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Introduzca los términos de búsqueda." class="form-text" size="40" />
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>[% END %] <ul>
 <li><a href="#budgets_search">Buscar fondos</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul>
</div>
</div>
<!-- End Suggestions Resident Search Box -->
