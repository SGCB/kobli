 [% IF ( intranetbookbag ) %]<div id="cartDetails">Su carro está vacío</div>[% END %] <div id="header" class="clearfix">
 <div id="toplevelnav">
 <ul id="toplevelmenu">
 [% IF ( CAN_user_circulate ) %]<li><a class="toplinks" href="/cgi-bin/koha/circ/circulation-home.pl">Circulación</a></li>[% END %] [% IF ( CAN_user_borrowers ) %]<li><a class="toplinks" href="/cgi-bin/koha/members/members-home.pl">Socios</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a class="toplinks" href="/cgi-bin/koha/catalogue/search.pl">Buscar</a></li>[% END %] [% IF ( intranetbookbag ) %] <li><a class="toplinks" href="#" id="cartmenulink">Carrito<span id="basketcount"></span></a></li>
 [% END %] [% IntranetNav %] <li class="more">
 <a class="toplinks" id="showmore" href="/cgi-bin/koha/mainpage.pl">Mas</a>
 <div id="moremenu">
 <div class="bd">
 <ul>
 <li><a href="/cgi-bin/koha/virtualshelves/shelves.pl">Listas</a></li>
 [% IF ( CAN_user_editcatalogue_edit_catalogue || CAN_user_editcatalogue_edit_items ) %] <li><a href="/cgi-bin/koha/cataloguing/addbooks.pl">Catalogación</a></li>
 [% END %] [% IF ( CAN_user_acquisition ) %] <li><a href="/cgi-bin/koha/acqui/acqui-home.pl">Adquisiciones</a></li>
 [% END %] [% IF ( CAN_user_editauthorities ) %] <li><a href="/cgi-bin/koha/authorities/authorities-home.pl">Autoridades</a></li>
 [% END %] [% IF ( CAN_user_serials ) %] <li><a href="/cgi-bin/koha/serials/serials-home.pl">Publicaciones periódicas</a></li>
 [% END %] [% IF ( CAN_user_reports ) %] <li><a href="/cgi-bin/koha/reports/reports-home.pl">Informes</a></li>
 [% END %] [% IF ( CAN_user_tools ) %] <li><a href="/cgi-bin/koha/tools/tools-home.pl">Herramientas</a></li>
 [% END %] [% IF ( CAN_user_parameters ) %] <li><a href="/cgi-bin/koha/admin/admin-home.pl">Administración</a></li>
 [% END %] <li><a href="/cgi-bin/koha/about.pl">Acerca de Koha</a></li>
 </ul>
 </div>
 </div>
 </li>
 </ul>
 </div>
 <div id="login">
 [% IF ( AutoLocation ) %] <strong>
 [% LoginBranchname %] </strong>
 [% ELSE %] <strong>
 [% IF ( LoginBranchname == 'NO_LIBRARY_SET' ) %] NO SE ESTABLECIÓ BIBLIOTECA [% ELSE %] [% LoginBranchname %] [% END %] </strong>
 [% IF ( IndependantBranches ) %]
 [% IF ( CAN_user_management || CAN_user_editcatalogue_edit_catalogue ) %]
 ( <a class="toplinks" href="/cgi-bin/koha/circ/selectbranchprinter.pl">Seleccionar Biblioteca</a> )
 [% END %]
 [% ELSE %]
 ( <a class="toplinks" href="/cgi-bin/koha/circ/selectbranchprinter.pl">Seleccionar Biblioteca</a> ) [% END %] | [% END %] [% IF ( loggedinusername ) %] <span class="loggedinusername">
 [% loggedinusername %] </span>
 [% IF ( intranetbookbag ) %]
 ( <a class="toplinks" href="/cgi-bin/koha/mainpage.pl?logout.x=1" onclick="clearHoldFor(); delBasket('main', true);">Salir</a> ) |
 [% ELSE %]
 ( <a class="toplinks" href="/cgi-bin/koha/mainpage.pl?logout.x=1" onclick="clearHoldFor();">Salir</a> ) | [% END %] [% ELSE %] Usted no ha ingresado | [% END %] <a class="toplinks" href="/cgi-bin/koha/help.pl" id="helper" onclick="var link=window.open('','Koha_Help','width=600,height=600,toolbar=false,scrollbars=yes'); link.location='/cgi-bin/koha/help.pl'; return false;">[ ? ]</a>
 </div>
</div> 
