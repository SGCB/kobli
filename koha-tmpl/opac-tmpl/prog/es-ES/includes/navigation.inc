 [% IF ( opacuserlogin ) %] [% UNLESS ( loggedinusername ) %] [% UNLESS ( casAuthentication ) %] <div class="yui-u">
 <div id="login" class="container">
 <form action="/cgi-bin/koha/opac-user.pl" method="post" name="auth" id="auth">
 <input type="hidden" name="koha_login_context" value="opac" />
 <fieldset class="brief">
 <legend>Log in to Your Account:</legend>
 <ol>
 <li><label for="userid">Usuario:</label><input type="text" id="userid" size="10" name="userid" /></li>
 <li><label for="password">Contraseña:</label><input type="password" id="password" size="10" name="password" /></li>
 </ol> <fieldset class="action">
 <input value="Ingresar" type="submit" class="submit" />
 </fieldset></fieldset>
 </form>
 </div>
 </div>
 [% END %] [% END %] [% END %] [% OpacNav %]