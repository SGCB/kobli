<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Patrons Resident Search Box -->
<div id="header_search">
 <div id="patron_search" class="residentsearch">
 <p class="tip">Inserte el número de carnet del socio o parte de su apellido</p>
 <form action="/cgi-bin/koha/members/member.pl" method="post">
 <input id="searchmember" size="25" class="focus" name="member" type="text" value="[% member %]"/>
 [% IF ( branchloop ) %] <span class="filteraction" id="filteraction_off"> <a href="#" onclick="$('#filters').toggle();$('.filteraction').toggle();">[-]</a></span>
 <span class="filteraction" id="filteraction_on"> <a href="#" onclick="$('#filters').toggle();$('.filteraction').toggle();">[+]</a></span>
 [% END %] <label for="searchfields">Buscar campos:</label>
 <select name="searchfields" id="searchfields">
 <option selected="selected" value=''>Estándar</option>
 <option value='email,emailpro,B_email,'>Correo electrónico</option>
 <option value='borrowernumber'>Número de socio </option>
 <option value='phone,phonepro,B_phone,altcontactphone,mobile'>Número de teléfono</option>
 <option value='streettype,address,address2,city,state,zipcode,country'>Dirección </option>
 </select>

 <label for="searchtype">Buscar tipo:</label>
 <select name="searchtype" id="searchtype">
 <option selected="selected" value=''>Empezar con</option>
 <option value='contain'>Contiene</option>
 </select>

 <label for="orderby">Ordenado por: </label>
 <select name="orderby" id="searchorderby">
 <option value="">Apellido, Nombre</option>
 <option value="cardnumber,0">Número de Carnet</option>
 </select>
 <input value="Buscar" class="submit" type="submit" />
 [% IF ( branchloop ) %] <p id="filters"> <label for="branchcode">Biblioteca: </label><select name="branchcode" id="branchcode">
 <option value="">Cualquiera</option>[% FOREACH branchloo IN branchloop %] [% IF ( branchloo.selected ) %] <option value="[% branchloo.value %]" selected="selected">[% branchloo.branchname %]</option>[% ELSE %] <option value="[% branchloo.value %]">[% branchloo.branchname %]</option>[% END %] [% END %]</select>
 <label for="categorycode">Categoría: </label><select name="categorycode" id="categorycode">
 <option value="">Cualquiera</option>[% FOREACH categorie IN categories %] [% IF ( categorie.selected ) %] <option value="[% categorie.categorycode %]" selected="selected">[% categorie.description %]</option>[% ELSE %] <option value="[% categorie.categorycode %]">[% categorie.description %]</option>[% END %] [% END %]</select>
 </p>
 [% END %] </form>
 </div>

 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Ingrese palabras clave para la búsqueda:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Ingrese los términos de búsqueda." class="form-text" size="40" />
 <input value="Enviar" name="op" type="submit" id="opac-submit" class="submit" />
 </form>
 </div>[% END %] [% IF ( CAN_user_circulate ) %] <div id="checkin_search" class="residentsearch">
 <p class="tip">Ingrese código de barras para devolución:</p>
 <form method="post" action="/cgi-bin/koha/circ/returns.pl" autocomplete="off">
 <input name="barcode" id="ret_barcode" size="40" accesskey="r" />
 <input value="Enviar" class="submit" type="submit" />
 </form>
 </div>
 [% END %] <ul>
 <li><a href="#patron_search">Buscar socios</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Préstamo</a></li>[% END %] [% IF ( CAN_user_circulate ) %]<li><a href="#checkin_search">Devolución</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Buscar en el catálogo</a></li>[% END %] </ul>
</div><!-- /header_search -->
</div><!-- /gradient -->
<script type="text/javascript">//<![CDATA[
$(document).ready(function() {
    [% IF ( advsearch ) %]$("#filteraction_on").toggle();
    [% ELSE %]$("#filters").toggle();
    $("#filteraction_off").toggle();[% END %]
});
//]]>
</script>
<!-- End Patrons Resident Search Box -->
