<div id="region-opaccredits" class="ft">
 [% opaccredits %] </div>
</div>

[% IF ( Babeltheque ) %] <script type="text/javascript" src="http://www.babeltheque.com/bw_30.js"></script>
[% END %] [% IF persona %] <script src="https://login.persona.org/include.js"></script>
<script type="text/javascript" language="javascript">

navigator.id.watch({
    loggedInUser: [% IF emailaddress && loggedinpersona %]'[% emailaddress %]'[% ELSE %]null[% END %],
    onlogin: function (assertion) {
        $.post('/cgi-bin/koha/svc/login',
            { assertion: assertion },
            function (data) {
                window.location = '/cgi-bin/koha/opac-user.pl';
            }
        )
        .fail(function() { var errstr = _("No se ha podido accecer, puede que su email personal no coincida con su email de Koha");
            alert(errstr);
        });
    },
    onlogout: function () {
        window.location = '/cgi-bin/koha/opac-main.pl?logout.x=1';
    }
});

var signinLink = document.getElementById('browserid');

if (signinLink) {
    signinLink.onclick = function(evt) {
        // Requests a signed identity assertion from the user.
        navigator.id.request({
            siteName: "[% LibraryName | html %]",
            returnTo: '/cgi-bin/koha/opac-user.pl',
            oncancel: function() { alert('user refuses to share identity.'); }
            });
        };
}

</script>
[% END %] </body>
</html>
