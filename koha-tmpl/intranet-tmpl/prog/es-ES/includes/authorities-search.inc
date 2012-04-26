<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1>
<!-- Begin Authorities Resident Search Box -->
<div id="header_search" class="residentsearch">
 <div id="authority_search" class="residentsearch">
 <p class="tip">Ingresa autoridad ($a):</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select name="authtypecode">
 [% FOREACH authtypesloo IN authtypesloop %]
 [% IF ( authtypesloo.selected ) %]
 <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %]
 <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %]
 [% END %]
 </select>
 <input type="hidden" name="marclist" value="mainmainentry" />
 <select name="operator">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_anywhere" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 <option value="">Ninguno</option>
 <option value="HeadingAsc" selected="selected">Encabezamiento A-Z</option>
 <option value="HeadingDsc">Encabezamiento Z-A</option>
 </select>
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 <div id="main_heading" class="residentsearch" style="display:none;">
 <p class="tip">Ingresa autoridad:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select  name="authtypecode">
 [% FOREACH authtypesloo IN authtypesloop %]
 [% IF ( authtypesloo.selected ) %]
 <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %]
 <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %]
 [% END %]
 </select>
 <input type="hidden" name="marclist" value="mainentry" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_mainentry" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 <option value="">Ninguno</option>
 <option value="HeadingAsc" selected="selected">Encabezamiento A-Z</option>
 <option value="HeadingDsc">Encabezamiento Z-A</option>
 </select>
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 <div id="all_headings" class="residentsearch" style="display:none;">
 <p class="tip">Ingresa un campo de autoridad:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select name="authtypecode">
 [% FOREACH authtypesloo IN authtypesloop %]
 [% IF ( authtypesloo.selected ) %]
 <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %]
 <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %]
 [% END %]
 </select>
 <input type="hidden" name="marclist" value="all" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_mainmainentry" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 <option value="">Ninguno</option>
 <option value="HeadingAsc" selected="selected">Encabezamiento A-Z</option>
 <option value="HeadingDsc">Encabezamiento Z-A</option>
 </select>
 <input value="Enviar" type="submit" class="submit" />
 </form>
 </div>
 <ul>
 <li><a href="/cgi-bin/koha/authorities/authorities-home.pl#authority_search">Search authorities</a></li>
 <li><a href="/cgi-bin/koha/authorities/authorities-home.pl#main_heading">Search main heading</a></li>
 <li><a href="/cgi-bin/koha/authorities/authorities-home.pl#all_headings">Search all headings</a></li>
 </ul>
</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Authorities Resident Search Box -->
