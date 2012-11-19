<ul>
 <li><a href="/cgi-bin/koha/acqui/lateorders.pl">Órdenes atrasadas</a></li>
 [% IF ( suggestion ) %]<li><a href="/cgi-bin/koha/suggestion/suggestion.pl">Sugerencias</a></li>[% ELSE %][% END %] <li><a href="/cgi-bin/koha/acqui/invoices.pl">Facturas</a></li>
 [% IF ( CAN_user_acquisition_budget_manage ) %] <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl">Presupuestos</a></li>
 <li><a href="/cgi-bin/koha/admin/aqbudgets.pl">Fondos</a></li>
 [% END %] [% IF ( CAN_user_parameters ) %] <li><a href="/cgi-bin/koha/admin/currency.pl">Monedas</a></li>
 [% END %] </ul>
