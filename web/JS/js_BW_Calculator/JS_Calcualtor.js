/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

///สูตรคำนวณหน้าจอ CS_033
var fix = 2;
function Total_cassava(amount_cassava,fresh_skin,soil_skin){
    return toFixed((parseFloat(amount_cassava) - parseFloat(fresh_skin) - parseFloat(soil_skin)),fix);
}
function Amount_cassava1(total_cassava,percent_tapioca){
    return toFixed((parseFloat(total_cassava) * parseFloat(percent_tapioca))/100,fix);
}
function Total_milling_time(m_time,total_stop_milling_hour){
    return toFixed((parseFloat(m_time) - parseFloat(total_stop_milling_hour)),fix);
}
function Milling_ratio(amount_cassava,total_milling_time){
    return toFixed((parseFloat(amount_cassava) / parseFloat(total_milling_time)),fix);
}
function Total_roast_time(r_time,total_stop_roast_hour){
    return toFixed((parseFloat(r_time) - parseFloat(total_stop_roast_hour)),fix);
}
///สูตรคำนวณหน้าจอ CS_033