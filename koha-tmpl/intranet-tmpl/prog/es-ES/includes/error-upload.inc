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
 [% IF ( error_1 ) %]  Ha ocurrido un error. Para más detalles, por favor haga que el administrador del sistema verifique el log de errores. [% ELSIF ( error_2 ) %] Ha ocurrido un error. El archivo no es una imagen o está corrupto. Por favor haga que el administrador del sistema verifique el log de errores. [% END %]</span>
 <span id="close" style="position: absolute; top: 100px; left: 175px;">
 <input value="Cerrar" type="submit" onclick="document.getElementById("mypopup").style.display = "none"">
 </span>
</div>
[% END %] 