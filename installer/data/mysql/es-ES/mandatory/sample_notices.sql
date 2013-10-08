
insert  into `letter`(`module`,`code`,`name`,`title`,`content`) values ('circulation','CHECKIN','ítem devuelto (Digest)','ítems devueltos','Los siguientes ítems han sido devueltos a:\n----\n<<biblio.title>>\n----\nGracias.'),('circulation','CHECKOUT','ítem prestado (Digest)','ítems prestados','Los siguientes ítems han sido prestado de:\n----\n<<biblio.title>>\n----\nGracias por visitar <<branches.branchname>>.'),('circulation','DUE','Recordario de ítem vencido','Recordario de ítem vencido','Estimado/a <<borrowers.firstname>> <<borrowers.surname>>,\n\nEl siguiente ítem tiene el préstamo vencido:\n\n<<biblio.title>>, <<biblio.author>> (<<ítems.barcode>>)'),('circulation','DUEDGST','Recordario de ítem vencido (Digest)','Recordario de ítem vencido','Tiene <<count>> ítems con el préstamo vencido'),('circulation','ODUE','Aviso de vencimiento','Aviso de vencimiento','Estimado <<borrowers.firstname>> <<borrowers.surname>>, De acuerdo con nuestros datos, tiene ítems con el préstamo vencido. Su biblioteca no le multa con ninguna sanción, no obstante, le rogamos que los devuelva a la biblioteca o los renueve dichos ítems tan pronto como le sea posible.\n\n <<branches.branchname>> <<branches.branchaddress1>> <<branches.branchaddress2>> <<branches.branchaddress3>> Phone: <<branches.branchphone>> Fax: <<branches.branchfax>> Email: <<branches.branchemail>> \n\nSi tiene datos de acceso para su biblioteca y la renovación está disponible, puede renovarIos online. Si la devolución de un ítem sobrepasara los 30 días de retraso, su carné de la biblioteca quedaría bloqueada hasta la devolución de los mismos. \nLos siguiente(s) ítem(s) está(n) con el préstamo vencido:  <item>\"<<biblio.title>>\" de <<biblio.author>>, <<items.itemcallnumber>>, Signatura: <<items.barcode>> Multa: <fine>EUR</fine></item> Gracias por su interés en este asunto. Personal de <<branches.branchname>> '),('circulation','PREDUE','Aviso previo de préstamo vencido','Aviso previo de préstamo vencido','Estimado/a <<borrowers.firstname>> <<borrowers.surname>>,\n\nEl préstamo de los siguientes ítems acaba pronto:\n\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)'),('circulation','PREDUEDGST','Aviso previo de préstamo vencido (Digest)','Aviso previo de préstamo vencido','Tiene en préstamo <<count>> ítems que acaba pronto'),('claimacquisition','ACQCLAIM','Reclamación de adquisición','Item no recibido',' <<aqbooksellers.name>>\n<<aqbooksellers.address1>>\n<<aqbooksellers.address2>>\n<<aqbooksellers.address3>>\n<<aqbooksellers.address4>>\n<<aqbooksellers.phone>>\n\nEl pedido número <<aqorders.ordernumber>> (<<aqorders.title>>) (<<aqorders.quantity>> ordered) ($<<aqorders.listprice>> each) no se ha recibido todavía.'),('members','ACCTDETAILS','Detalles de cuenta  - DEFAULT','Los detalles de tu nueva cuenta en Koha','Hola <<borrowers.title>> <<borrowers.firstname>> <<borrowers.surname>>.\n\nLos detalles de tu nueva cuenta en Koha son\n\nUsuario: <<borrowers.userid>>\nContraseña: <<borrowers.password>>\n\nSi tiene cualquier problema o cuestión en cuanto a su cuenta, por favor, contacta con el Adminsitrador de Koha.\n\nGracias,\nAdministrador de Koha \nkohaadmin@yoursite.org'),('reserves','HOLD','Ejemplar disponible para recoger','Ejemplar disponible para recoger en <<branches.branchname','Estimado/a <<borrowers.firstname>> <<borrowers.surname>>,\n\nTiene una reserva preparada para recoger desde <<reserves.waitingdate>>:\n\nTítulo: <<biblio.title>>\nAutor: <<biblio.author>>\nCopia: <<items.copynumber>>\nLocalización: <<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n<<branches.branchaddress3>>\n<<branches.branchcity>> <<branches.branchzip>>'),('reserves','HOLDPLACED','Reserva realizada del ejemplar','Reserva realizada del ejemplar',' Se ha realizado una reserva del siguiente ítem : <<title>> (<<biblionumber>>) por el usuario <<firstname>> <<surname>> (<<cardnumber>>).'),('reserves','HOLD_PRINT','Ejemplar disponible para recoger (aviso impreso)','Ejemplar disponible para recoger (aviso impreso)','<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>>\n\n\nChange Service Requested\n\n\n\n\n\n\n\n<<borrowers.firstname>> <<borrowers.surname>>\n<<borrowers.address>>\n<<borrowers.city>> <<borrowers.zipcode>>\n\n\n\n\n\n\n\n\n\n\n<<borrowers.firstname>> <<borrowers.surname>> <<borrowers.cardnumber>>\n\nTiene una reserva pediente de recoger desde <<reserves.waitingdate>>:\n\nTítulo: <<biblio.title>>\nAutor: <<biblio.author>>\nCopia: <<items.copynumber>>'),('serial','RLIST','Lista de circulación','La publicación periódica ya está disponible',' <<borrowers.firstname>> <<borrowers.surname>>,\n\nEl siguiente ítem está ya disponible:\n\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)\n\nPor favor, recójalo tan pronto como le sea posible.'),('suggestions','ACCEPTED','Sugerencia aceptada','Comprar la sugerencia aceptada','Estimado/a <<borrowers.firstname>> <<borrowers.surname>>, Sugirió que la biblioteca adquiriese <<suggestions.title>> de <<suggestions.author>>. La biblioteca ha revisado su sugerencia hoy. El item será pedido tan pronto como nos sea posible. Será notificado por mail cuando el pedido esté completo. y también cuando llegue a la biblioteca. Si tiene alguna pregunta, por favor, escríbanos a <<branches.branchemail>>. Gracias, <<branches.branchname>>'),('suggestions','AVAILABLE','Sugerencia disponible','La compra sugerida ya está disponible','Estimado/a <<borrowers.firstname>> <<borrowers.surname>>, Sugirió que la biblioteca adquiriese <<suggestions.title>> de <<suggestions.author>>. Le informamos que el ítem que pidió ya forma parte de nuestra colección. Si tiene alguna pregunta, por favor, escríbamos a <<branches.branchemail>>. Gracias, <<branches.branchname>>'),('suggestions','ORDERED','Sugerencia pedida','El item sugerido ya está pedido','Estimado/ a <<borrowers.firstname>> <<borrowers.surname>>, Sugirió que la biblioteca adquiriese <<suggestions.title>> de <<suggestions.author>>. Le informamos que el item que pidió ya está pedido. Tan pronto como llegue, lo añadiremos al fondo. Será notificado de nuevo cuando el libro esté disponible. Si tiene alguna cuestión, por favor, escríbanos a  <<branches.branchemail>> Gracias, <<branches.branchname>>'),('suggestions','REJECTED','Sugerencia rechazada','Gestionar la sugerencia rechazada','Estimado/a <<borrowers.firstname>> <<borrowers.surname>>, Sugirió que la biblioteca adquiriese <<suggestions.title>> de <<suggestions.author>>. La biblioteca ha revisado su petición hoy y ha decidido no aceptarla. Los motivos son:  <<suggestions.reason>> . Si tiene alguna cuestión, por favor, escríbanos a <<branches.branchemail>>. Gracias, <<branches.branchname>>');
INSERT INTO `letter` (module, code, name, title, content, is_html)
VALUES ('circulation','ISSUESLIP','Issue Slip','Issue Slip', '<h3><<branches.branchname>></h3>
Checked out to <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />
(<<borrowers.cardnumber>>) <br />

<<today>><br />

<h4>Prestado</h4>
<checkedout>
<p>
<<biblio.title>> <br />
Barcode: <<items.barcode>><br />
Fecha de préstamo: <<issues.date_due>><br />
</p>
</checkedout>

<h4>Vencidos</h4>
<overdue>
<p>
<<biblio.title>> <br />
Barcode: <<items.barcode>><br />
Fecha de préstamo: <<issues.date_due>><br />
</p>
</overdue>

<hr>

<h4 style="text-align: center; font-style:italic;">News</h4>
<news>
<div class="newsitem">
<h5 style="margin-bottom: 1px; margin-top: 1px"><b><<opac_news.title>></b></h5>
<p style="margin-bottom: 1px; margin-top: 1px"><<opac_news.new>></p>
<p class="newsfooter" style="font-size: 8pt; font-style:italic; margin-bottom: 1px; margin-top: 1px">Posted on <<opac_news.timestamp>></p>
<hr />
</div>
</news>', 1),
('circulation','ISSUEQSLIP','Comprobante de préstamo','Issue Quick Slip', '<h3><<branches.branchname>></h3>
Prestado a <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />
(<<borrowers.cardnumber>>) <br />

<<today>><br />

<h4>Prestado Hoy</h4>
<checkedout>
<p>
<<biblio.title>> <br />
Barcode: <<items.barcode>><br />
Fecha de préstamo: <<issues.date_due>><br />
</p>
</checkedout>', 1),
('circulation','RESERVESLIP','Comprobante de Reserva','Comprobante de Reserva', '<h5>Fecha: <<today>></h5>

<h3> Trasladar a <<branches.branchname>></h3>

<h3><<borrowers.surname>>, <<borrowers.firstname>></h3>

<ul>
    <li><<borrowers.cardnumber>></li>
    <li><<borrowers.phone>></li>
    <li> <<borrowers.address>><br />
         <<borrowers.address2>><br />
         <<borrowers.city >>  <<borrowers.zipcode>>
    </li>
    <li><<borrowers.email>></li>
</ul>
<br />
<h3>ITEM EN ESPERA</h3>
<h4><<biblio.title>></h4>
<h5><<biblio.author>></h5>
<ul>
   <li><<items.barcode>></li>
   <li><<items.itemcallnumber>></li>
   <li><<reserves.waitingdate>></li>
</ul>
<p>Notas:
<pre><<reserves.reservenotes>></pre>
</p>
', 1),
('circulation','TRANSFERSLIP','Comprobante de traslado','Comprobante de traslado', '<h5>Date: <<today>></h5>

<h3>Trasladar a <<branches.branchname>></h3>

<h3>ITEM</h3>
<h4><<biblio.title>></h4>
<h5><<biblio.author>></h5>
<ul>
   <li><<items.barcode>></li>
   <li><<items.itemcallnumber>></li>
</ul>', 1);
INSERT INTO `letter` (`module`,`code`,`branchcode`,`name`,`is_html`,`title`,`content`)
VALUES (
'members',  'OPAC_REG_VERIFY',  '',  'Email de Verificación de Auto-Registro en Opac',  '1',  'Verificar tu Cuenta',  'Hola!

Tu cuenta de la biblioteca ha sido creada. Por favor verifica la dirección de email pinchando este link para completar el proceso de registro:

http://<<OPACBaseURL>>/cgi-bin/koha/opac-registration-verify.pl?token=<<borrower_modifications.verification_token>>

Si no esperaba este mensaje, puede ignorarlo. La solicitud espirará dentro de poco.'
);
INSERT INTO `letter` (`module`,`code`,`branchcode`,`name`,`is_html`,`title`,`content`)
VALUES (
'members',  'OPAC_NEW_PASS',  '',  'Nueva contraseña de usuario ',  '1',  'Envío de nueva contraseña',  "Hola, 

Los detalles de tu cuenta en Kobli son

Usuario: <<userid>>
Contraseña: <<password>>

Si tiene cualquier problema o cuestión en cuanto a su cuenta, por favor, contacta con el Adminsitrador de Kobli.

Gracias,
Administrador de Kobli 
<<admin_mail>>
"
);
