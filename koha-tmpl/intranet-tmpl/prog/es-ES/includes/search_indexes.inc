<select class="advsearch" name="idx">
 <option value="kw">Palabra clave</option>
 <option value="au">Autor</option>
 <option value="au,phr">&nbsp;&nbsp;&nbsp;&nbsp; Autor como frase</option>
 <option value="cpn">&nbsp;&nbsp;&nbsp;&nbsp; Nombre corporativo</option>
 <option value="cfn">&nbsp;&nbsp;&nbsp;&nbsp; Nombre de conferencia</option>
 <option value="cpn,phr">&nbsp;&nbsp;&nbsp;&nbsp; Nombre corporativo como frase</option>
 <option value="cfn,phr">&nbsp;&nbsp;&nbsp;&nbsp; Nombre de conferencia como frase</option>
 <option value="pn">&nbsp;&nbsp;&nbsp;&nbsp; Nombre personal</option>
 <option value="pn,phr">&nbsp;&nbsp;&nbsp;&nbsp; Nombre personal como frase</option>
 <option value="ti">Título</option>
 <option value="ti,phr">&nbsp;&nbsp;&nbsp;&nbsp; Título como frase</option>
 <option value="se">&nbsp;&nbsp;&nbsp;&nbsp; Título de la serie</option>
 <option value="su">Tema</option>
 <option value="su,phr">&nbsp;&nbsp;&nbsp;&nbsp; Tema como frase</option>
 [% IF ( expanded_options ) %] <option value="su-br">&nbsp;&nbsp;&nbsp;&nbsp; Tema y téminos generales </option>
 <option value="su-na">&nbsp;&nbsp;&nbsp;&nbsp; Tema y términos específicos</option>
 <option value="su-rl">&nbsp;&nbsp;&nbsp;&nbsp; Temas y términos relacionados</option>
 [% END %] <option value="bc">Código de barras</option>
 <option value="location">Ubicación en estantería</option>
 [% IF (numbersphr) %] <option value="sn,phr">Numero estándar</option>
 [% ELSE %] <option value="sn">Numero estándar</option>
 [% END %] <option value="nb">&nbsp;&nbsp;&nbsp;&nbsp; ISBN</option>
 <option value="ns">&nbsp;&nbsp;&nbsp;&nbsp; ISSN</option>
 [% IF (numbersphr) %] <option value="callnum,phr">&nbsp;&nbsp;&nbsp;&nbsp; Número de clasificación</option>
 [% ELSE %] <option value="callnum">&nbsp;&nbsp;&nbsp;&nbsp; Número de clasificación</option>
 [% END %] <option value="ln,rtrn">Idioma</option>
 <option value="nt">Notas/comentarios</option>
 [% IF (marcflavour != 'UNIMARC' ) %] <option value="curriculum">Currículum</option>
 [% END %] <option value="pb">Editor</option>
 <option value="pl">Ubicación de editorial</option>
 <option value="yr">Fecha de publicación (aaaa)</option>
 <option value="acqdate">Fecha de adquisición (aaaa-mm-dd)</option>
</select>
