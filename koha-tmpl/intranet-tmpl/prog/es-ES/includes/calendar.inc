<link rel="stylesheet" type="text/css" href="[% themelang %]/lib/calendar/calendar-system.css"/>
<script type="text/javascript" src="[% themelang %]/lib/calendar/calendar.js"></script>
<script type="text/javascript">
// full day names
Calendar._DN = new Array(_("Domingo"),_("Lunes"),_("Martes"),_("Miércoles"),_("Jueves"),_("Viernes"),_("Sábado"),_("Domingo"));
// short day names
Calendar._SDN = new Array(_("Dom"),_("Lun"),_("Mar"),_("Mie"),_("Jue"),_("Vie"),_("Sab"),_("Dom"));
// First day of the week. "0" means display Sunday first, "1" means display
// Monday first, etc.
Calendar._FD = [% CalendarFirstDayOfWeek %];
// full month names
Calendar._MN = new Array(_("Enero"),_("Febrero"),_("Marzo"),_("Abril"),_("Mayo"),_("Junio"),_("Julio"),_("Agosto"),_("Septiembre"),_("Octubre"),_("Noviembre"),_("Diciembre"));
// short month names
Calendar._SMN = new Array(_("Ene"),_("Feb"),_("Mar"),_("Abril"),_("Mayo"),_("Jun"),_("Jul"),_("Ags"),_("Sept"),_("Oct"),_("Nov"),_("Dic"));
// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = _("Acerca del calendario");

Calendar._TT["ABOUT"] =
_("Dhtml Date/Time Selector")+"\n" +
"(c) dynarch.com 2002-2003\n" + // don't translate this this ;-)
_("Para una versión de prueba visita: http://dynarch.com/mishoo/calendar.epl")+"\n" +
_("Distribuído bajo GNU LGPL. Ver http://gnu.org/licenses/lgpl.html para detalles.") +
"\n\n" +
_("Selección de fecha:")+"\n" +
_("- Utiliza los botones \\xab, \\xbb para seleccionar el año")+"\n" +
_("- Use the " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " buttons to select month")+"\n" +
_("- Manten presionado el botón del ratón sobre cualquiera de los botones de arriba para una selección más rápida.");
Calendar._TT["ABOUT_TIME"] = "\n\n" +
_("Selección de hora:")+"\n" +
_("- Haz clic en cualquiera de las partes del tiempo para aumentarlo")+"\n" +
_("- o click en mayúsculas para reducir")+"\n" +
_("- o haz clic y arrastra para una selección más rápida.");

Calendar._TT["PREV_YEAR"] = _("Año previo (presiona para menú)");
Calendar._TT["PREV_MONTH"] = _("Mes previo (presiona para menú)");
Calendar._TT["GO_TODAY"] = _("Ir a Hoy");
Calendar._TT["NEXT_MONTH"] = _("Mes siguiente (presiona para menú)");
Calendar._TT["NEXT_YEAR"] = _("Año siguiente (presiona para menú)");
Calendar._TT["SEL_DATE"] = _("Seleccionar fecha");
Calendar._TT["DRAG_TO_MOVE"] = _("Arrastrar para mover");
Calendar._TT["PART_TODAY"] = _(" (today)");

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = _("Mostrar %s primero");

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = _("Cerrar");
Calendar._TT["TODAY"] = _("Hoy");
Calendar._TT["TIME_PART"] = _("(Mayúsculas-)Haz clic o arrastra para cambiar el valor");

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%a, %b %e";

Calendar._TT["WK"] = _("sem");
Calendar._TT["TIME"] = _("Tiempo:");
</script>
<script type="text/javascript" src="[% themelang %]/lib/calendar/calendar-setup.js"></script>
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

function get_Calendar_limit (date,did) {
	// this function could be moved to a static calendar-extras.js file
	var dvalue = document.getElementById(did).value;
	if (dvalue == "") { return false; }
	var limitDate = Date_from_syspref(dvalue);
	if (debug && debug > 5) {
		var month = date.getMonth() + 1;
		var dateString = date.getFullYear() + '-' + month + '-' + date.getDate();
		alert("Comparing incoming (" + dateString + ") vs "
			+ "'" + did + "' limit\n"
			+ "\n thisdate: " + date
			+ "\nlimitdate: " + limitDate
			+ "\nlimit > thisdate : " + (limitDate > date) 
			+ "\nlimit < thisdate : " + (limitDate < date) 
		);
	}
	return limitDate;
}
//]]>
</script>
