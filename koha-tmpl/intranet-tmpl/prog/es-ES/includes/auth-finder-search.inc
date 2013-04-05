[% PROCESS 'form-blocks.inc' %] <script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
    $("#clear").on("click",function(e){
        e.preventDefault();
        finderjumpfull('blinddetail-biblio-search.pl?authid=0&index=[% index %]');
    });
    $("#createnew").on("click",function(e){
        e.preventDefault();
        finderjumpfull('authorities.pl?index=[% index %]&authtypecode=[% authtypecode %]');
    });
    // marclist
    $( "#value_any" ).autocomplete({
        source: function(request, response) {
            $.ajax({
                url: "/cgi-bin/koha/authorities/ysearch.pl",
                dataType: "json",
                data: {
                    term: request.term,
                    op: "do_search",
                    type: "intranet",
                    and_or: "and",
                    operator: "contains",
                    orderby: "HeadingAsc",
                    querytype: "marclist"
                },
                success: function(data) {
                    response( $.map( data, function( item ) {
                            return {
                                label: item.summary,
                                value: item.summary
                            }
                        }));
                }
            });
        },
        minLength: 3,
    });
    // mainentry
    $( "#value_main" ).autocomplete({
        source: function(request, response) {
            $.ajax({
                url: "/cgi-bin/koha/authorities/ysearch.pl",
                dataType: "json",
                data: {
                    term: request.term,
                    op: "do_search",
                    type: "intranet",
                    and_or: "and",
                    operator: "contains",
                    orderby: "HeadingAsc",
                    querytype: "mainentry"
                },
                success: function(data) {
                    response( $.map( data, function( item ) {
                            return {
                                label: item.summary,
                                value: item.summary
                            }
                        }));
                }
            });
        },
        minLength: 3,
    });
    // mainmainentry
    $( "#value_mainstr" ).autocomplete({
        source: function(request, response) {
            $.ajax({
                url: "/cgi-bin/koha/authorities/ysearch.pl",
                dataType: "json",
                data: {
                    term: request.term,
                    op: "do_search",
                    type: "intranet",
                    and_or: "and",
                    operator: "contains",
                    orderby: "HeadingAsc",
                    querytype: "mainmainentry"
                },
                success: function(data) {
                    response( $.map( data, function( item ) {
                            return {
                                label: item.summary,
                                value: item.summary
                            }
                        }));
                }
            });
        },
        minLength: 3,
    });
});

function finderjumpfull(page)
{
    window.open(page,'','fullscreen,scrollbars');
}

//]]>
</script>

<div id="toolbar" class="btn-toolbar">
 <div class="btn-group"><a href="#" id="clear" class="btn btn-small"><i class="icon-remove-sign"></i> Limpiar campo</a></div>
 <div class="btn-group"><a href="#" id="createnew" class="btn btn-small"><i class="icon-plus"></i> Crear una nueva autoridad</a></div>
</div>
<form name="f" method="get" action="auth_finder.pl">
 <input type="hidden" name="source" value="[% source %]" />
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <input type="hidden" name="index" value="[% index %]" />
 <fieldset class="rows"><legend>Buscar opciones</legend>
 <ol><li>
 <span class="label">Tipo de autoridad: </span>
 [% authtypecode %] <input type="hidden" name="authtypecode" value="[% authtypecode %]" />
 </li>
 <li>
 <label for="mainmainentry">Main entry ($a only): </label>
 <input type="hidden" name="marclist" value="mainmainentry" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator" id="mainmainentry">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_mainstr" style="width:400px;" type="text" name="value_mainstr" value="[% value_mainstr |html %]" />
 <div id="yvaluecontainermainmainentry"></div>
 </li>

 <li>
 <label for="mainentry">Main entry: </label>
 <input type="hidden" name="marclist" value="mainentry" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator" id="mainentry">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_main" style="width:400px;" type="text" name="value_main" value="[% value_main |html %]" />
 <div id="yvaluecontainermainentry"></div>
 </li>

 <li>
 <label for="marclistanywhere">Anywhere: </label>
 <input type="hidden" name="marclist" value="any" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator" id="marclistanywhere">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_any" style="width:400px;" type="text" name="value_any" value="[% value_any |html %]" />
 <div id="yvaluecontainermarclist"></div>
 </li>
 <li>
 <label for="marclistheading">Heading match: </label>
 <input type="hidden" name="marclist" value="match" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator" id="marclistheading">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input type="text" name="value_match" value="[% value_match |html %]" />
 </li>
 <li>
 <label for="orderby">Ordenar por : </label>
 <select name="orderby" id="orderby">
 <option value="">No hay pedido</option>
 <option value="HeadingAsc" selected="selected">Ascendente por cabecera</option>
 <option value="HeadingDsc">Descendente por cabecera</option>
 </select>
 </li></ol></fieldset>
 [% IF source == 'auth' %] <fieldset class="rows"><legend>Información relacionada</legend>
 <ol>
 <li>
 <label for="relationship">Especial relación: </label>
 <select name="relationship" id="relationship">
 [% selected=relationship %] [% PROCESS selectoptionopen value='' %]Sin especificación</option>
 [% PROCESS selectoptionopen value='a' %]a- Cabecera establecida</option>
 [% PROCESS selectoptionopen value='b' %]b - Later heading</option>
 [% PROCESS selectoptionopen value='d' %]d - Acrónimo</option>
 [% PROCESS selectoptionopen value='f' %]f - Composición musical</option>
 [% PROCESS selectoptionopen value='g' %]g - Término amplio</option>
 [% PROCESS selectoptionopen value='h' %]h - Términos específicos</option>
 [% PROCESS selectoptionopen value='i' %]i - frase de referencia de instrucción ene el subcampo $i</option>
 [% PROCESS selectoptionopen value='n' %]n- No aplicable</option>
 [% PROCESS selectoptionopen value='r' %]r -Relación designada en $i o $4</option>
 [% PROCESS selectoptionopen value='t' %]t - Órgano superior inmediato</option>
 </select>
 </li>
 </ol>
 </fieldset>
 [% END %] <fieldset class="action"> <input value="Buscar" type="submit" class="submit" id="search" /> <a id="cancel" class="cancel close" href="#">Cancelar</a>
 </fieldset>
</form>
