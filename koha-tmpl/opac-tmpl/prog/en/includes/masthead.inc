<div id="header-wrapper"><div id="members">
  [% IF ( opacuserlogin ) %]
	<ul>
[% UNLESS ( loggedinusername ) %]
               <li><a href="/cgi-bin/koha/opac-user.pl">Log in to your account</a></li>[% END %]
            [% IF ( loggedinusername ) %]
                <li><span class="members">Welcome, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></span></li>

            [% END %]
            [% IF ( ShowOpacRecentSearchLink ) %]
                <li><a href="/cgi-bin/koha/opac-search-history.pl" title="View your search history">Search history</a> [<a class="logout" href="/cgi-bin/koha/opac-search-history.pl?action=delete" title="Delete your search history" onclick="return confirm(MSG_DELETE_SEARCH_HISTORY);">x</a>]</li>
            [% END %]
			[% IF ( loggedinusername ) %]<li>[% IF persona %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1" onclick='navigator.id.logout();'>[% ELSE %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">[% END %]Log Out</a></li>[% END %]
   	</ul>	
  [% END %]
</div>
  [% IF ( opacheader ) %]
	[% opacheader %]
  [% END %]
[% IF ( opaclanguagesdisplay ) %]
    [% IF ( languages_loop && opaclanguagesdisplay ) %]
        [% UNLESS ( one_language_enabled ) %]
            <div id="changelanguage" class="ft">
            <div class="lang"><strong>Languages:&nbsp;</strong></div>
            <ul id="i18nMenu" class="footermenu">
            [% FOREACH languages_loo IN languages_loop %]

                [% IF ( languages_loo.group_enabled ) %]
                [% IF ( languages_loo.plural ) %]
                <li class="more"><a class="sublangs" id="show[% languages_loo.rfc4646_subtag %]" href="#">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a><div id="sub[% languages_loo.rfc4646_subtag %]">
                <div class="bd"><ul>
                [% FOREACH sublanguages_loo IN languages_loo.sublanguages_loop %]
            [% IF ( sublanguages_loo.enabled ) %]
                    [% IF ( sublanguages_loo.sublanguage_current ) %]
                        <li> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</li>
                    [% ELSE %]
                    <li><a href="/cgi-bin/koha/opac-changelanguage.pl?language=[% sublanguages_loo.rfc4646_subtag %]"> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</a></li>
            [% END %]
                    [% END %]

                [% END %]
                </ul></div></div></li>

                [% ELSE %]
                [% IF ( languages_loo.group_enabled ) %]
                    [% IF ( languages_loo.current ) %]
                        <li class="morelang">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</li>
                    [% ELSE %]
                        <li class="morelang"><a href="/cgi-bin/koha/opac-changelanguage.pl?language=[% languages_loo.rfc4646_subtag %]">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a></li>
                    [% END %]
            [% END %]
                [% END %]
                [% END %]

            [% END %]
            </ul>
            </div>
        [% END %]
    [% END %]

[% END %]

  <!-- TMPL_IF NAME="opacheader" -->
	<!-- TMPL_VAR NAME="opacheader" -->
  <!-- /TMPL_IF -->
<div id="opac-main-search" class="yui-g">
   [% IF ( opacsmallimage ) %]
   <h1 id="libraryname" ><a href="/cgi-bin/koha/opac-main.pl" title="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]"><img src="[% opacsmallimage %]" alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]" />[% IF ( LibraryName ) %]<span>[% LibraryName %]</span>[% ELSE %]<span>Koha Online Catalog</span>[% END %]</a></h1>
   [% ELSE %]
   <h1 id="libraryname">
   <a href="/cgi-bin/koha/opac-main.pl" title="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]">[% IF ( LibraryName ) %]<span>[% LibraryName %]</span>[% ELSE %]<span>Koha Online Catalog</span>[% END %]</a></h1>
   [% END %]
   [% IF ( opacsmallimageright ) %]
   <h1 id="librarylogo" ><a href="/cgi-bin/koha/opac-main.pl" ><img src="[% opacsmallimageright %]" alt="[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]" /></a></h1>
   [% END %]

<div id="fluid">

[% IF ( OpacPublic ) %]
<div id="fluid-offset">

<div id="moresearches">
<a href="/cgi-bin/koha/opac-search.pl">Advanced search</a>
[% IF Koha.Preference( 'UseCourseReserves' ) == 1 %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-course-reserves.pl">Course reserves</a>[% END %]
[% IF ( OpacBrowser ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-browser.pl">Browse by hierarchy</a>[% END %]
[% IF ( OpacAuthorities ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-authorities-home.pl">Authority search</a>[% END %]
[% IF ( opacuserlogin && ( Koha.Preference( 'reviewson' ) == 1 ) && ( Koha.Preference( 'OpacShowRecentComments' ) == 1 ) ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-showreviews.pl">Recent comments</a>[% END %]
[% IF ( TagsEnabled ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags.pl">Tag cloud</a>[% END %]
[% IF ( OpacCloud ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags_subject.pl">Subject cloud</a>[% END %]
[% IF ( OpacTopissue ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-topissues.pl">Most popular</a>[% END %]
[% IF ( suggestion ) %]
  [% IF ( AnonSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Purchase suggestions</a>
  [% ELSIF ( OPACViewOthersSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Purchase suggestions</a>
  [% END %]
[% END %]
</div>
 </div>
</div>

[% END %]  <!-- OpacPublic --> 

[% IF ( opacbookbag ) %]<div id="cartDetails">Your cart is empty.</div>[% END %]

[% IF ( virtualshelves ) %]
<div id="listsmenu" class="yuimenu" style="display: none">
    <div class="bd">
    <h4>Public lists</h4>
		[% IF ( pubshelves ) %]
			<ul class="first-of-type">
			[% FOREACH pubshelvesloo IN pubshelvesloop %]
			<li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]">[% pubshelvesloo.shelfname |html %]</a></li>
			[% END %]
			<li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves">[View All]</a></li>
        </ul>
		[% ELSE %]
        No public lists
		[% END %]
  [% IF ( opacuserlogin ) %]
    <h4>Your lists</h4>
	[% IF ( loggedinusername ) %]
		[% IF ( barshelves ) %]
			<ul class="first-of-type">
			[% FOREACH barshelvesloo IN barshelvesloop %]
			<li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]">[% barshelvesloo.shelfname |html %]</a></li>
			[% END %]
        <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[View all]</a></li>
        </ul>
		[% ELSE %]
			<ul class="first-of-type">
        <li>No private lists</li>
        <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Create new list]</a></li></ul>
		[% END %]
	[% ELSE %]
        <ul class="first-of-type"><li><a href="/cgi-bin/koha/opac-user.pl">Log in to create your own lists</a></li></ul>
	[% END %]
  [% END %]
	  </div>
</div><!-- /listmenu /virtualshelves -->
[% END %]
<div id="listsDetails"></div>
</div>
</div>
