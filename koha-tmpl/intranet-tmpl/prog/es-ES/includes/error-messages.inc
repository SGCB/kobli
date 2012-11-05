[% IF ( error ) %] <script type='text/javascript'>
// Gratuitiously copied from http://dhtmlpopups.webarticles.org/basics.php
// Determine how much the visitor had scrolled

var scrolledX, scrolledY;
if( self.pageYOffset ) {
  scrolledX = self.pageXOffset;
  scrolledY = self.pageYOffset;
} else if( document.documentElement && document.documentElement.scrollTop ) {
  scrolledX = document.documentElement.scrollLeft;
  scrolledY = document.documentElement.scrollTop;
} else if( document.body ) {
  scrolledX = document.body.scrollLeft;
  scrolledY = document.body.scrollTop;
}

// Determine the coordinates of the center of the page

var centerX, centerY;
if( self.innerHeight ) {
  centerX = self.innerWidth;
  centerY = self.innerHeight;
} else if( document.documentElement && document.documentElement.clientHeight ) {
  centerX = document.documentElement.clientWidth;
  centerY = document.documentElement.clientHeight;
} else if( document.body ) {
  centerX = document.body.clientWidth;
  centerY = document.body.clientHeight;
}

function myPopupRelocate() {
 var scrolledX, scrolledY;
 if( self.pageYOffset ) {
   scrolledX = self.pageXOffset;
   scrolledY = self.pageYOffset;
 } else if( document.documentElement && document.documentElement.scrollTop ) {
   scrolledX = document.documentElement.scrollLeft;
   scrolledY = document.documentElement.scrollTop;
 } else if( document.body ) {
   scrolledX = document.body.scrollLeft;
   scrolledY = document.body.scrollTop;
 }

 var centerX, centerY;
 if( self.innerHeight ) {
   centerX = self.innerWidth;
   centerY = self.innerHeight;
 } else if( document.documentElement && document.documentElement.clientHeight ) {
   centerX = document.documentElement.clientWidth;
   centerY = document.documentElement.clientHeight;
 } else if( document.body ) {
   centerX = document.body.clientWidth;
   centerY = document.body.clientHeight;
 }

 var leftOffset = scrolledX + (centerX - 250) / 2;
 var topOffset = scrolledY + (centerY - 200) / 2;

 document.getElementById("mypopup").style.top = topOffset + "px";
 document.getElementById("mypopup").style.left = leftOffset + "px";
}

window.onload=function(){
 myPopupRelocate();
 document.getElementById("mypopup").style.display = "block";
 document.body.onscroll = myPopupRelocate;
 window.onscroll = myPopupRelocate;
}
</script>
<div id='mypopup' name='mypopup' style='position: absolute; width: 400px; height: 131px; display: none; background: #FFC url(/intranet-tmpl/prog/img/alert-bg.gif) repeat-x left 0; border: 1px solid #bcbcbc; right: 0px; top: 500px'>
 <span id="message" style="position: absolute; top: 5px; left: 5px;">
 <strong style="color: #900;">ADVERTENCIA:</strong>
 [% IF ( 101 ) %] La base de datos ha devuelto un error mientras estaba [% IF ( card_element ) %]guardando [% card_element %] [% element_id %][% ELSE %]intentando guardar[% END %]. Por favor, haga que el administrador del sistema verifique el registro de errores para más detalles. [% ELSIF ( 102 ) %] La base de datos ha devuelto un error al [% IF ( card_element ) %]eliminar [% card_element %] [% element_id %][% ELSIF ( image_ids ) %][% image_ids %][% ELSE %]intentando eliminar[% END %]. Por favor, haga que el administrador del sistema de verifique el registro de errores para más detalles. [% ELSIF ( 201 ) %] Se intentó una operación no compatible[% IF ( element_id ) %] en [% card_element %] [% element_id %][% END %]. Por favor, haga que el administrador del sistema de verifique el registro de errores para más detalles. [% ELSIF ( 202 ) %] Se ha producido un error. Por favor, haga que el administrador del sistema de verifique el registro de errores para más detalles. [% ELSIF ( 203 ) %] Se suministró un código de sede no existente o inválida. Por favor, <a href="/cgi-bin/koha/circ/selectbranchprinter.pl">verificar</a> que tiene una biblioteca seleccionada [% ELSIF ( 301 ) %] Ha ocurrido un error mientras al intentaba cargar el archivo de imagen. Por favor, compruebe su administrador de sistema para comprobar el registro de errores más detallado. La imagen [% ELSIF ( 302 ) %] excede 500KB. Por favor redimensiona la imagen e impórtarla otra vez. [% ELSIF ( 303 ) %] La base de datos de imagen en la actualidad sólo permite una cuota superior de [% image_limit %] imágenes de almacenamiento.Por favor, borrar una o más imágenes para liberar la cuota de espacio. [% ELSIF ( 401 ) %] Un error a ocurrido y el ítem(s) no se ha añadido a la biblioteca [% batch_id %]. Por favor compruebe  su administrador de sistema para comprobar el registro de errores más detallado. [% ELSIF ( 402 ) %] Los ítem(s) no han sido añadidos porque la biblioteca no está configurada. Por favor configurar su biblioteca antes de añadir ítems a la biblioteca.  [% ELSIF ( 403 ) %] Un error ha ocurrido y el ítem(s) no ha sido borrado el lote [% batch_id %].  Por favor, compruebe su administrador de sistema para comprobar el registro de errores más detallado. [% ELSIF ( 404 ) %] Un error ha ocurrido y el lote [% batch_id %] no ha sido borrado. Por favor, compruebe su administrador de sistema para comprobar el registro de errores más detallado.  [% ELSIF ( 405 ) %] Un error ha ocurrido y el lote [% batch_id %] not fully de-duplicated. [% ELSE %] [% END %] </span>
 <span id="close" style="position: absolute; top: 100px; left: 175px;">
 <input value="Cerrar" type="submit" onclick="document.getElementById("mypopup").style.display = "none"">
 </span>
</div>
[% END %] 