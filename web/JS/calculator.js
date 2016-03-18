/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function format_date_thai(date_input,time_input){
    var return_object = {
        day:parseInt(date_input.substr(0, 2),10),
        month:parseInt(date_input.substr(3, 2),10),
        year:parseInt(date_input.substr(6, 4),10)-543,
        hours:parseInt(time_input.substr(0, 2),10),
        minutes:parseInt(time_input.substr(3, 2),10)
        };
        return return_object;
}
function difference_date_and_time(date_from,time_from,date_to,time_to){
    var obj_from = new format_date_thai(date_from,time_from);
    var obj_to = new format_date_thai(date_to,time_to);
    var d_from = new Date(obj_from.year,obj_from.month,obj_from.day,obj_from.hours,obj_from.minutes);
    var d_to = new Date(obj_to.year,obj_to.month,obj_to.day,obj_to.hours,obj_to.minutes);
    var output_diff = d_to - d_from;
    var h_diff = 0;
    var m_diff = 0;
    output_diff = output_diff/60/1000;
    if(output_diff >= 60){
        h_diff = Math.floor(output_diff/60);
        m_diff = output_diff % 60;
    }else{
        m_diff = output_diff % 60;
    }
    return (h_diff < 0 || m_diff < 0)?alert("not difference now"):(h_diff < 10 ? "0"+h_diff:h_diff)+"."+(m_diff < 10 ? "0"+m_diff:m_diff);
}
/*
 * use => difference_date_and_time(date_from,time_from,date_to,time_to)
 * <input type = "text" id="test" onclick = ""/>
 * <script type = "text/javascript">document.getElementById("test").onclick = function(){var out_put = difference_date_and_time('01-01-2557','20.30','01-01-2556','21.00');this.value = out_put == undefined ?"":out_put;};</script>
 */
