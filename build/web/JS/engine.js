/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function Format_Date(Output_Value,String_Input_Date){
    getId(Output_Value).value = String_Input_Date = String_Input_Date.substr(8, 2)+String_Input_Date.substr(3, 2)+String_Input_Date.substr(0, 2);
}

