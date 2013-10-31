<script type="text/javascript">//<![CDATA[
    $(document).ready(function() {
        var path = location.pathname.substring(1);
        var url = window.location.toString();
        var params = '';
        if ( url.match(/\?(.+)$/) ) {
            params = "?" + RegExp.$1;
        }
        $('#navmenulist a[href$="/' + path + params + '"]').css('font-weight','bold');
    });
//]]>
</script>
<div id="navmenu">
<div id="navmenulist">
<h5>Preferencias del sistema</h5>
<ul>
 <li><a href="/cgi-bin/koha/admin/preferences.pl">Preferencias del sistema</a></li>
</ul>

<h5>Parámetros básicos</h5>
<ul>
 <li><a href="/cgi-bin/koha/admin/branches.pl">Bibliotecas y grupos</a></li>
 <li><a href="/cgi-bin/koha/admin/itemtypes.pl">Tipos de ítem</a></li>
 <li><a href="/cgi-bin/koha/admin/authorised_values.pl">Valores autorizados</a></li>
</ul>

<h5>Usuarios y circulación</h5>
<ul>
 <li><a href="/cgi-bin/koha/admin/categorie.pl">Tipos y categorías de usuario</a></li>
 <li><a href="/cgi-bin/koha/admin/smart-rules.pl">Reglas de circulación y multas</a></li>
 <li><a href="/cgi-bin/koha/admin/patron-attr-types.pl">Tipos de atributo de usuario</a></li>
 <li><a href="/cgi-bin/koha/admin/branch_transfer_limits.pl">Límites de transferencia de la biblioteca</a></li>
 <li><a href="/cgi-bin/koha/admin/transport-cost-matrix.pl">Transporte matriz de costos</a></li>
 <li><a href="/cgi-bin/koha/admin/item_circulation_alerts.pl">Alertas de circulación de ítems</a></li>
 <li><a href="/cgi-bin/koha/admin/cities.pl">Ciudades y pueblos</a></li>
 <li><a href="/cgi-bin/koha/admin/roadtype.pl">Tipos de camino</a></li>
</ul>

<h5>Catálogo</h5>
<ul>
 <li><a href="/cgi-bin/koha/admin/biblio_framework.pl">Plantilla bibliográfica MARC</a></li>
 <li><a href="/cgi-bin/koha/admin/koha2marclinks.pl">Correspondencia Koha - MARC</a></li>
 <li><a href="/cgi-bin/koha/admin/fieldmapping.pl">Palabras claves para correspondencia MARC</a></li>
 <li><a href="/cgi-bin/koha/admin/checkmarc.pl">Verificación de hoja de trabajo bibliográfica MARC</a></li>
 <li><a href="/cgi-bin/koha/admin/authtypes.pl">Tipos de autoridad</a></li>
 <li><a href="/cgi-bin/koha/admin/classsources.pl">Fuentes de clasificación</a></li>
 <li><a href="/cgi-bin/koha/admin/matching-rules.pl">Regla de coincidencia de registro</a></li>
 <li><a href="/cgi-bin/koha/admin/oai_sets.pl">Configuración de conjunto OAI</a></li>
</ul>

<h5>Parámetros de la adquisición</h5>

<ul>
 <li><a href="/cgi-bin/koha/admin/currency.pl">Monedas y tipo de cambio</a></li>
 <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl">Presupuestos</a></li>
 <li><a href="/cgi-bin/koha/admin/aqbudgets.pl">Fondos</a></li>

</ul>

<h5>Parámetros adicionales</h5>

<ul>
 <!-- <li><a href="/cgi-bin/koha/admin/printers.pl">Network Printers</a></li> -->
 <li><a href="/cgi-bin/koha/admin/z3950servers.pl">Servidores Z39.50</a></li>
 <li><a href="/cgi-bin/koha/admin/didyoumean.pl">Usted quiere decir:  </a></li>
</ul>
</div>
</div>
