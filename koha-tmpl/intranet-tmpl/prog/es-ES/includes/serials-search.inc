<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Serials Resident Search Box -->
<div id="header_search">
 <div id="subscription_search" class="residentsearch">
 <p class="tip">Search subscriptions:</p>
 <form action="/cgi-bin/koha/serials/serials-home.pl" method="get">[% IF ( routing ) %]<input type="hidden" name="routing" value="[% routing %]" />[% END %]<input type="hidden" name="searched" value="1" /> <label for="ISSN_filter">ISSN:</label> <input type="text" size="10" maxlength="11" name="ISSN_filter" id="ISSN_filter" value="[% ISSN_filter %]" /> <label for="title_filter">Título:</label> <input type="text" size="20" maxlength="40" name="title_filter" id="title_filter" value="[% title_filter %]" /><input value="Buscar" type="submit" class="submit" />
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
 </div>
 [% END %]
 <ul>
 <li><a href="/cgi-bin/koha/serials/serials-home.pl#subscription_search">Search subscriptions</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="/cgi-bin/koha/circ/circulation.pl#circ_search">Check out</a></li>[% END %]
 [% IF ( CAN_user_catalogue ) %]<li><a href="/cgi-bin/koha/catalogue/search.pl#catalog_search">Search the catalog</a></li>[% END %]
 </ul> 
</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Serials Resident Search Box -->
