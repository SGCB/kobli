 <select name="item_action" id="item_action">
 [% IF ( item_action_always_add ) %] <option value="always_add" selected="selected">
 [% ELSE %] <option value="always_add">
 [% END %]Añadir siempre items</option>
 [% IF ( item_action_add_only_for_matches ) %] <option value="add_only_for_matches" selected="selected">
 [% ELSE %] <option value="add_only_for_matches">
 [% END %] Añadir ítems sólo si se localizó un registro bibliográfico coincidente</option>
 [% IF ( item_action_add_only_for_new ) %] <option value="add_only_for_new" selected="selected">
 [% ELSE %] <option value="add_only_for_new">
 [% END %] Añadir ítems sólo si no se localizó un registro bibliográfico coincidente</option>
 [% IF ( item_action_ignore ) %] <option value="ignore" selected="selected">
 [% ELSE %] <option value="ignore">
 [% END %] Ignorar items</option>
 </select>
