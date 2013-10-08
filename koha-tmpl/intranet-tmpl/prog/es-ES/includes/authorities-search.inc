<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1>
<!-- Begin Authorities Resident Search Box -->
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
        var searchType = '[% marclist %]';
        if (searchType) {
            if ('mainentry' == searchType) {
                $("#header_search").tabs( "option", "selected", 0 );
            } else if ('match' == searchType) {
                $("#header_search").tabs( "option", "selected", 1 );
            } else if ('all' == searchType) {
                $("#header_search").tabs( "option", "selected", 2 );
            }
        }
    });
//]]>
</script>
<div id="header_search" class="residentsearch">
 <div id="main_heading" class="residentsearch">
 <p class="tip">Introduzca un encabezamiento autorizado:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select name="authtypecode">
 [% IF (marcflavour == 'UNIMARC' ) %]<option value="">Todo tipos de autoridad</option>[% END %] [% FOREACH authtypesloo IN authtypesloop %] [% IF ( authtypesloo.selected ) %] <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %] <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %] [% END %] </select>
 <input type="hidden" name="marclist" value="mainentry" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator">
 [% IF ( operator == 'contains' ) %] <option value="contains" selected="selected">contiene</option>
 [% ELSE %] <option value="contains">contiene</option>
 [% END %] [% IF ( operator == 'start' ) %] <option value="start" selected="selected">comienza con</option>
 [% ELSE %] <option value="start">comienza con</option>
 [% END %] [% IF ( operator == 'is' ) %] <option value="is" selected="selected">es exactamente</option>
 [% ELSE %] <option value="is">es exactamente</option>
 [% END %] </select>
 <input id="value_mainentry" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 [% IF ( orderby == 'HeadingAsc' ) %] <option value="HeadingAsc" selected="selected">Encabezamiento A-Z</option>
 [% ELSE %] <option value="HeadingAsc">Encabezamiento A-Z</option>
 [% END %] [% IF ( orderby == 'HeadingDsc' ) %] <option value="HeadingDsc" selected="selected">Encabezamiento Z-A</option>
 [% ELSE %] <option value="HeadingDsc">Encabezamiento Z-A</option>
 [% END %] [% IF ( orderby == '' && op ) %] <option value="" selected="selected">Ninguno</option>
 [% ELSE %] <option value="">Ninguno</option>
 [% END %] </select>
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 <div id="matchheading_search" class="residentsearch">
 <p class="tip">Introduzca cualquier encabezamiento:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select  name="authtypecode">
 [% IF (marcflavour == 'UNIMARC' ) %]<option value="">Todo tipos de autoridad</option>[% END %] [% FOREACH authtypesloo IN authtypesloop %] [% IF ( authtypesloo.selected ) %] <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %] <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %] [% END %] </select>
 <input type="hidden" name="marclist" value="match" />
 <select name="operator">
 [% IF ( operator == 'contains' ) %] <option value="contains" selected="selected">contiene</option>
 [% ELSE %] <option value="contains">contiene</option>
 [% END %] [% IF ( operator == 'start' ) %] <option value="start" selected="selected">comienza con</option>
 [% ELSE %] <option value="start">comienza con</option>
 [% END %] [% IF ( operator == 'is' ) %] <option value="is" selected="selected">es exactamente</option>
 [% ELSE %] <option value="is">es exactamente</option>
 [% END %] </select>
 <input id="value_matchheading" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 [% IF ( orderby == 'HeadingAsc' ) %] <option value="HeadingAsc" selected="selected">Encabezamiento A-Z</option>
 [% ELSE %] <option value="HeadingAsc">Encabezamiento A-Z</option>
 [% END %] [% IF ( orderby == 'HeadingDsc' ) %] <option value="HeadingDsc" selected="selected">Encabezamiento Z-A</option>
 [% ELSE %] <option value="HeadingDsc">Encabezamiento Z-A</option>
 [% END %] [% IF ( orderby == '' && op ) %] <option value="" selected="selected">Ninguno</option>
 [% ELSE %] <option value="">Ninguno</option>
 [% END %] </select>
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 <div id="all_headings" class="residentsearch">
 <p class="tip">Introduzca cualquier campo de autoridad:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select name="authtypecode">
 [% IF (marcflavour == 'UNIMARC' ) %]<option value="">Todo tipos de autoridad</option>[% END %] [% FOREACH authtypesloo IN authtypesloop %] [% IF ( authtypesloo.selected ) %] <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %] <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %] [% END %] </select>
 <input type="hidden" name="marclist" value="all" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator">
 [% IF ( operator == 'contains' ) %] <option value="contains" selected="selected">contiene</option>
 [% ELSE %] <option value="contains">contiene</option>
 [% END %] [% IF ( operator == 'start' ) %] <option value="start" selected="selected">comienza con</option>
 [% ELSE %] <option value="start">comienza con</option>
 [% END %] [% IF ( operator == 'is' ) %] <option value="is" selected="selected">es exactamente</option>
 [% ELSE %] <option value="is">es exactamente</option>
 [% END %] </select>
 <input id="value_anywhere" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 [% IF ( orderby == 'HeadingAsc' ) %] <option value="HeadingAsc" selected="selected">Encabezamiento A-Z</option>
 [% ELSE %] <option value="HeadingAsc">Encabezamiento A-Z</option>
 [% END %] [% IF ( orderby == 'HeadingDsc' ) %] <option value="HeadingDsc" selected="selected">Encabezamiento Z-A</option>
 [% ELSE %] <option value="HeadingDsc">Encabezamiento Z-A</option>
 [% END %] [% IF ( orderby == '' && op ) %] <option value="" selected="selected">Ninguno</option>
 [% ELSE %] <option value="">Ninguno</option>
 [% END %] </select>
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 <ul>
 <li><a href="#main_heading">Buscar encabezamiento principal</a></li>
 <li><a href="#matchheading_search">Buscar en todos los encabezamientos</a></li>
 <li><a href="#all_headings">Búsqueda de palabra clave</a></li>
 </ul>
</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Authorities Resident Search Box -->
