
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Notices Resident Search Box -->
<div id="header_search">
 <div id="notices_search" class="residentsearch">
 <p class="tip">Search existing notices:</p>
<form action="/cgi-bin/koha/tools/letter.pl" method="post">
 <input type="text" name="searchfield" size="40" value="" />
 <input value="Buscar" name="search" type="submit" class="submit" />
 </form> 
 </div>
 [% INCLUDE 'patron-search-box.inc' %]
 [% IF ( CAN_user_catalogue ) %]
 <div id="catalog_search" class="residentsearch" style="display:none;">
 <p class="tip">Ingresa palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Ingresa los términos que deseas buscar." class="form-text" size="40" />
 <input value="Enviar" name="op" type="submit" class="submit" />
 </form>
 </div>[% END %]
 <ul>
 <li><a href="/cgi-bin/koha/admin/currency.pl#notices_search">Search notices</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="/cgi-bin/koha/circ/circulation.pl#circ_search">Check out</a></li>[% END %]
 [% IF ( CAN_user_catalogue ) %]<li><a href="/cgi-bin/koha/catalogue/search.pl#catalog_search">Search the catalog</a></li>[% END %]
 </ul> 
</div>
<!-- End Notices Resident Search Box -->
