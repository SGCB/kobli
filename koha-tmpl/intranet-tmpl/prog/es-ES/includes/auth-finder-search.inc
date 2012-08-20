<script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
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

//]]>
</script>


<form name="f" method="get" action="auth_finder.pl">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <input type="hidden" name="index" value="[% index %]" />
 <fieldset class="rows"><ol><li>
 <span class="label">Tipo de autoridad</span>
 [% authtypecode %] <input type="hidden" name="authtypecode" value="[% authtypecode %]" />
 </li>
 <li>
 <label for="mainmainentry">Entrada Principal (sólo $a)</label>
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
 <label for="mainentry">Entrada Principal</label>
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
 <label for="marclistanywhere">En cualquier parte</label>
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
 <label for="marclistheading">Coincidencia de cabecera</label>
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
 <label for="orderby">Ordenar por </label>
 <select name="orderby" id="orderby">
 <option value="">No hay pedido</option>
 <option value="HeadingAsc" selected="selected">Ascendente por cabecera</option>
 <option value="HeadingDsc">Descendente por cabecera</option>
 </select>
 </li></ol></fieldset>
 <fieldset class="action"> <input value="Comenzar búsqueda" type="submit" class="submit" /> <a class="cancel close" href="#">Cancelar</a></fieldset>
</form>
