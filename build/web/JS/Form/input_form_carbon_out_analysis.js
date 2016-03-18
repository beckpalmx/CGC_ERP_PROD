/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function addHeader(divName) {
    var Headerdiv = document.createElement('div');

    Str_Info_Header = "<div class='row'>"
            //+ " <div class='col-md-1'></div>"                
            + "<label class='control-label col-md-1 columnlabel1'></label>"
            + " <div class='col-md-1'><font color = 'blue'><b><input type='button' class='inputs1' name='inputIH1' id='inputIH1' size='7' value='วันที่'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'blue'><b><input type='button' class='inputs1' name='inputIH2' id='inputIH2' size='7' value='เตา'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'blue'><b><input type='button' class='inputs1' name='inputIH3' id='inputIH3' size='7' value='เวลา (น.)'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'green'><b><input type='button' class='inputs1' name='inputIH4' id='inputIH4' size='7' value='วันที่'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'green'><b><input type='button' class='inputs1' name='inputIH5' id='inputIH5' size='7' value='เตา'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'green'><b><input type='button' class='inputs1' name='inputIH6' id='inputIH6' size='7' value='เวลา (น.)'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'red'><b><input type='button' class='inputs1' name='inputIH7' id='inputIH7' size='7' value='วันที่'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'red'><b><input type='button' class='inputs1' name='inputIH8' id='inputIH8' size='7' value='เตา'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'red'><b><input type='button' class='inputs1' name='inputIH9' id='inputIH9' size='7' value='เวลา (น.)'  disabled/></b></font></div>"
            + "</div>";

    Str_Info_Detail = "<div class='row'>"
            //+ "<div class='col-md-1'></div>"
            + "<label class='control-label col-md-1 columnlabel1'></label>"
            + " <div class='col-md-1'><a id='date_2'><font color = 'blue'><input type='text' class='inputs' name='tdate1' id='tdate1' size='7' readonly='true' onmousedown=\"Calendar.setup({inputField: 'tdate1', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});\"/></font></a></div>"
            + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='tname1' id='tname1' size='7' value='' /></font></div>"
            + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='ttime1' id='ttime1' size='7' value='' /></font></div>"
            + " <div class='col-md-1'><a id='date_3'><font color = 'green'><input type='text' class='inputs' name='tdate2' id='tdate2' size='7' readonly='true' onmousedown=\"Calendar.setup({inputField: 'tdate2', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_3', singleClick: true, step: 1});\"/></font></a></div>"
            + " <div class='col-md-1'><font color = 'green'><input type='text' class='inputs1' name='tname2' id='tname2' size='7' value='' /></font></div>"
            + " <div class='col-md-1'><font color = 'green'><input type='text' class='inputs1' name='ttime2' id='ttime2' size='7' value='' /></font></div>"
            + " <div class='col-md-1'><a id='date_4'><font color = 'red'><input type='text' class='inputs' name='tdate3' id='tdate3' size='7' readonly='true' onmousedown=\"Calendar.setup({inputField: 'tdate3', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_4', singleClick: true, step: 1});\"/></font></a></div>"
            + " <div class='col-md-1'><font color = 'red'><input type='text' class='inputs1' name='tname3' id='tname3' size='7' value='' /></font></div>"
            + " <div class='col-md-1'><font color = 'red'><input type='text' class='inputs1' name='ttime3' id='ttime3' size='7' value='' /></font></div>"
            + "</div>";

    Str_Header = "<div class='row'>"
            //+ " <div class='col-md-1'></div>"
            + "<label class='control-label col-md-1 columnlabel1'>ลำดับที่</label>"
            + " <div class='col-md-1'><font color = 'blue'><b><input type='button' class='inputs1' name='inputH1' id='inputH1' size='7' value='ชนิด'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'blue'><b><input type='button' class='inputs1' name='inputH2' id='inputH2' size='7' value='บิวเทน'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'blue'><b><input type='button' class='inputs1' name='inputH3' id='inputH3' size='7' value='เฉลี่ย'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'green'><b><input type='button' class='inputs1' name='inputH4' id='inputH4' size='7' value='ชนิด'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'green'><b><input type='button' class='inputs1' name='inputH5' id='inputH5' size='7' value='บิวเทน'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'green'><b><input type='button' class='inputs1' name='inputH6' id='inputH6' size='7' value='เฉลี่ย'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'red'><b><input type='button' class='inputs1' name='inputH7' id='inputH7' size='7' value='ชนิด'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'red'><b><input type='button' class='inputs1' name='inputH8' id='inputH8' size='7' value='บิวเทน'  disabled/></b></font></div>"
            + " <div class='col-md-1'><font color = 'red'><b><input type='button' class='inputs1' name='inputH9' id='inputH9' size='7' value='เฉลี่ย'  disabled/></b></font></div>"
            + "</div>";

    Headerdiv.innerHTML = Str_Info_Header + Str_Info_Detail + Str_Header;
    //Headerdiv.innerHTML = Str_Info_Detail + Str_Header;
    document.getElementById(divName).appendChild(Headerdiv);

}

function addInput(divName) {
    var counter = 1;
    var limit = 24;

    var newdiv = document.createElement('div');

    for (counter = 1; counter <= limit; counter++) {
        Str_Detail = "<div class='row'>"
                //+ "<div class='col-md-1'><input type='checkbox' class='' name='chk_box_' id='chk_box_'/></div>"
                + "<label class='control-label col-md-1 columnlabel1'>" + counter + "</label>"
                //+ " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='c_type1_" + counter + "' id='c_type1_" + counter + "' size='7' value= " + (getId("c_type").value) + " /></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='c_type1_" + counter + "' id='c_type1_" + counter + "' size='7' readonly='true' value= " + (getId("c_type").value) + " onclick=\"openBrWindow(\'vmrawmat&textinput=c_type1_" + counter + "\', 0, \'Search_Detail.jsp\')\" /></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='bu1_" + counter + "' id='bu1_" + counter + "' size='7' value='' onkeypress=\"IsNuber(this.value, this)\" /></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='avg1_" + counter + "' id='avg1_" + counter + "' size='7' value='' /></font></div>"
                //+ " <div class='col-md-1'><font color = 'green'><input type='text' class='inputs1' name='c_type2_" + counter + "' id='c_type2_" + counter + "' size='7' value= " + (getId("c_type").value) + " /></font></div>"
                + " <div class='col-md-1'><font color = 'green'><input type='text' class='inputs1' name='c_type2_" + counter + "' id='c_type2_" + counter + "' size='7' readonly='true' value= " + (getId("c_type").value) + " onclick=\"openBrWindow(\'vmrawmat&textinput=c_type2_" + counter + "\', 0, \'Search_Detail.jsp\')\" /></font></div>"
                + " <div class='col-md-1'><font color = 'green'><input type='text' class='inputs1' name='bu2_" + counter + "' id='bu2_" + counter + "' size='7' value='' onkeypress=\"IsNuber(this.value, this)\" /></font></div>"
                + " <div class='col-md-1'><font color = 'green'><input type='text' class='inputs1' name='avg2_" + counter + "' id='avg2_" + counter + "' size='7' value='' /></font></div>"
                //+ " <div class='col-md-1'><font color = 'red'><input type='text' class='inputs1' name='c_type3_" + counter + "' id='c_type3_" + counter + "' size='7' value= " + (getId("c_type").value) + " /></font></div>"
                + " <div class='col-md-1'><font color = 'red'><input type='text' class='inputs1' name='c_type3_" + counter + "' id='c_type3_" + counter + "' size='7' readonly='true' value= " + (getId("c_type").value) + " onclick=\"openBrWindow(\'vmrawmat&textinput=c_type3_" + counter + "\', 0, \'Search_Detail.jsp\')\" /></font></div>"
                + " <div class='col-md-1'><font color = 'red'><input type='text' class='inputs1' name='bu3_" + counter + "' id='bu3_" + counter + "' size='7' value='' onkeypress=\"IsNuber(this.value, this)\" /></font></div>"
                + " <div class='col-md-1'><font color = 'red'><input type='text' class='inputs1' name='avg3_" + counter + "' id='avg3_" + counter + "' size='7' value='' /></font></div>"
                + "</div>";

        newdiv.innerHTML = newdiv.innerHTML + Str_Detail;

    }
    //alert(newdiv.innerHTML);
    document.getElementById("InsertBtn").disabled = true;
    document.getElementById(divName).appendChild(newdiv);

}