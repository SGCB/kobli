<script type="text/javascript">//<![CDATA[
    $(document).ready(function() {
        var path = location.pathname.substring(1);
        var url = window.location.toString();
        url.match(/\?(.+)$/);
        var params = RegExp.$1;
        if (params) { params = "?" + params; }
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
 <li><a href="/cgi-bin/koha/admin/branches.pl">Libraries and groups</a></li>
 <li><a href="/cgi-bin/koha/admin/itemtypes.pl">Tipos de ítem</a></li>
 <li><a href="/cgi-bin/koha/admin/authorised_values.pl">Valores autorizados</a></li>
</ul>

<h5>Socios y circulación</h5>
<ul>
 <li><a href="/cgi-bin/koha/admin/categorie.pl">Tipos y categorías de socio</a></li>
 <li><a href="/cgi-bin/koha/admin/cities.pl">Ciudades y pueblos</a></li>
 <li><a href="/cgi-bin/koha/admin/roadtype.pl">Tipos de camino</a></li>
 <li><a href="/cgi-bin/koha/admin/patron-attr-types.pl">Tipos de características de socio</a></li>
 <li><a href="/cgi-bin/koha/admin/smart-rules.pl">Reglas de circulación y multas</a></li>
 <li><a href="/cgi-bin/koha/admin/branch_transfer_limits.pl">Límites de transferencia de la biblioteca</a></li>
 <li><a href="/cgi-bin/koha/admin/item_circulation_alerts.pl">Alertas de circulación de ítems</a></li>
</ul>

<h5>Catálogo</h5>
<ul>
 <li><a href="/cgi-bin/koha/admin/biblio_framework.pl">MARC bibliographic framework</a></li>
 <li><a href="/cgi-bin/koha/admin/koha2marclinks.pl">Correspondencia Koha - MARC</a></li>
 <li><a href="/cgi-bin/koha/admin/fieldmapping.pl">Palabras clave para correspondencia MARC</a></li>
 <li><a href="/cgi-bin/koha/admin/checkmarc.pl">MARC bibliographic framework test</a></li>
 <li><a href="/cgi-bin/koha/admin/authtypes.pl">Tipos de autoridad</a></li>
 <li><a href="/cgi-bin/koha/admin/classsources.pl">Fuentes de clasificación</a></li>
 <li><a href="/cgi-bin/koha/admin/matching-rules.pl">Regla de coincidencia de registro</a></li>
 <li><a href="/cgi-bin/koha/admin/oai_sets.pl">OAI sets configuration</a></li>
</ul>

<h5>Parámetros de adquisición</h5>

<ul>
 <li><a href="/cgi-bin/koha/admin/currency.pl">Divisas y tipos de cambio</a></li>
 <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl">Presupuestos</a></li>
 <li><a href="/cgi-bin/koha/admin/aqbudgets.pl">Fondos</a></li>

</ul>

<h5>Parámetros adicionales</h5>

<ul>
 [% IF ( NoZebra ) %]<li><a href="/cgi-bin/koha/admin/stopwords.pl">Palabras eliminadas</a></li>[% END %]
 <!-- <li><a href="/cgi-bin/koha/admin/printers.pl">Network Printers</a></li> -->
 <li><a href="/cgi-bin/koha/admin/z3950servers.pl">Z39.50 client targets</a></li>
</ul>
</div>
</div>
