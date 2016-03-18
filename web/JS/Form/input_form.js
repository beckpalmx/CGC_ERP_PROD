/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var counter = 1;
var limit = 24;
function addInput(divName) {

    var newdiv = document.createElement('div');

    //newdiv.innerHTML = "Entry " + (counter + 1) + " <br><input class='inputs1' type='text' name='myInputs_'>";   
    
        Str_Info_Header = "<div class='row'>"
                //+ " <div class='col-md-1'></div>"                
                + "<label class='control-label col-md-1 columnlabel1'></label>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH1' id='inputH1' size='7' value='วันที่'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH2' id='inputH2' size='7' value='เตา'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH3' id='inputH3' size='7' value='เวลา (น.)'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH4' id='inputH4' size='7' value='วันที่'  disabled/></font></div>"        
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH5' id='inputH5' size='7' value='เตา'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH6' id='inputH6' size='7' value='เวลา (น.)'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH7' id='inputH7' size='7' value='วันที่'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH8' id='inputH8' size='7' value='เตา'  disabled/></font></div>"        
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH9' id='inputH9' size='7' value='เวลา (น.)'  disabled/></font></div>"        
                + "</div>";        
    
        Str_Info_Detail = "<div class='row'>"
                //+ "<div class='col-md-1'></div>"
                + "<label class='control-label col-md-1 columnlabel1'></label>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa1_' " + counter + "id='inputa1_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa2_' " + counter + "id='inputa2_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa3_' " + counter + "id='inputa3_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa4_' " + counter + "id='inputa4_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa5_' " + counter + "id='inputa5_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa6_' " + counter + "id='inputa6_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa7_' " + counter + "id='inputa7_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa8_' " + counter + "id='inputa8_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='inputa9_' " + counter + "id='inputa9_'"+ counter + " size='7' value='' /></div>"
                + "</div>";    
            
        Str_Header = "<div class='row'>"
                //+ " <div class='col-md-1'></div>"                
                + "<label class='control-label col-md-1 columnlabel1'>ลำดับที่</label>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH1' id='inputH1' size='7' value='ชนิด'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH2' id='inputH2' size='7' value='บิวเทน'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH3' id='inputH3' size='7' value='เฉลี่ย'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH4' id='inputH4' size='7' value='ชนิด'  disabled/></font></div>"        
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH5' id='inputH5' size='7' value='บิวเทน'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH6' id='inputH6' size='7' value='เฉลี่ย'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH7' id='inputH7' size='7' value='ชนิด'  disabled/></font></div>"
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH8' id='inputH8' size='7' value='บิวเทน'  disabled/></font></div>"        
                + " <div class='col-md-1'><font color = 'blue'><input type='text' class='inputs1' name='inputH9' id='inputH9' size='7' value='เฉลี่ย'  disabled/></font></div>"        
                + "</div>";    

    for (counter = 1; counter <= limit; counter++) {
        Str_Detail = "<div class='row'>"
                //+ "<div class='col-md-1'><input type='checkbox' class='' name='chk_box_' id='chk_box_'/></div>"
                + "<label class='control-label col-md-1 columnlabel1'>" + counter + "</label>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input1_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input2_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input3_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input4_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input5_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input6_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input7_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input8_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + " <div class='col-md-1'><input type='text' class='inputs1' name='input9_' " + counter + "id='input_'"+ counter + " size='7' value='' /></div>"
                + "</div>";
        
        newdiv.innerHTML = newdiv.innerHTML + Str_Detail;
        
    }        
    
    newdiv.innerHTML = Str_Info_Header + Str_Info_Detail + Str_Header + newdiv.innerHTML;
    
    document.getElementById(divName).appendChild(newdiv);
}