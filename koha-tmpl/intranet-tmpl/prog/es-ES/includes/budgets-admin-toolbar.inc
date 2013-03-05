<div id="toolbar" class="btn-toolbar">
 [% IF ( budget_period_id ) %] <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-plus"></i> Nuevo: <span class="caret"></span></button>
 <ul class="dropdown-menu">
 <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl?op=add_form">Nuevo presupuesto</a></li>
 [% IF ( budget_period_locked || !CAN_user_acquisition_budget_add_del ) %] <li class="disabled">
 [% ELSE %] <li>
 [% END %] <a href="/cgi-bin/koha/admin/aqbudgets.pl?op=add_form&amp;budget_period_id=[% budget_period_id %]">Nuevo fondo para [% budget_period_description %]</a></li>
 </ul>
 </div>

 <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-pencil"></i> Editar <span class="caret"></span></button>
 <ul class="dropdown-menu">
 <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl?op=add_form&amp;budget_period_id=[% budget_period_id %]">Editar presupuesto [% budget_period_description %]</a></li>
 <li><a href="/cgi-bin/koha/admin/aqbudgetperiods.pl?op=duplicate_form&amp;budget_period_id=[% budget_period_id %]">Duplicar el presupuesto [% budget_period_description %]</a></li>
 </ul>
 </div>

 <div class="btn-group">
 <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><i class="icon-pencil"></i> Planificación<span class="caret"></span></button>
 <ul class="dropdown-menu">
 [% IF ( CAN_user_acquisition_planning_manage ) %] <li>
 [% ELSE %] <li class="disabled">
 [% END %] <a href="/cgi-bin/koha/admin/aqplan.pl?budget_period_id=[% budget_period_id %]&amp;authcat=MONTHS">Planificación por meses</a></li>
 [% IF ( CAN_user_acquisition_planning_manage ) %] <li>
 [% ELSE %] <li class="disabled">
 [% END %] <a href="/cgi-bin/koha/admin/aqplan.pl?budget_period_id=[% budget_period_id %]&amp;authcat=BRANCHES">Planificación por bibliotecas</a></li>
 [% IF ( CAN_user_acquisition_planning_manage ) %] <li>
 [% ELSE %] <li class="disabled">
 [% END %] <a href="/cgi-bin/koha/admin/aqplan.pl?budget_period_id=[% budget_period_id %]&amp;authcat=ITEMTYPES">Planificación por tipos de ítem</a></li>
 [% FOREACH auth_cats_loo IN auth_cats_loop %] [% IF ( CAN_user_acquisition_planning_manage ) %] <li>
 [% ELSE %] <li class="disabled">
 [% END %] <a href="/cgi-bin/koha/admin/aqplan.pl?budget_period_id=[% budget_period_id %]&amp;authcat=[% auth_cats_loo.authcat %]">Planificación por [% auth_cats_loo.authcat %]</a>
 </li>
 [% END %] </ul>
 </div>

 [% ELSE %] <div class="btn-group"><a class="btn btn-small" id="newrootbudget" href="/cgi-bin/koha/admin/aqbudgetperiods.pl?op=add_form"><i class="icon-plus"></i> Nuevo presupuesto</a></div>
 [% END %] </div>