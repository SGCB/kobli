[% IF ( item.datedue ) %] [% IF ( OPACShowCheckoutName ) %] Prestado a [% item.cardnumber %] [% item.firstname %] [% item.surname %] [% ELSE %] Prestado [% END %] [% ELSIF ( item.transfertwhen ) %] En ruta desde [% item.transfertfrom %] a [% item.transfertto %] desde [% item.transfertwhen %] [% ELSIF ( item.waiting ) %] Reservado [% ELSIF ( item.wthdrawn ) %] Artículo retirado [% ELSIF ( item.itemlost ) %] [% IF ( item.lostimageurl ) %] <img src="[% item.lostimageurl %]" alt="[% item.lostimagelabel %]" title="[% item.lostimagelabel %]">
 [% ELSE %] Artículo perdido [% END %] [% ELSIF ( item.itemnotforloan ) %] [% IF ( item.notforloanvalue ) %] [% item.notforloanvalue %] [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% ELSE %] No disponible para préstamo [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% END %] [% ELSIF ( item.notforloan_per_itemtype ) %] No disponible para préstamo [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% ELSIF ( item.damaged ) %] Artículo dañado [% ELSE %] Disponible [% IF ( item.restrictedopac ) %]<span class="restricted">([% item.restrictedopac %])</span>[% END %] [% END %] 