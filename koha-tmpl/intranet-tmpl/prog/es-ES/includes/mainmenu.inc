 <div class="yui-b">

 <ul id="navigation">
 [% IF ( CAN_user_circulate ) %] <li> <a href="/cgi-bin/koha/circ/circulation.pl">Circulación</a><ul>
 <li>
 <form method="post" action="/cgi-bin/koha/circ/circulation.pl">
 <label for="navfindborrower">Prestar a:</label>
 <input id="navfindborrower" name="findborrower" type="text" size="10" />
 <input type="hidden" name="branch" value="[% branch %]" />
 <input type="hidden" name="printer" value="[% printer %]" />
 <input type="submit" class="submit" value="OK" />
 </form>
 </li>
 <li><a accesskey="r" href="/cgi-bin/koha/circ/returns.pl">Devolución</a></li>
 <li><a href="/cgi-bin/koha/circ/branchtransfers.pl">Transferencias</a></li>
 </ul></li>
 [% END %] [% IF ( CAN_user_borrowers ) %] <li><a href="/cgi-bin/koha/members/members-home.pl">Socios</a><ul>
 <li><form action="/cgi-bin/koha/members/member.pl" method="post">
 <label for="navmember">Buscar:&nbsp;</label>
 <input id="navmember" type="text" size="10" name="member" />
 <input type="submit" value="OK" class="submit" />
 </form>
 </li>
 </ul></li>
 
 [% END %] [% IF ( CAN_user_catalogue ) %] <li><a href="/cgi-bin/koha/catalogue/search.pl">Catálogo</a><ul>
 <li>
 <form name="searchform" method="get" action="/cgi-bin/koha/catalogue/search.pl" id="searchform">
 <input type="hidden" name="idx" value="" />
 <label for="navkeyword">
 Buscar:&nbsp; </label><input type="text" id="navkeyword" name="q" size="10" accesskey="s" />
 <input type="submit" value=" OK " class="submit" />
 </form>
 </li>
 <li><a href="/cgi-bin/koha/virtualshelves/shelves.pl">Listas</a></li>
 </ul></li>
 
 [% END %] [% IF ( CAN_user_editcatalogue_edit_catalogue ) %] <li><a href="/cgi-bin/koha/cataloguing/addbooks.pl">Catalogación</a><ul>
 <li><a href="/cgi-bin/koha/cataloguing/addbiblio.pl">Agregar registro MARC</a></li>
 <li><a href="/cgi-bin/koha/authorities/authorities-home.pl">Autoridades</a></li>
 [% END %] [% IF ( CAN_user_serials ) %] <li><a href="/cgi-bin/koha/serials/serials-home.pl">Publicaciones periódicas</a></li>
 [% END %] [% IF ( CAN_user_editcatalogue ) %] </ul></li>
 
 <li><a href="/cgi-bin/koha/acqui/acqui-home.pl">Adquisiciones</a></li>
 [% END %] [% IF ( CAN_user_reports ) %] <li><a href="/cgi-bin/koha/reports/reports-home.pl">Informes</a></li>
 [% END %] [% IF ( CAN_user_parameters ) %] <li> <a href="/cgi-bin/koha/admin/admin-home.pl">Administración de Koha</a><ul>
 <li><a href="/cgi-bin/koha/admin/systempreferences.pl">Preferencias del sistema</a></li>
 </ul></li>
 
 [% END %] [% IF ( CAN_user_tools ) %] <li><a href="/cgi-bin/koha/tools/tools-home.pl">Herramientas</a></li>
 [% END %] <li><a href="/cgi-bin/koha/about.pl">Acerca de Koha</a></li>
 </ul>
 [% IF ( IntranetNav ) %] [% IntranetNav %] [% END %] </div>
</div>
