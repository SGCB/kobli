[% IF ( subscriptionid ) %] <ul>
<li><a href="serials-collection.pl?subscriptionid=[% subscriptionid %]">Colección de publicaciones periódicas</a></li>
 [% IF ( routing && CAN_user_serials_routing ) %] [% IF ( hasRouting ) %] <li><a href="/cgi-bin/koha/serials/routing.pl?subscriptionid=[% subscriptionid %]">Editar lista de enrutamiento</a></li>
 [% ELSE %] <li><a href="/cgi-bin/koha/serials/routing.pl?subscriptionid=[% subscriptionid %]&amp;op=new">Crear lista de ruteo</a></li>
 [% END %] [% END %] </ul>
[% END %] <ul>
 [% IF ( CAN_user_serials_claim_serials ) %] <li><a href="/cgi-bin/koha/serials/claims.pl">Reclamos</a></li>
 [% END %] [% IF ( CAN_user_serials_check_expiration ) %] <li><a href="/cgi-bin/koha/serials/checkexpiration.pl">Controlar vencimiento</a></li>
 [% END %] </ul>
