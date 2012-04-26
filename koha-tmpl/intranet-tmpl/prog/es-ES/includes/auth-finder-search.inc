<script type="text/javascript">
//<![CDATA[
YAHOO.util.Event.onContentReady("header_search", function() {
    new function() {
        // Define a custom formatter function
        this.fnCustomFormatter = function(oResultItem, sQuery) {
            var name        = oResultItem[0];
            var aMarkup = [
                "<div class=\"sample-result\">",
                name,
                "<\/div>"];
            return (aMarkup.join(""));
        };

    // marclist
        this.marclistDS = new YAHOO.widget.DS_XHR("/cgi-bin/koha/authorities/ysearch.pl", ["\n", "\t"]);
        this.marclistDS.scriptQueryAppend = "op=do_search&type=intranet&and_or=and&operator=contains&orderby=HeadingAsc&querytype=marclist";
        this.marclistDS.responseType = YAHOO.widget.DS_XHR.TYPE_FLAT;
        this.marclistDS.maxCacheEntries = 60;
        this.marclistDS.queryMatchSubset = false;

        var myInput = document.getElementById('value_any');
        var myContainer = document.getElementById('yvaluecontainermarclist');
        this.oAutoComp = new YAHOO.widget.AutoComplete(myInput,myContainer,this.marclistDS);
        this.oAutoComp.queryDelay = 1;
        this.oAutoComp.formatResult = this.fnCustomFormatter;
        this.oAutoComp.maxResultsDisplayed = 1000;


    // mainentry
    this.mainentryDS = new YAHOO.widget.DS_XHR("/cgi-bin/koha/authorities/ysearch.pl", ["\n", "\t"]);
        this.mainentryDS.scriptQueryAppend = "op=do_search&type=intranet&and_or=and&operator=contains&orderby=HeadingAsc&querytype=mainentry";
        this.mainentryDS.responseType = YAHOO.widget.DS_XHR.TYPE_FLAT;
        this.mainentryDS.maxCacheEntries = 60;
        this.mainentryDS.queryMatchSubset = false;

        var myInput = document.getElementById('value_main');
        var myContainer = document.getElementById('yvaluecontainermainentry');
        this.oAutoComp = new YAHOO.widget.AutoComplete(myInput,myContainer,this.mainentryDS);
        this.oAutoComp.queryDelay = 1;
        this.oAutoComp.formatResult = this.fnCustomFormatter;
        this.oAutoComp.maxResultsDisplayed = 1000;


    // mainmainentry
    this.mainentryDS = new YAHOO.widget.DS_XHR("/cgi-bin/koha/authorities/ysearch.pl", ["\n", "\t"]);
        this.mainentryDS.scriptQueryAppend = "op=do_search&type=intranet&and_or=and&operator=contains&orderby=HeadingAsc&querytype=mainmainentry";
        this.mainentryDS.responseType = YAHOO.widget.DS_XHR.TYPE_FLAT;
        this.mainentryDS.maxCacheEntries = 60;
        this.mainentryDS.queryMatchSubset = false;

        var myInput = document.getElementById('value_mainstr');
        var myContainer = document.getElementById('yvaluecontainermainmainentry');
        this.oAutoComp = new YAHOO.widget.AutoComplete(myInput,myContainer,this.mainentryDS);
        this.oAutoComp.queryDelay = 1;
        this.oAutoComp.formatResult = this.fnCustomFormatter;
        this.oAutoComp.maxResultsDisplayed = 1000;


}
});
//]]>
</script>


<span id="header_search">
<form name="f" method="get" action="auth_finder.pl">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <input type="hidden" name="index" value="[% index %]" />
 <fieldset class="rows"><ol><li>
 <span class="label">Tipo de autoridad</span>
 [% authtypecode %]
 <input type="hidden" name="authtypecode" value="[% authtypecode %]" />
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
 <label for="marclist">En cualquier parte</label>
 <input type="hidden" name="marclist" value="any" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator" id="marclist">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input id="value_any" style="width:400px;" type="text" name="value_any" value="[% value_any |html %]" />
 <div id="yvaluecontainermarclist"></div>
 </li>
 <li>
 <label for="marclist">Heading match</label>
 <input type="hidden" name="marclist" value="match" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator" id="marclist">
 <option value="contains">contiene</option>
 <option value="start">comienza con</option>
 <option value="is">es exactamente</option>
 </select>
 <input type="text" name="value_match" value="[% value_match |html %]" />
 </li>
 <li>
 <label for="orderby">Sort by </label>
 <select name="orderby" id="orderby">
 <option value="">No hay pedido</option>
 <option value="HeadingAsc" selected="selected">Heading ascendant</option>
 <option value="HeadingDsc">Heading descendant</option>
 </select>
 </li></ol></fieldset>
 <fieldset class="action"> <input value="Comenzar búsqueda" type="submit" class="submit" /> <a class="cancel close" href="#">Cancelar</a></fieldset>
</form>
</span>
