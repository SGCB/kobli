<a onclick="javascript:if (document.getElementsByName('Coded_Fields')[0].style.display=='none'){document.getElementsByName('Coded_Fields')[0].style.display='block';} else {document.getElementsByName('Coded_Fields')[0].style.display='none';}">Filtros de información codificada</a>
<div id="yui-b" style="display:none;" name="Coded_Fields" >
<!-- SUBTYPE LIMITS -->
 <fieldset>
 <legend>Campos codificados</legend>
 <p>
 <label>Audiencia</label>
 <select name="limit" class="subtype">
 <option value="" selected="selected" >Cualquiera</option>
 <option value="aud:a">juvenil, general</option>
 <option value="aud:b">pre-primary (0-5)</option>
 <option value="aud:c">primaria (5-8)</option>
 <option value="aud:d">niños (9-14)</option>
 <option value="aud:e">adulto</option>
 <option value="aud:k">adulto, serio</option>
 <option value="aud:m">adulto, general</option>
 <option value="aud:u">Desconocido</option>
 </select>
 </p>
 <p>
 <label>Imprimir</label>
 <select name="limit" class="subtype">
 <option value="" selected="selected" >Cualquiera</option>
 <option value="Material-type:r">Impresión normal</option>
 <option value="Material-type:d">impresión grande</option>
 <option value="Material-type:e">formato de periódico</option>
 <option value="Material-type:f">Escritura Braille o Moon</option>
 <option value="Material-type:g">microprint</option>
 <option value="Material-type:h">manuscrito</option>
 <option value="Material-type:i">multimedia</option>
 <option value="Material-type:j">mini-print</option>
 <option value="Material-type:s">recurso electrónico</option>
 <option value="Material-type:t">microforma</option>
 <option value="Material-type:z">other form of textual material</option>
 </select>
 </p>
 <p>
 <label>Género literario</label>
 <select name="limit" class="subtype">
 <option value="" selected="selected" >Cualquiera</option>
 <option value="Literature-Code:a">ficción</option>
 <option value="Literature-Code:b">drama</option>
 <option value="Literature-Code:c">ensayos</option>
 <option value="Literature-Code:d">humor, sátira</option>
 <option value="Literature-Code:e">cartas</option>
 <option value="Literature-Code:f">cuentos</option>
 <option value="Literature-Code:g">Poesía</option>
 <option value="Literature-Code:h">discursos, oratoria </option>
 <option value="Literature-Code:i">libreto</option>
 <option value="Literature-Code:y">not a literary text</option>
 <option value="Literature-Code:z">múltiple /otras formas literarias</option>
 </select>
 </p>
 <p>
 <label>Biografía</label>
 <select name="limit" class="subtype" size="1">
 <option value="">Cualquiera</option>
 <option value="Biography-code:y">not a biography</option>
 <option value="Biography-code:a">autobiografía</option>
 <option value="Biography-code:b">biografía individual</option>
 <option value="Biography-code:c">biografía colectiva</option>
 <option value="Biography-code:d">contiene datos biográficos </option>
 </select>
 </p>
 <p>
 <label>Ilustración</label>
 <select name="limit" class="subtype" size="1">
 <option value="">Cualquiera</option>
 <option value="Illustration-Code:a">ilustraciones</option>
 <option value="Illustration-Code:b">Mapas</option>
 <option value="Illustration-Code:c">portraits</option>
 <option value="Illustration-Code:d">mapas</option>
 <option value="Illustration-Code:e">Planos</option>
 <option value="Illustration-Code:f">plates</option>
 <option value="Illustration-Code:g">música</option>
 <option value="Illustration-Code:h">facsímiles</option>
 <option value="Illustration-Code:i">escudo de armas</option>
 <option value="Illustration-Code:j">tablas genealógicas</option>
 <option value="Illustration-Code:k">formularios</option>
 <option value="Illustration-Code:l">muestras</option>
 <option value="Illustration-Code:m">grabaciones sonoras</option>
 <option value="Illustration-Code:n">diapositivas</option>
 <option value="Illustration-Code:o">iluminaciones</option>
 <option value="Illustration-Code:y">Sin ilustraciones</option>
 </select>
 </p>
 <p>
 <label>Contenido</label>
 <select name="limit" class="subtype">
 <option value="" >Cualquiera</option>
 <option value="ctype:a" >bibliografía</option>
 <option value="ctype:b" >catálogo</option>
 <option value="ctype:c" >índice</option>
 <option value="ctype:d" >resumen</option>
 <option value="ctype:e" >diccionario</option>
 <option value="ctype:f" >enciclopedia</option>
 <option value="ctype:g" >directorio</option>
 <option value="ctype:h" >project description</option>
 <option value="ctype:i" >Estadísticas</option>
 <option value="ctype:j" >libro de texto programado</option>
 <option value="ctype:k" >patente</option>
 <option value="ctype:l" >standard</option>
 <option value="ctype:m" >disertación o tesis</option>
 <option value="ctype:n" >leyes y legislación</option>
 <option value="ctype:o" >numeric table</option>
 <option value="ctype:p" >informes técnicos </option>
 <option value="ctype:q" >enunciado de examen</option>
 <option value="ctype:r" >compendios/revisiones en literatura</option>
 <option value="ctype:s" >tratados</option>
 <option value="ctype:t" >historietas o cómics</option>
 <option value="ctype:v" >disertación o tesis (revisada)</option>
 <option value="ctype:w" >texto religioso</option>
 <option value="ctype:z" >otro</option>
 </select>
 </p>
 <p>
 <label>Tipos de vídeo</label>
 <select name="limit" class="subtype">
 <option value="">Cualquiera</option>
 <option value="Video-mt:a">Película </option>
 <option value="Video-mt:b">Proyección visual</option>
 <option value="Video-mt:c">grabación de vídeo</option>
 </select>
 </p>
 </fieldset>
 <fieldset>
 <legend>Publicaciones periódicas</legend><p>
 <p>
 <label>Tipo de publicación periódica</label>
 <select name="limit" class="subtype">
 <option value="">Cualquier tipo</option>
 <option value="Type-Of-Serial:a">Periódica</option>
 <option value="Type-Of-Serial:b">Series monográficas </option>
 <option value="Type-Of-Serial:c">Periódico</option>
 <option value="Type-Of-Serial:e">Actualizando hojas sueltas</option>
 <option value="Type-Of-Serial:f">Base de Datos</option>
 <option value="Type-Of-Serial:g">Actualizando website</option>
 <option value="Type-Of-Serial:z">Otro</option>
 </select>
 </p>
 <p>
 <label>Periodicidad</label>
 <select name="limit" class="subtype">
 <option value="">Cualquiera</option>
 <option value="Frequency-code:a">Diario</option>
 <option value="Frequency-code:b">Dos veces por semana</option>
 <option value="Frequency-code:c">Semanal</option>
 <option value="Frequency-code:d">Bisemanal</option>
 <option value="Frequency-code:e">Quincenal</option>
 <option value="Frequency-code:f">Mensual</option>
 <option value="Frequency-code:g">Bimestral</option>
 <option value="Frequency-code:h">Trimestral</option>
 <option value="Frequency-code:i">Tres veces al año</option>
 <option value="Frequency-code:j">Semestral</option>
 <option value="Frequency-code:k">Anual</option>
 <option value="Frequency-code:l">Bienal</option>
 <option value="Frequency-code:m">Trienio</option>
 <option value="Frequency-code:n">Tres veces a la semana</option>
 <option value="Frequency-code:o">Tres veces al mes</option>
 <option value="Frequency-code:y">Sin periodicidad</option>
 <option value="Frequency-code:u">Desconocido</option>
 <option value="Frequency-code:z">Otro</option>
 </select>
 </p>
 <p>
 <label>Regularidad</label>
 <select name="limit" class="subtype">
 <option value="">Cualquier regularidad</option>
 <option value="Regularity-code:a">regular</option>
 <option value="Regularity-code:b">normalised irregular</option>
 <option value="Regularity-code:y">irregular</option>
 <option value="Regularity-code:u">Desconocido</option>
 </select>
 </p>

 </fieldset>
 <fieldset>
 <legend>Pintura</legend><p>
 <select name="limit" class="subtype">
 <option value="">Cualquiera</option>
 <option value="Graphics-type:a">colage</option>
 <option value="Graphics-type:b">dibujo</option>
 <option value="Graphics-type:c">pintura</option>
 <option value="Graphics-type:d">reproducción fotomecánica</option>
 <option value="Graphics-type:e">negativo fotográfico</option>
 <option value="Graphics-type:f">impresión fotográfica</option>
 <option value="Graphics-type:h">imagen</option>
 <option value="Graphics-type:i">Impreso</option>
 <option value="Graphics-type:k">dibujo técnico </option>
 <option value="Graphics-type:z">other non-projected graphic type</option>
 </select>
 <select name="limit" class="subtype">
 <option value="">Cualquiera</option>
 <option value="Graphics-support:a">lienzo</option>
 <option value="Graphics-support:b">cartulina</option>
 <option value="Graphics-support:c">cartulina/cartón</option>
 <option value="Graphics-support:d">vidrio</option>
 <option value="Graphics-support:j">plaster</option>
 <option value="Graphics-support:k">tablero duro</option>
 <option value="Graphics-support:l">porcelaine</option>
 <option value="Graphics-support:m">stone</option>
 <option value="Graphics-support:n">madera</option>
 <option value="Graphics-support:v">mixed collection</option>
 <option value="Graphics-support:e">synthetics</option>
 <option value="Graphics-support:f">skin</option>
 <option value="Graphics-support:g">textil</option>
 <option value="Graphics-support:h">metal</option>
 <option value="Graphics-support:i">papel</option>
 <option value="Graphics-support:z">others</option>
 <option value="Graphics-support:u">Desconocido</option>
 </select>
 </p>
</fieldset>
</div>
