<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Acquisitions Resident Search Box -->
<div id="header_search">
<div id="supplier_search" class="residentsearch">
 <p class="tip">Buscar proveedores:</p>
 <form name="findsupplier" action="/cgi-bin/koha/acqui/booksellers.pl" method="post">
 <input type="text" size="25" name="supplier" id="supplier" class="focus" />
 <input value="Enviar" type="submit" class="submit" /></form>
</div>
 <div id="orders_search" class="residentsearch">
 <p class="tip">Buscar pedidos:</p>
 
 <form action="/cgi-bin/koha/acqui/histsearch.pl" method="post">
 <label for="title">Título: </label> <input type="text" id="title" name="title" size="15" value="[% title %]" />
 <label for="searchsupplier">Proveedor:</label> <input type="text" id="searchsupplier" name="name" size="15" value="[% name|html %]" />
 <input type="hidden" id="do_search" name="do_search" value="do" />
 <span class="filteraction" id="filteraction_off" style="display:none"> <a href="#" onclick="$('#filters,.filteraction').toggle();">[-]</a></span>
 <span class="filteraction" id="filteraction_on"> <a href="#" onclick="$('#filters,.filteraction').toggle();">[+]</a></span>
 <input value="Enviar" class="submit" type="submit" /> <a href="/cgi-bin/koha/acqui/histsearch.pl">Búsqueda avanzada</a>
 <p id="filters" style="display:none">
 <label for="basket">Bolsa: </label><input type="text" name="basket" id="basket" />
 <label for="booksellerinvoicenumber">Factura Nro.: </label><input type="text" name="booksellerinvoicenumber" id="booksellerinvoicenumber" />
 </p>
 </form>
 </div> 
 <ul id="tabtriggers">
 <li><a href="#supplier_search">Búsqueda de proveedor</a></li>
 <li><a href="#orders_search">Búsqueda de pedidos</a></li>
 </ul> 
</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Acquisitions Resident Search Box -->
