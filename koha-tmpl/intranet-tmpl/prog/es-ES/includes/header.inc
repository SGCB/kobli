 <div id="header" class="navbar navbar-static-top">
 <div class="navbar-inner">
 <ul id="toplevelmenu" class="nav">
 [% IF ( CAN_user_circulate ) %]<li><a href="/cgi-bin/koha/circ/circulation-home.pl">Circulación</a></li>[% END %] [% IF ( CAN_user_borrowers ) %]<li><a href="/cgi-bin/koha/members/members-home.pl">Socios</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="/cgi-bin/koha/catalogue/search.pl">Buscar</a></li>[% END %] [% IF ( intranetbookbag ) %] <li><a href="#" id="cartmenulink">Cesta<span id="basketcount"></span></a></li>
 [% END %] [% IntranetNav %] <li class="dropdown">
 <a href="#" class="dropdown-toggle" data-toggle="dropdown">Más<b class="caret"></b></a>
 <ul class="dropdown-menu">
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
 </li>
 </ul>
 <ul class="nav pull-right">
 <li class="dropdown">
 <a href="#" id="drop3" role="button" class="dropdown-toggle" data-toggle="dropdown">
 [% IF ( loggedinusername ) %] <span class="loggedinusername">
 [% loggedinusername %] </span>
 <span class="separator">|</span>
 [% IF ( AutoLocation ) %] <brand>
 [% LoginBranchname %] </brand>
 [% ELSE %] <strong>
 [% IF ( LoginBranchname == 'NO_LIBRARY_SET' ) %] NO SE ESTABLECIÓ BIBLIOTECA [% ELSE %] [% LoginBranchname %] [% END %] </strong>
 [% END %] <b class="caret"></b>
 </a>
 <ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
 [% IF ( IndependantBranches ) %] [% IF ( CAN_user_management || CAN_user_editcatalogue_edit_catalogue ) %] <li>
 <a class="toplinks" href="/cgi-bin/koha/circ/selectbranchprinter.pl">Seleccionar Biblioteca</a>
 </li>
 [% END %] [% ELSE %] <li>
 <a class="toplinks" href="/cgi-bin/koha/circ/selectbranchprinter.pl">Seleccionar Biblioteca</a>
 </li>
 [% END %] [% IF ( intranetbookbag ) %] <li>
 <a class="toplinks" href="/cgi-bin/koha/mainpage.pl?logout.x=1" onclick="clearHoldFor(); delBasket('main', true);">Salir</a>
 </li>
 [% ELSE %] <li>
 <a class="toplinks" href="/cgi-bin/koha/mainpage.pl?logout.x=1" onclick="clearHoldFor();">Salir</a>
 </li>
 ) | [% END %] [% ELSE %] Debe acceder al sistema  | [% END %] </ul>
 <li>
 <a class="toplinks" href="/cgi-bin/koha/help.pl" id="helper" onclick="var link=window.open('','Koha_Help','width=600,height=600,toolbar=false,scrollbars=yes'); link.location='/cgi-bin/koha/help.pl'; return false;">Ayuda</a>
 </li>
 </li>
 </ul>
 </div>
 </div>
[% IF ( intranetbookbag ) %]<div id="cartDetails">Su carro está vacío</div>[% END %] </div>