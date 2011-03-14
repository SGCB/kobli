
    // Block for check validity of value indicators

    // Check value of indicator and change messages to indicate validity
    function checkValueInd(id, ind, field)
    {
        var obj = $("#" + id);
        var valueInd = obj.val();
        var name = field + "_" + ind + "_";
        var indOther = (ind == 1)?2:1;
        var valueIndOther = $("#" + field + "_ind" + indOther).val();
        var nameOther = field + "_" + indOther + "_";
        var okBoth = {ind1: false, ind2: false};
        var form = obj.closest("form");
        var $inputs = form.find("input:hidden");
        if ($inputs.length > 0) {
            $inputs.each(function() {
                if (!okBoth.ind1 && $(this).attr('name').indexOf(name) >= 0 && valueInd == $(this).val()) {
                    okBoth.ind1 = true;
                } else if (!okBoth.ind2 && $(this).attr('name').indexOf(nameOther) >= 0 && valueIndOther == $(this).val()) {
                    okBoth.ind2 = true;
                }
                if (okBoth.ind1 && okBoth.ind2) return false;
            });
            if (!okBoth.ind1 && valueInd == "") okBoth.ind1 = true;
            if (!okBoth.ind2 && valueIndOther == "") okBoth.ind2 = true;
            var a_usevalue = $("#" + field + "_btn_usevalue_" + ind);
            var a_usevalue_3 = $("#" + field + "_btn_usevalue_3");
            if (okBoth.ind1) {
                obj.prev("label").attr("title", "User Value for Indicator " + ind + " is valid");
                obj.attr("title", "User Value for Indicator " + ind + " is valid");
                obj.css("backgroundColor", "");
                if (a_usevalue && a_usevalue_3) {
                    a_usevalue.attr('title', "Use this value and close the window");
                    a_usevalue.val("Use and Close");
                    if (okBoth.ind1 && okBoth.ind2) {
                        a_usevalue_3.attr('title', 'Use these values and close the window');
                        a_usevalue_3.val('Use both and Close');
                    } else {
                        a_usevalue_3.attr('title', "Can't Use these values until they're correct");
                        a_usevalue_3.val("Can't Use these values until they're correct");
                    }
                }
            } else {
                obj.prev("label").attr("title", "User Value for Indicator " + ind + " not is valid");
                obj.attr("title", "User Value for Indicator " + ind + " is not valid");
                obj.css("backgroundColor", "yellow");
                if (a_usevalue && a_usevalue_3) {
                    a_usevalue.attr('title', "Can't Use this value until is correct");
                    a_usevalue.val("Can't Use this value until is correct");
                    a_usevalue_3.attr('title', "Can't Use these values until they're correct");
                    a_usevalue_3.val("Can't Use these values until they're correct");
                }
            }
        } else okBoth.ind1 = true;
        return okBoth.ind1;
    }//checkValueInd


    // Change the value on the opener windows
    function changeValueInd(value, ind, field, openerField1, openerField2)
    {
        var openerField = (ind == 1)?openerField1:openerField2;
        var name = field + "_ind" + ind;
        var form = $("#f_pop");
        var $inputs = $('#f_pop input:text[name=' + name + ']');
        $inputs.each(function() {
            $(this).val(value);
            if (checkValueInd($(this).attr("id"), ind, field) && opener) {
                try {
                    for (var j=0; j < opener.document.f.elements.length; j++) {
                        if (opener.document.f.elements[j].name == openerField) {
                            opener.document.f.elements[j].value = value;
                            opener.document.f.elements[j].style.backgroundColor = "";
                            break;
                        }
                    }
                } catch (e) { // for HTML5 browsers that don't allow accessing/changing variables to the opener
                    var origin = location.protocol + '//' + location.hostname + ((location.port)?':' + location.port:'');
                    window.opener.postMessage('indicators: changeValueInd = ' + openerField + ';' + value, origin);
                }
            }
            return;
        });
    }//changeValueInd


    // Fill in the form the value of the indicator
    function changeValueIndLocal(openerField, value)
    {
        var $inputs = $('#f input:text[name=' + openerField + ']');
        if ($inputs.length > 0) {
            $inputs.each(function() {
                $(this).val(value);
                $(this).css("backgroundColor", "");
            });
        }
    }//changeValueIndLocal


    // Fill in the opener form the value of the indicator
    function useValue(ind, field, openerField, close)
    {
        var obj = $("#" + field + "_ind" + ind);
        if (obj) {
            var value = obj.val();
            if (checkValueInd(obj.attr("id"), ind, field)) {
                if (opener) {
                    try {
                        for (var j=0; j < opener.document.f.elements.length; j++) {
                            if (opener.document.f.elements[j].name == openerField) {
                                opener.document.f.elements[j].value = value;
                                break;
                            }
                        }
                    } catch (e) { // for HTML5 browsers that don't allow accessing/changing variables to the opener
                        var origin = location.protocol + '//' + location.hostname + ((location.port)?':' + location.port:'');
                        window.opener.postMessage('indicators: useValue = ' + openerField + ';' + value, origin);
                    }
                    if (close) window.close();
                }
                return true;
            } else {
                var obja = $("#" + field + "_btn_usevalue_" + ind);
                if (obja) obja.attr('title', "Value " + value + " invalid for indicator " + ind);
                alert(_("Value ") + value + _(" invalid for indicator " + ind));
            }
        }
        return false;
    }//useValue


    // Fill in the form the value of the indicator
    function useValueLocal(openerField, value)
    {
        var $inputs = $('#f input:text[name=' + openerField + ']');
        if ($inputs.length > 0) {
            $inputs.each(function() {
                $(this).val(value);
            });
        }
    }//useValueLocal


    // Fill in the opener form the values
    function useValues(field, openerField1, openerField2)
    {
        if (useValue(1, field, openerField1, false) && useValue(2, field, openerField2, false)) {
            if (opener) window.close();
        }
    }//useValues

    var windowIndicators;

    // Launch the popup for the field with the current values
    function launchPopupValueIndicators(frameworkcode, type, tag, index, random)
    {
        var ind1 = "tag_" + tag + "_indicator1_" + index + random;
        var ind2 = "tag_" + tag + "_indicator2_" + index + random;
        var objInd1 = $("input:text[name^='" + ind1 + "']");
        var objInd2 = $("input:text[name^='" + ind2 + "']");
        if (objInd1 || objInd2) {
            var strParam = "&type=" + type;
            if (objInd1 != undefined) strParam += "&" + ind1 + "=" + ((objInd1.val())?objInd1.val():escape("#"));
            if (objInd2 != undefined) strParam += "&" + ind2 + "=" + ((objInd2.val())?objInd2.val():escape("#"));
            if (arguments.length == 6) {
                windowIndicators = (type == 'biblio')?window.open("/cgi-bin/koha/cataloguing/marc21_indicators.pl?biblionumber=" + arguments[5] + "&frameworkcode=" + frameworkcode + strParam, "valueindicators",'width=740,height=450,location=yes,toolbar=no,scrollbars=yes,resize=yes'):window.open("/cgi-bin/koha/cataloguing/marc21_indicators.pl?authid=" + arguments[5] + "&authtypecode=" + frameworkcode + strParam, "valueindicators",'width=740,height=450,location=yes,toolbar=no,scrollbars=yes,resize=yes');
            } else {
                windowIndicators = (type == 'biblio')?window.open("/cgi-bin/koha/cataloguing/marc21_indicators.pl?frameworkcode=" + frameworkcode + strParam, "valueindicators",'width=740,height=450,location=yes,toolbar=no,scrollbars=yes,resize=yes'):window.open("/cgi-bin/koha/cataloguing/marc21_indicators.pl?authtypecode=" + frameworkcode + strParam, "valueindicators",'width=740,height=450,location=yes,toolbar=no,scrollbars=yes,resize=yes');
            }
        }
    }//launchPopupValueIndicators


    var xmlDocInd;
    var tagFields;
    var errorAjax = false;

    // Look for the value indicator for a frameworkcode
    function send_ajax_indicators(code, type)
    {
        $.ajax({
            type: "POST",
            url: "/cgi-bin/koha/cataloguing/indicators_ajax.pl",
            dataType: "xml",
            async: true,
            "data": {code: code, type: type},
            "success": (arguments.length == 2)?receive_ok_indicators:receive_ok_indicators_for_opener
        });
        $("*").ajaxError(function(evt, request, settings){
            if (!errorAjax) {
                alert(_("AJAX error: receiving data from ") + settings.url);
                errorAjax = true;
            }
        });
    }//send_ajax_indicators


    function receive_ok_indicators(data, textStatus)
    {
        xmlDocInd = data.documentElement;
        getTagFields();
        if (windowIndicators) windowIndicators.location.reload(); 
    }//receive_ok_indicators


    // Called from the plugin to reload the xml data in the opener, so you can make changes in the framework's indicators
    // and validate the biblio record without reloading the page and losing the data of the form.
    function receive_ok_indicators_for_opener(data, textStatus)
    {
        try {
            window.opener.xmlDocInd = data.documentElement;
            getTagFields(true);
            window.opener.tagFields = tagFields;
            location.reload();
        } catch (e) {
            try { // for HTML5 browsers that don't allow accessing/changing variables to the opener
                var origin = location.protocol + '//' + location.hostname + ((location.port)?':' + location.port:'');
                window.opener.postMessage('indicators: xmlDocInd = ' + (new XMLSerializer()).serializeToString(data), origin);
                if (getTagFields(true)) {
                    var tagFieldsStr = '{';
                    for (var ind in tagFields) {
                        tagFieldsStr += '"' + ind + '" : ' + tagFields[ind] + ',';
                    }
                    tagFieldsStr = tagFieldsStr.substring(0, tagFieldsStr.length - 1);
                    tagFieldsStr += '};';
                    window.opener.postMessage('indicators: tagFields = ' + tagFieldsStr, origin);
                } else {
                    window.opener.postMessage('indicators: tagFieldsRemote = ', origin);
                }
                location.reload();
            } catch (e) {
            }
        }
    }//receive_ok_indicators


    // Get all input elements for indicators and store them on associative array for rapid accessing
    function getTagFields()
    {
        tagFields = new Array();
        var form;
        if (arguments.length == 1) {
            try {
                form = window.opener.document.f;
            } catch (e) {
                return false;
            }
        } else form = document.f;
        var name;
        var tag;
        for (var i=0; i < form.elements.length; i++) {
            name = form.elements[i].name;
            if (name && name.indexOf("tag_") == 0 && name.indexOf("_indicator") > 0) {
                tag = name.substr(4,3);
                tagFields[tag] = true;
            }
        }
        return true;
    }//getTagFields


    // Traverse the indicators xml data to check against fields in the form
    function checkValidIndFramework()
    {
        var strErrorInd = "";
        var numError = -1;
        if (xmlDocInd != undefined) {
            if (xmlDocInd.nodeName == "Error") {
            } else {
                if (xmlDocInd.nodeName == "Framework" && xmlDocInd.nodeType == 1 && xmlDocInd.hasChildNodes()) {
                    var nodeFields = xmlDocInd.getElementsByTagName('Fields')[0];
                    if (nodeFields && nodeFields.nodeType == 1 && nodeFields.hasChildNodes()) {
                        var nodeField = nodeFields.firstChild;
                        var tag;
                        var i = 1;
                        while (nodeField != null) {
                            if (nodeField.nodeType == 1) {
                                tag = nodeField.attributes.getNamedItem("tag").nodeValue;
                                if (nodeField.hasChildNodes()) {
                                    var objFieldsInd;
                                    var arrObj = search_koha_field(tag);
                                    if (arrObj != undefined && arrObj.length > 0) {
                                        for (var z = 0; z < arrObj.length; z++) {
                                            objFieldsInd = arrObj[z];
                                            if (objFieldsInd != undefined && (objFieldsInd.ind1 != undefined || objFieldsInd.ind2 != undefined)) {
                                                for (var j = 1; j <= 2; j++) {
                                                    var objInd;
                                                    if (j == 1 && objFieldsInd.ind1 != undefined) objInd = objFieldsInd.ind1;
                                                    else if (j == 2 && objFieldsInd.ind2 != undefined) objInd = objFieldsInd.ind2;
                                                    if (objInd != undefined) {
                                                        var valueInd = objInd.val();
                                                        if (!checkValidIndField(j, valueInd, nodeField)) {
                                                            strErrorInd += "The value \"" + valueInd + "\" is not valid for indicator " + j + " on tag " + tag + ". ";
                                                            numError++;
                                                            if (numError > 0 && (numError + 1) % 2 == 0) strErrorInd += "\n";
                                                            objInd.css("backgroundColor", "yellow");
                                                        } else {
                                                            objInd.css("backgroundColor" ,"");
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            nodeField = nodeField.nextSibling;
                            i++;
                        }
                    }
                }
            }
        }
        return strErrorInd;
    }//checkValidIndFramework


    // Check a value from an indicator against a node from the xml
    function checkValidIndField(ind, valueInd, nodeField)
    {
        try {
            var hasNodeInd = false;
            var nodeInd = nodeField.firstChild;
            while (nodeInd != null) {
                if (nodeInd.nodeType == 1 && (nodeInd.getAttributeNode("ind") || nodeInd.hasAttribute("ind"))) {
                    if (nodeInd.getAttribute("ind") == ind) {
                        hasNodeInd = true;
                        // return as valid if value is ok or is empty or is a blank
                        if (nodeInd.hasChildNodes() && nodeInd.firstChild.nodeValue == valueInd) return true;
                        else if (valueInd == "" || valueInd == " ") return true;
                    }
                }
                nodeInd = nodeInd.nextSibling;
            }
            // Return as valid if there's not a set of values for this indicator in this field
            if (!hasNodeInd) return true;
        } catch (e) {
            //alert("An exception occurred in the script. Error name: " + e.name + ". Error message: " + e.message);
        }
        return false;
    }//checkValidIndField


    // Class for store both indicators values
    function FieldIndicatorObject()
    {
    }//IndicatorObject

    FieldIndicatorObject.prototype = {
        ind1: undefined,
        ind2: undefined
    }

    // Search for the input text of the indicators for a tag in the form
    function search_koha_field(tag)
    {
        var resArr;
        if (tagFields != undefined && (tagFields[tag] == undefined || !tagFields[tag])) {
            return resArr;
        }
        resArr = new Array();
        var indTag = "tag_" + tag + "_indicator";
        var lengthIndTag = indTag.length;
        var pos;
        var ind1 = false;
        var ind2 = false;
        var obj;
        var name;
        var $inputs = $('input:text[name^="' + indTag + '"]');
        $inputs.each(function() {
            name = $(this).attr('name');
            if ((pos = name.indexOf(indTag)) >= 0) {
                if (!ind1 && !ind2) {
                    obj = new FieldIndicatorObject();
                }
                if (name.charAt(pos + lengthIndTag) == 1) {
                    ind1 = true;
                    obj.ind1 = $(this);
                } else {
                    ind2 = true;
                    obj.ind2 = $(this);
                }
                if (ind1 && ind2 && obj.ind1 != undefined && obj.ind2 != undefined) {
                    ind1 = false;
                    ind2 = false;
                    resArr.push(obj);
                }
            }
        });
        return resArr;
    }//search_koha_field



    // Block for dynamic HTML management of value indicators


    // Delete indicator block
    function delete_ind_value(id)
    {
        $('#ul_' + id).remove();
    }//delete_ind_value


    // Hide or show the indicator block
    function hideShowBlock(a, ind)
    {
        var ul_in = $("#ul_in_" + ind);
        if (ul_in.css('display') == "none") {
            ul_in.css('display', "block");
            a.title = "Hide: " + a.innerHTML;
        } else {
            ul_in.css('display', "none");
            a.title = "Show: " + a.innerHTML;
        }
    }//hideShowBlock


    // Change label to indicate whether is indicator 1 or 2
    function changeLabelInd(ind, obj)
    {
        var a_in = $('#a_in_' + ind);
        if (!(obj.value == '1' || obj.value == '2')) {
            obj.value = '';
            a_in.html(ind + ' - Indicator ' + obj.value);
        }
        a_in.html(ind + ' - Indicator ' + obj.value);
    }//changeLabelInd


    // Check whether the value is correct
    function checkValueIndCompleteSet(ind, obj)
    {
        var rege = new RegExp("^[abcdefghijklmnopqrstuvwxyz0123456789 ]$");
        if (rege.test(obj.value) || obj.value == "") {
            obj.title = "Value \"" + obj.value + "\" for Indicator " + ind + " is valid";
            obj.style.backgroundColor = "";
        } else {
            obj.title = "Value \"" + obj.value + "\"  for Indicator " + ind + " is not valid (abcdefghijklmnopqrstuvwxyz0123456789 )";
            obj.style.backgroundColor = "yellow";
        }
    }//checkValueIndCompleteSet


    // Add indicator block
    function add_ind_value()
    {
        var list = $('#marc_indicators_structure');
        if (list) {
            numInd++;
            var ul = $("<ol id='ul_" + numInd + "' style='width:590px' />");

            var li = $('<li />');
            li.text('\u00a0');
            ul.append(li);

            lli = $('<li />');
            var bold = $('<strong />');
            li.append(bold);
            var a = $("<a id='a_in_" + numInd + "' href='javascript:void(0)' onclick='hideShowBlock(this, " + numInd + ")' />");
            a.text(numInd + " - Indicator");
            bold.append(a);
            ul.append(li);

            li = $("<li id='ul_in_" + numInd + "' style='display:block' />");
            ul.append(li);
            var ul2 = $("<ol />");
            li.append(ul2);

            var li2 = $('<li />');
            label = $("<label for='ind_" + numInd + "' title='Type of indicator: 1 or 2' />");
            label.text('Type of indicator');
            li2.append(label);
            input = $("<input type='text' size='1' maxlength='1' name='ind_" + numInd + "' id='ind_" + numInd + "' onkeyup='changeLabelInd(" + numInd + ", this)' />");
            li2.append(input);
            ul2.append(li2);

            li2 = $('<li />');
            label = $("<label for='ind_value_" + numInd + "' title='Value: only one char allowed' />");
            label.text('Value');
            li2.append(label);
            input = $("<input type='text' size='1' maxlength='1' name='ind_value_" + numInd + "' id='ind_value_" + numInd + "' onkeyup='checkValueIndCompleteSet(" + numInd + ", this)' />");
            li2.append(input);
            ul2.append(li2);

            li2 = $('<li />');
            label = $("<label for='ind_desc_" + numInd + "' />");
            label.text('Description');
            li2.append(label);
            input = $("<textarea cols='80' rows='4' name='ind_desc_" + numInd + "' id='ind_desc_" + numInd + "' />");
            li2.append(input);
            ul2.append(li2);

            var del = $("<input type='button' value='Delete' onclick='delete_ind_value(" + numInd + ")' />");
            li2 = $('<li />');
            li2.append(del);
            ul2.append(li2);

            list.append(ul);
        }
    }//add_ind_value


