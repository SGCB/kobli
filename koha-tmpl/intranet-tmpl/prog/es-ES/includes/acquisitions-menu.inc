<ul>
 <li><a href="/cgi-bin/koha/acqui/lateorders.pl">Pedidos atrasados</a></li>
 [% IF ( suggestion ) %]<li><a href="/cgi-bin/koha/suggestion/suggestion.pl">Sugerencias</a></li>[% ELSE %][% END %]
 [% IF ( CAN_user_acquisition_budget_manage ) %]
 <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl">Budgets &amp; funds</a></li>
 [% END %]
 [% IF ( CAN_user_parameters ) %]
 <li><a href="/cgi-bin/koha/admin/currency.pl">Divisas</a></li>
 [% END %]
</ul>
