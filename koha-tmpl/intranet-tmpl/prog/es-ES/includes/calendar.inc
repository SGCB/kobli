<script type="text/javascript">
//<![CDATA[

var debug    = "[% debug %]";
var dformat  = "[% dateformat %]";
var sentmsg = 0;
if (debug > 1) {alert("dateformat: " + dformat + "\ndebug is on (level " + debug + ")");}

function Date_from_syspref(dstring) {
        var dateX = dstring.split(/[-/]/);
        if (debug > 1 && sentmsg < 1) {sentmsg++; alert("Date_from_syspref(" + dstring + ") splits to:\n" + dateX.join("\n"));}
        if (dformat === "iso") {
                return new Date(dateX[0], (dateX[1] - 1), dateX[2]);  // YYYY-MM-DD to (YYYY,m(0-11),d)
        } else if (dformat === "us") {
                return new Date(dateX[2], (dateX[0] - 1), dateX[1]);  // MM/DD/YYYY to (YYYY,m(0-11),d)
        } else if (dformat === "metric") {
                return new Date(dateX[2], (dateX[1] - 1), dateX[0]);  // DD/MM/YYYY to (YYYY,m(0-11),d)
        } else {
                if (debug > 0) {alert("KOHA ERROR - Unrecognized date format: " +dformat);}
                return 0;
        }
}

/* Instead of including multiple localization files as you would normally see with
   jQueryUI we expose the localization strings in the default configuration */
jQuery(function($){
    $.datepicker.regional[''] = {
        closeText: _("Hecho"),
        prevText: _("Prev"),
        nextText: _("Siguiente"),
        currentText: _("Hoy"),
        monthNames: [_("Enero"),_("Febrero"),_("Marzo"),_("Abril"),_("Mayo"),_("Junio"),
        _("Julio"),_("Agosto"),_("Septiembre"),_("Octubre"),_("Noviembre"),_("Diciembre")],
        monthNamesShort: [_("Ene"), _("Feb"), _("Mar"), _("Abr"), _("Mayo"), _("Jun"),
        _("Jul"), _("Agosto"), _("Set"), _("Oct"), _("Nov"), _("Dic")],
        dayNames: [_("Domingo"), _("Lunes"), _("Martes"), _("Miércoles"), _("Jueves"), _("Viernes"), _("Sábado")],
        dayNamesShort: [_("Dom"), _("Lun"), _("Mar"), _("Mie"), _("Jue"), _("Vie"), _("Sab")],
        dayNamesMin: [_("Dom "),_("Lun "),_("Mar "),_("Mie"),_("Jue "),_("Fr"),_("Sab ")],
        weekHeader: _("Semana "),
        dateFormat: "[% IF ( dateformat == "us" ) %]mm/dd/yy[% ELSIF ( dateformat == "metric" ) %]dd/mm/yy[% ELSE %]yy-mm-dd[% END %]",
        firstDay: [% CalendarFirstDayOfWeek %],
        isRTL: [% IF ( bidi ) %]true[% ELSE %]false[% END %],
        showMonthAfterYear: false,
        yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['']);
});

$(document).ready(function(){

$.datepicker.setDefaults({
        showOn: "both",
        changeMonth: true,
        changeYear: true,
        buttonImage: '[% interface %]/[% theme %]/img/famfamfam/silk/calendar.png',
        buttonImageOnly: true,
        showButtonPanel: true,
        showOtherMonths: true,
        selectOtherMonths: true
    });

    $( ".datepicker" ).datepicker();
    // http://jqueryui.com/demos/datepicker/#date-range
    var dates = $( ".datepickerfrom, .datepickerto" ).datepicker({
        changeMonth: true,
        numberOfMonths: 1,
        onSelect: function( selectedDate ) {
            var option = this.id == "from" ? "minDate" : "maxDate",
                instance = $( this ).data( "datepicker" );
                date = $.datepicker.parseDate(
                    instance.settings.dateFormat ||
                    $.datepicker._defaults.dateFormat,
                    selectedDate, instance.settings );
            dates.not( this ).datepicker( "option", option, date );
        }
    });
});
//]]>
</script>
