<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
    jQuery.extend(jQuery.validator.messages, {
        required: _("Este campo es obligatorio."),
        remote: _("Por favor, arregle este campo."),
        email: _("Por favor, introduzca una dirección de correo electrónico válida."),
        url: _("Por favor, introduzca una URL válida."),
        date: _("Por favor, introduzca una fecha válida."),
        dateISO: _("Por favor, introduzca una fecha válida (ISO)"),
        number: _("Por favor, introduzca un número válido."),
        digits: _("Por favor, introduzca sólo dígitos."),
        equalTo: _("Por favor, introduzca el mismo valor de nuevo."),
        maxlength: $.validator.format(_("Por favor, no introduzca más de {0} caracteres.")),
        minlength: $.validator.format(_("Por favor, introduzca al menos {0} caracteres.")),
        rangelength: $.validator.format(_("Por favor, introduzca un valor que tenga entre  {0} y {1} caracteres.")),
        range: $.validator.format(_("Por favor, introduzca un valor que tenga entre  {0} y {1}.")),
        max: $.validator.format(_("Por favor, introduzca un valor menor o igual a {0}.")),
        min: $.validator.format(_("Por favor, introduzca un valor mayor o igual a {0}."))
    });
});
//]]>
</script>
