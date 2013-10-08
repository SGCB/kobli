<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Notices Resident Search Box -->
<div id="header_search">
 <div id="notices_search" class="residentsearch">
 <p class="tip">Buscar avisos existentes:</p>
<form action="/cgi-bin/koha/tools/letter.pl" method="post">
 <input type="text" name="searchfield" size="40" value="" />
 <input value="Buscar" name="search" type="submit" class="submit" />
 </form> 
 </div>
 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Introduzca palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Introduzca los términos de búsqueda." class="form-text" size="40" />
 <input value="Enviar" name="op" type="submit" class="submit" />
 </form>
 </div>[% END %] <ul>
 <li><a href="#notices_search">Buscar avisos</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul> 
</div>
</div><!-- /gradient -->
<!-- End Notices Resident Search Box -->
