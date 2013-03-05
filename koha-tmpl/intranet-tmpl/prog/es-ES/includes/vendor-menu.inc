[% IF ( booksellerid ) %] <div id="menu">
 <ul>
 [% IF ( CAN_user_acquisition_order_manage ) %]<li><a href="/cgi-bin/koha/acqui/booksellers.pl?booksellerid=[% booksellerid %]">Bolsas</a></li>[% END %] [% IF ( CAN_user_acquisition_group_manage ) %]<li><a href="/cgi-bin/koha/acqui/basketgroup.pl?booksellerid=[% booksellerid %]">Bolsas de grupos</a></li>[% END %] [% IF ( CAN_user_acquisition_contracts_manage ) %]<li><a href="/cgi-bin/koha/admin/aqcontract.pl?booksellerid=[% booksellerid %]">Contratos</a></li>[% END %] <li><a href="/cgi-bin/koha/acqui/invoices.pl?supplierid=[% booksellerid %]&amp;op=do_search">Facturas</a></li>
 [% IF ( CAN_user_acquisition_order_manage ) %][% IF ( basketno ) %] <li><a href="/cgi-bin/koha/acqui/uncertainprice.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]&amp;owner=1">Precios inciertos</a></li>
 [% ELSE %] <li><a href="/cgi-bin/koha/acqui/uncertainprice.pl?booksellerid=[% booksellerid %]&amp;owner=1">Precios inciertos</a></li>
 [% END %] [% END %] </ul>
</div>
[% END %] 