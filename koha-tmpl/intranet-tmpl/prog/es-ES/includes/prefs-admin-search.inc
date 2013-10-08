<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Stopwords Resident Search Box -->
<div id="header_search">
 <div id="syspref_search" class="residentsearch">
 <p class="tip">Búsqueda de preferencias del sistema</p>
 <form action="/cgi-bin/koha/admin/preferences.pl">
 <input type="hidden" name="tab" value="[% last_tab %]" />
 <input type="hidden" name="op" value="search" />
 <input type="text" size="40" name="searchfield" value="[% searchfield |html %]" />
 <input value="Buscar" type="submit" class="submit" />
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
 <li><a href="#syspref_search">Buscar preferencias del sistema</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul>
</div>
</div>
<!-- End Stopwords Resident Search Box -->
