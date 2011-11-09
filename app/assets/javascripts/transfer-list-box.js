function move(tbFrom, tbTo) {
    var arrFrom = new Array();
    var arrTo = new Array();
    var arrLU = new Array();
    var i;
    for (i = 0; i < tbTo.options.length; i++) {
        arrLU[tbTo.options[i].text] = tbTo.options[i].value;
        arrTo[i] = tbTo.options[i].text;
    }
    var fLength = 0;
    var tLength = arrTo.length;
    for (i = 0; i < tbFrom.options.length; i++) {
        arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
        if (tbFrom.options[i].selected && tbFrom.options[i].value != "") {
            arrTo[tLength] = tbFrom.options[i].text;
            tLength++;
        }
        else {
            arrFrom[fLength] = tbFrom.options[i].text;
            fLength++;
        }
    }

    tbFrom.length = 0;
    tbTo.length = 0;
    var ii;

    for (ii = 0; ii < arrFrom.length; ii++) {
        var no = new Option();
        no.value = arrLU[arrFrom[ii]];
        no.text = arrFrom[ii];
        tbFrom[ii] = no;
    }

    for (ii = 0; ii < arrTo.length; ii++) {
        var no = new Option();
        no.value = arrLU[arrTo[ii]];
        no.text = arrTo[ii];
        tbTo[ii] = no;
    }
}