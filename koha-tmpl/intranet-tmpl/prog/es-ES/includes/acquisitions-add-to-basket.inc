<fieldset id="acqui_basket_add">
 <legend>Agregar pedido a la bolsa</legend>
 [% IF has_budgets %] <ul>
 <li>
 <label for="q">De un registro existente: </label>
 <form action="/cgi-bin/koha/acqui/neworderbiblio.pl" method="post">
 <input type="hidden" name="booksellerid" value="[% booksellerid %]" />
 <input type="hidden" name="basketno" value="[% basketno %]" />
 <input id="q" type="text"  size="25" name="q" />
 <input value="Buscar" type="submit" class="submit" />
 </form>
 </li>
 <li><a href="/cgi-bin/koha/acqui/newordersuggestion.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]">Desde una sugerencia</a></li>
 <li><a href="/cgi-bin/koha/acqui/newordersubscription.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]">Desde una suscripción</a></li>
 <li><a href="/cgi-bin/koha/acqui/neworderempty.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]">Desde un nuevo registro (vacío)</a></li>
 <li><a href="/cgi-bin/koha/acqui/z3950_search.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]">De una fuente externa</a></li>
 <li><a href="/cgi-bin/koha/acqui/addorderiso2709.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]"> De un archivo preparado</a></li>
 </ul>
 [% ELSE %] Usted no puede crear ordenes a menos que primero <a href="/cgi-bin/koha/admin/aqbudgetperiods.pl">definir un presupuesto y un fondo</a>. [% END %] </fieldset>
