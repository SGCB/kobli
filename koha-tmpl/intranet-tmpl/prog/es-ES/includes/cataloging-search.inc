<script>$(document).ready(function(){
	$("input[name=q]:eq(0)").focus();
});</script>

<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Cataloging Resident Search Box -->
<div id="header_search">
<div id="addbooks_search" class="residentsearch">
 <p class="tip">Buscar en el catálogo y el depósito:</p>
 <form name="search" action="addbooks.pl">
 <input type="text" name="q" size="40" />
 <input value="Enviar" type="submit" class="submit" />
 </form>
</div>
 [% INCLUDE 'patron-search-box.inc' %] <ul>
 <li><a href="#addbooks_search">Búsqueda en catalogación</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] </ul> 
</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Cataloging Resident Search Box -->
