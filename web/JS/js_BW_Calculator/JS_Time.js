/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//*********************เป็นการตรวจสอบรูปแบบของเวลาว่าถูกต้องหรือไม่*****************************
function Check_Time_Value(Input_Time){
    var regexp = new RegExp(/([0-9]{2})+.([0-9]{2})/);
    if(regexp.test(Input_Time.value)){
        //alert("ถูกต้อง");
        var array_time = Input_Time.value.split(".");
        if( (parseInt(array_time[0]) >= 0 && parseInt(array_time[0]) <= 23) && (parseInt(array_time[1]) >= 0 && parseInt(array_time[0]) <= 59)){
            //alert("True");
        }else{
            alert("กรุณาใส่รูปแบบเวลาให้ถูกต้อง");
            Input_Time.focus();
        }
    }else{
        alert("กรุณาใส่รูปแบบเวลาให้ถูกต้อง");
        Input_Time.focus();
    }
}
//******************************************************************************

//*********************************หาช่วงเวลา*********return ตือ ชัวโมงทั้งหมด
function Time_Difference(Time_from,Time_to){
    if(parseFloat(document.getElementById(Time_from).value) > parseFloat(document.getElementById(Time_to).value)){
        alert("กรุณาตรวจสอบเวลา");
        document.getElementById(Time_from).focus();
    }else{
        var hh_cal=0;
        var min_cal = 0;
        var data_time_from  = document.getElementById(Time_from).value.split(".");
        var data_time_to  = document.getElementById(Time_to).value.split(".");
        var hh_to = data_time_to[0].indexOf("0", 0) == "0" ? parseInt(data_time_to[0].substr(1, 1),10) :parseInt(data_time_to[0],10);
        var min_to = data_time_to[1].indexOf("0", 0) == "0" ? parseInt(data_time_to[1].substr(1, 1),10) :parseInt(data_time_to[1],10);
        var hh_from = data_time_from[0].indexOf("0", 0) == "0" ? parseInt(data_time_from[0].substr(1, 1),10) :parseInt(data_time_from[0],10);
        var min_from = data_time_from[1].indexOf("0", 0) == "0" ? parseInt(data_time_from[1].substr(1, 1),10) :parseInt(data_time_from[1],10);

        if(min_to < min_from){
            hh_to -= 1;
            min_cal = (min_to + 60) - min_from;
            hh_cal = hh_to - hh_from;
        }else{
            min_cal = min_to -  min_from;
            hh_cal = hh_to - hh_from;
        }
    }
    
}
//******************************************************************************

function Time_Difference2(Date_from,Date_to,Time_from,Time_to){
    var string_totaltime ="";
    if(ChkDate2(document.getElementById(Date_from).value,document.getElementById(Date_to).value)){
        //alert("");
    }else{
        var day_cal = Count_Date2(document.getElementById(Date_from).value,document.getElementById(Date_to).value);
        //alert(day_cal);
        if(parseFloat(document.getElementById(Time_from).value) > parseFloat(document.getElementById(Time_to).value) && day_cal == 0){
            alert("กรุณาตรวจสอบเวลา");
            document.getElementById(Time_from).focus();
        }else{

            var hh_cal=0;
            var min_cal = 0;
            var data_time_from  = document.getElementById(Time_from).value.split(".");
            var data_time_to  = document.getElementById(Time_to).value.split(".");
            var hh_to = data_time_to[0].indexOf("0", 0) == "0" ? parseInt(data_time_to[0].substr(1, 1),10) :parseInt(data_time_to[0],10);
            var min_to = data_time_to[1].indexOf("0", 0) == "0" ? parseInt(data_time_to[1].substr(1, 1),10) :parseInt(data_time_to[1],10);
            var hh_from = data_time_from[0].indexOf("0", 0) == "0" ? parseInt(data_time_from[0].substr(1, 1),10) :parseInt(data_time_from[0],10);
            var min_from = data_time_from[1].indexOf("0", 0) == "0" ? parseInt(data_time_from[1].substr(1, 1),10) :parseInt(data_time_from[1],10);

            if(min_to < min_from){
                hh_to += day_cal > 0 ?  (24*day_cal) : 0;
                hh_to -= 1;
                min_cal = (min_to + 60) - min_from;
                hh_cal = hh_to - hh_from;
            }else{
                hh_to += day_cal > 0 ? (24*day_cal) : 0;
                //alert(hh_to);
                min_cal = min_to -  min_from;
                hh_cal = hh_to - hh_from;
            }
            if(day_cal != 0){
            }
            string_totaltime =  hh_cal  < 10 ? "0"+hh_cal+".":hh_cal+".";
            string_totaltime += min_cal  < 10 ? "0"+min_cal:min_cal;
            
        }
        return string_totaltime;
    }

}

function Count_Date2(value_date_from,value_date_to){
    var count_date = 0 ;
    var day_2 = 0;
    //--------------------date_to---------------------------
    var d_to = parseInt(value_date_to.substr(0, 2), 10);
    var m_to = parseInt(value_date_to.substr(3, 2), 10);
    var y_to = parseInt(value_date_to.substr(6, 4), 10);
    //--------------------date_from-------------------------
    var d_from = parseInt(value_date_from.substr(0, 2), 10);
    var m_from = parseInt(value_date_from.substr(3, 2), 10);
    var y_from = parseInt(value_date_to.substr(6, 4), 10);
    //-------------------------------------------------------
    if((y_to - y_from) == 0){
        if((m_to - m_from) == 0){
            count_date = (d_to - d_from);
        }else if((m_to - m_from) > 0){
            if(m_from == 2){
                day_2 = ((y_from-543)%4) == 0 ? 29:28;
                day_2 = (day_2-d_from);
                count_date = day_2 + d_to;
            }else if(m_from == 4 || m_from == 6 || m_from == 9 || m_from == 11){
                count_date = (30 - d_from)+1;
                count_date = count_date + d_to;
            }else{
                count_date = (31 - d_from);
                count_date = count_date + d_to;
            }
        }else{
            count_date = 0;
        }

    }
    return count_date;
}
function ChkDate2(Date_from,Date_to){
    var return_chk = false;
    var number_day_from = parseInt(Date_from.substr(0, 2),10);
    var number_month_from = parseInt(Date_from.substr(3, 2),10);
    var number_year_from = parseInt(Date_from.substr(6, 4),10);
    var number_day_to = parseInt(Date_to.substr(0, 2),10);
    var number_month_to = parseInt(Date_to.substr(3, 2),10);
    var number_year_to = parseInt(Date_to.substr(6, 4),10);
    var ans_day = number_day_to - number_day_from;
    //alert(ans_day);
    var ans_month = number_month_to - number_month_from;
    //alert(ans_month);
    var ans_year = number_year_to - number_year_from;
    //alert(ans_year);
    if(ans_year < 0){
        return_chk = true;
    }else if (ans_year == 0){
        if(ans_month < 0){
            return_chk = true;
        }else if(ans_month == 0){
            if(ans_day < 0){
                return_chk = true;
            }else if(ans_day == 0){
                return_chk = false;
            }else{
                return_chk = false;
            }
        }else{

            return_chk = false;
        }
    }else{
        return_chk = false;
    }
    return return_chk;
}
function Format_Date(Output_Value,String_Input_Date){
    getId(Output_Value).value = String_Input_Date = String_Input_Date.substr(8, 2)+String_Input_Date.substr(3, 2)+String_Input_Date.substr(0, 2);
}
