
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Currencies Resident Search Box -->
<div id="header_search">
 <div id="currency_search" class="residentsearch">
 <p class="tip">Currencies search:</p>
 <form action="[% script_name %]" method="post">
 <input type="text" name="description" size="40" value="[% searchfield %]" />
 <input value="Buscar" name="search" type="submit" class="submit" />
 </form> 
 </div>
 [% INCLUDE 'patron-search-box.inc' %]
 [% IF ( CAN_user_catalogue ) %]
 <div id="catalog_search" class="residentsearch" style="display:none;">
 <p class="tip">Ingresa palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Ingresa los términos que deseas buscar." class="form-text" size="40" />
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>[% END %]
 <ul>
 <li><a href="/cgi-bin/koha/admin/currency.pl#currency_search">Search currencies</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="/cgi-bin/koha/circ/circulation.pl#circ_search">Check out</a></li>[% END %]
 [% IF ( CAN_user_catalogue ) %]<li><a href="/cgi-bin/koha/catalogue/search.pl#catalog_search">Search the catalog</a></li>[% END %]
 </ul> 
</div>
<!-- End Currencies Resident Search Box -->
