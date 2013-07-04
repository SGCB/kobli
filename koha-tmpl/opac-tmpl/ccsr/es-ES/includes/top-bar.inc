<div id="top-bar">
<ul id="menu-left">
 <!-- [% IF ( opacbookbag ) %] -->
 <li>
 <span id="cmspan"></span>
 <div id="cartDetails">Su bolsa de libros está vacía.</div>
 </li>
 <!-- [% END %] -->

 [% IF ( virtualshelves ) %]

 <li id="listsmenulink">
 <a href="/cgi-bin/koha/opac-shelves.pl"  class="">
 <span>Listas</span>
 </a>
 <div id="listsmenu" class="yuimenu" style="display: none">
 <h4>Listas públicas</h4>
 [% IF ( pubshelves ) %] <ul class="first-of-type">
 [% FOREACH pubshelvesloo IN pubshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]">[% pubshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves">[Ver todo]</a></li>
 </ul>
 [% ELSE %] No hay listas públicas [% END %] [% IF ( opacuserlogin ) %] <h4>Sus listas</h4>
 [% IF ( loggedinusername ) %] [% IF ( barshelves ) %] <ul class="first-of-type">
 [% FOREACH barshelvesloo IN barshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]">[% barshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Ver todo]</a></li>
 </ul>
 [% ELSE %] <ul class="first-of-type">
 <li>No hay listas privadas</li>
 <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Nueva lista]</a></li></ul>
 [% END %] [% ELSE %] <ul class="first-of-type"><li><a href="/cgi-bin/koha/opac-user.pl">Ingrese para crear sus propias listas</a></li></ul>
 [% END %] [% END %] </div><!-- /listmenu /virtualshelves -->
[% END %]
<div id="listsDetails"></div>

</li>
</ul>

 <div id="members">
 [% IF ( opacuserlogin ) %] <ul>
 [% UNLESS ( loggedinusername ) %] <li><a href="/cgi-bin/koha/opac-user.pl">Ingresar a su cuenta</a></li>[% END %] [% IF ( loggedinusername ) %] <li><span class="members">Bienvenido, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></span></li>

 [% END %] [% IF ( ShowOpacRecentSearchLink ) %] <li><a href="/cgi-bin/koha/opac-search-history.pl" title="Ver su historial de búsqueda">Historial de búsqueda</a></li>
 [% END %] [% IF ( loggedinusername ) %]<li>[% IF persona %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1" onclick='navigator.id.logout();'>[% ELSE %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">[% END %]Cerrar sesión</a></li>[% END %] </ul>
 [% END %] </div>

 <div class="clear"></div>

</div>
