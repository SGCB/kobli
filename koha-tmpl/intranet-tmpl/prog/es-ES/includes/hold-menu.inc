[% IF ( borrowernumber ) %] <div class="patroninfo"><h5>[% borrowerfirstname %] [% borrowersurname %]</h5>
<ul>
 <li>[% IF ( borrowerstreetaddress ) %] [% borrowerstreetaddress %], [% ELSE %] <span class="problem">No se le ha asignado una dirección al socio.</span>
 [% END %]</li>
 <li> [% IF ( borrowercity ) %] [% borrowercity %] [% ELSE %] Ninguna ciudad almacenada. [% END %]</li>
 <li> [% IF ( borrowerphone ) %] [% borrowerphone %] [% ELSE %] <span class="problem">Ningún teléfono guardado.</span> 
 [% END %]</li>
 <li>[% borrowerphonepro %]</li>
 <li>[% borrowermobile %]</li>
 [% IF ( borroweremail ) %] <li> <a href="mailto:[% email %]">[% borroweremail %]</a></li>
 [% END %] [% IF ( borroweremailpro ) %] <li> <a href="mailto:[% emailpro %]">[% borroweremailpro %]</a></li>
 [% END %] <li>Categoría: [% borrowercategorycode %]</li>
</ul></div>
<div class="patronviews">
<ul><li><a href="/cgi-bin/koha/members/moremember.pl?borrowernumber=[% borrowernumber %]">Detalle</a></li>
 <li><a href="/cgi-bin/koha/members/boraccount.pl?borrowernumber=[% borrowernumber %]">Multas</a></li>
 [% IF ( intranetreadinghistory ) %]<li><a href="/cgi-bin/koha/members/readingrec.pl?borrowernumber=[% borrowernumber %]">Registro de Lectura</a></li>[% END %] [% IF ( CAN_user_parameters ) %]<li><a href="/cgi-bin/koha/tools/viewlog.pl?do_it=1&amp;modules=MEMBERS&amp;action=MODIFY&amp;object=[% borrowernumber %]">Registro de modificaciones</a></li>[% END %]</ul>
</div>
[% END %] 