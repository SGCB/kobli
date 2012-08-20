<div id="toolbar"><script type="text/javascript">
	//<![CDATA[

	// prepare DOM for YUI Toolbar

	 $(document).ready(function() {
	    $("#editmenuc").empty();
	    $("#duplicate").parent().remove();
		$("#delete").parent().remove();
	 	$("#renewc").empty();
	    yuiToolbar();
	 });

	// YUI Toolbar Functions

	function yuiToolbar() {
	
    [% IF ( subscriptionid ) %]
	    var editmenu = [
	        [% IF ( CAN_user_serials_edit_subscription ) %]
            { text: _("Editar suscripción"),  [% IF ( cannotedit ) %]disabled: true, [% END %] url: "/cgi-bin/koha/serials/subscription-add.pl?op=modify&amp;subscriptionid=[% subscriptionid %]" },
		[% END %]
	        [% IF ( CAN_user_serials_create_subscription ) %]
            { text: _("Editar como nuevo (duplicar)"), [% IF ( cannotedit ) %]disabled: true, [% END %] url: "/cgi-bin/koha/serials/subscription-add.pl?op=dup&amp;subscriptionid=[% subscriptionid %]" },
		[% END %]
	        [% IF ( CAN_user_serials_delete_subscription ) %]
            { text: _("Eliminar suscripción"), [% IF ( cannotedit ) %]disabled: true, [% END %] onclick: {fn: confirm_deletion }}
		[% END %]
	    ];
	 [% END %]
	    new YAHOO.widget.Button("newsubscription");
	    [% IF ( subscriptionid ) %]		
		new YAHOO.widget.Button({
              id: "renew", 
              type: "link", 
			  href: "#",
              label: _("Renovar"), 
              container: "renewc",
onclick: {fn:function(){popup([% subscriptionid %])}}
          });
	[% IF ( subscriptionid ) %]	  
	new YAHOO.widget.Button({
	        type: "menu",
	        label: _("Editar"),
	        name: "editmenubutton",
	        menu: editmenu,
	        container: "editmenuc"
			
	    });
		[% END %]
	    new YAHOO.widget.Button("renew");
	    new YAHOO.widget.Button("receive");
		[% END %]
	}

	//]]>
	</script>
<ul class="toolbar">
 [% IF ( CAN_user_serials_create_subscription ) %] [% IF ( biblionumber_for_new_subscription ) %] <li><a id="newsubscription" href="/cgi-bin/koha/serials/subscription-add.pl?biblionumber_for_new_subscription=[% biblionumber_for_new_subscription %]">Nueva suscripción</a></li>
 [% ELSE %] <li><a id="newsubscription" href="/cgi-bin/koha/serials/subscription-add.pl">Nueva suscripción</a></li>
 [% END %] [% END %] [% IF ( CAN_user_serials_edit_subscription || CAN_user_serials_create_subscription || CAN_user_serials_delete_subscription ) %] [% IF ( subscriptionid ) %] [% IF ( CAN_user_serials_edit_subscription || CAN_user_serials_create_subscription || CAN_user_serials_delete_subscription ) %] [% UNLESS ( cannotedit ) %] <li id="editmenuc"><a id="edit" href="/cgi-bin/koha/serials/subscription-add.pl?op=modify&amp;subscriptionid=[% subscriptionid %]">Editar</a></li>
 [% END %] [% END %] [% IF ( CAN_user_serials_create_subscription ) %] <li><a id="duplicate" href="/cgi-bin/koha/serials/subscription-add.pl?op=dup&amp;subscriptionid=[% subscriptionid %]">Duplicar </a></li>
 [% END %] [% UNLESS ( cannotedit ) %] [% IF ( CAN_user_serials_renew_subscription ) %] <li id="renewc"><a id="renew" href="#" onclick="popup([% subscriptionid %])">Renovar </a></li>
 [% END %] [% IF ( CAN_user_serials_receive_serials ) %] <li><a id="receive" href="/cgi-bin/koha/serials/serials-edit.pl?subscriptionid=[% subscriptionid %]&amp;serstatus=1,3">Recibir</a></li>
 [% END %] [% IF ( CAN_user_serials_delete_subscription ) %] <li><a id="delete" href="javascript:confirm_deletion()">Borrar</a></li>
 [% END %] [% END %] [% END %] [% END %] </ul>
</div>
