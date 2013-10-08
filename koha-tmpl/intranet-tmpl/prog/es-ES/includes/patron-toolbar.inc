[% UNLESS ( no_add ) %] <div id="toolbar" class="btn-toolbar">
 <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-plus"></i> Nuevo usuario<span class="caret"></span></button>
 <ul class="dropdown-menu">
 [% IF ( AddPatronLists_categorycode ) %] [% FOREACH categorie IN categories %]<li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;categorycode=[% categorie.categorycode %]">[% categorie.description | html_entity %]</a></li>[% END %] [% ELSE %] <li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=A">Usuario adulto</a></li>
 <li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=C">Usuario infantil</a></li>
 <li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=P">Usuario profesional</a></li>
 <li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=I">Institución</a></li>
 <li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=S">Usuario Staff</a></li>
 <li><a href="/cgi-bin/koha/members/memberentry.pl?op=add&amp;category_type=X">Usuario estadística</a></li>
 [% END %] </ul>
 </div>
</div>
[% END %] 