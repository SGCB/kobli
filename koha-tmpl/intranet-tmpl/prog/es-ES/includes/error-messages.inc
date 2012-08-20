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
 [% IF ( 101 ) %] La base de datos ha devuelto un error mientras estaba [% IF ( card_element ) %]guardando [% card_element %] [% element_id %][% ELSE %]intentando guardar[% END %]. Por favor, haga que el administrador del sistema verifique el registro de errores para más detalles. [% ELSIF ( 102 ) %] La base de datos ha devuelto un error al [% IF ( card_element ) %]eliminar [% card_element %] [% element_id %][% ELSIF ( image_ids ) %][% image_ids %][% ELSE %]intentando eliminar[% END %]. Por favor, haga que el administrador del sistema de verifique el registro de errores para más detalles. [% ELSIF ( 201 ) %] Se intentó una operación no compatible[% IF ( element_id ) %] en [% card_element %] [% element_id %][% END %]. Por favor, haga que el administrador del sistema de verifique el registro de errores para más detalles. [% ELSIF ( 202 ) %] Se ha producido un error. Por favor, haga que el administrador del sistema de verifique el registro de errores para más detalles. [% ELSIF ( 203 ) %] Se suministró un código de sede no existente o inválida. Por favor, <a href="/cgi-bin/koha/circ/selectbranchprinter.pl">verificar</a> que tiene una sede seleccionada [% ELSIF ( 301 ) %] Ha ocurrido un error al intentar cargar el archivo de imagen. Por favor, pregunte a su administrador de sistema para comprobar el registro de errores para más detalles. [% ELSIF ( 302 ) %] Imagen superior a 500 KB. Por favor, cambiar el tamaño y la importación de nuevo. [% ELSIF ( 303 ) %] La cuota de la base de datos de imágenes en la actualidad sólo permite un máximo de [% image_limit %] imágenes que se almacenen en un momento dado. Por favor, elimine una o más imágenes para liberar espacio. [% ELSIF ( 401 ) %] Se ha producido un error y el(los) ítem(s) no se ha añadido al proceso de lotes [% batch_id %]. Por favor, haga que el administrador del sistema verifique el registro de errores para más detalles. [% ELSIF ( 402 ) %] El(los) ítem(s) no se agregó debido a que la sede no se estableció. Por favor, establezca la sede antes de agregar ítems a un lote. [% ELSIF ( 403 ) %] Se ha producido un error y los ítems no se han quitado del proceso de lotes [% batch_id %]. Por favor, haga que el administrador del sistema verifique el registro de errores para más detalles. [% ELSIF ( 404 ) %] Se ha producido un error y el ítem [% batch_id %] no fue eliminado. Por favor, haga que el administrador del sistema verifique el registro de errores para más detalles. [% ELSIF ( 405 ) %] Se ha producido un error y el proceso por lotes [% batch_id %] no se ha deduplicado totalmente. [% ELSE %] [% END %] </span>
 <span id="close" style="position: absolute; top: 100px; left: 175px;">
 <input value="Cerrar" type="submit" onclick="document.getElementById("mypopup").style.display = "none"">
 </span>
</div>
[% END %] 