<div class="gradient">
 <h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Serials Resident Search Box -->
 <div id="header_search">
 <div id="subscription_search" class="residentsearch">
 <p class="tip">Buscar suscripciones:</p>
 <form action="/cgi-bin/koha/serials/serials-search.pl" method="get">
 [% IF ( routing ) %] <input type="hidden" name="routing" value="[% routing %]" />
 [% END %] <input type="hidden" name="searched" value="1" />
 <label for="ISSN_filter">ISSN:</label> <input type="text" size="10" maxlength="11" name="ISSN_filter" id="ISSN_filter" value="[% ISSN_filter %]" />

 [% IF (UNIMARC) %] <label for="EAN_filter">EAN:</label> <input type="text" size="20" maxlength="40" name="EAN_filter" id="EAN_filter" value="[% EAN_filter %]" />
 [% END %] <label for="title_filter">Título:</label> <input type="text" size="20" maxlength="40" name="title_filter" id="title_filter" value="[% title_filter %]" />
 <input value="Enviar" class="submit" type="submit" /> <a href="/cgi-bin/koha/serials/serials-search.pl">Búsqueda avanzada</a>
 </form>
 </div>
 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Introduzca palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Introduzca los términos de búsqueda." class="form-text" size="40" />
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 [% END %] <ul>
 <li><a href="#subscription_search">Buscar suscripciones</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul>
 </div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Serials Resident Search Box -->
