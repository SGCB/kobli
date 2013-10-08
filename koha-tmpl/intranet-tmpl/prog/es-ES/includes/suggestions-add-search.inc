<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Suggestions Resident Search Box -->
<div id="header_search">
 <div id="suggestions_search" class="residentsearch">
 <p class="tip">Búsqueda de sugerencias:</p>
 <form action="/cgi-bin/koha/acqui/newordersuggestion.pl" method="get">
 <input type="hidden" name="booksellerid" value="[% booksellerid %]" />
 <label for="searchtitle">Título:</label> <input type="text" id="searchtitle" name="title" size="10" value="[% title %]" />
 <label for="searchauthor">Autor:</label> <input type="text" id="searchauthor" name="author" size="10" value="[% author %]" />
 <label for="searchpublishercode">Editor:</label> <input type="text" id="searchpublishercode" name="publishercode" size="10" value="[% publishercode %]" />
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
 <li><a href="#suggestions_search">Buscar sugerencias</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul>
</div>
</div><!-- /gradient -->
<!-- End Suggestions Resident Search Box -->
