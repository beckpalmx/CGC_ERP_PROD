<%@page import="java.text.DecimalFormat"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.Util.Process_Progress_Stock"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page isThreadSafe="false"%>

<%
    DataBean_Display_Document_Status obj_record = new DataBean_Display_Document_Status();
    Display_Document_Status r_c = new Display_Document_Status();
    Process_Progress_Stock Process_Progress = new Process_Progress_Stock();
    int statusck = 0, percent = 100, record_complete = 0;
    double percent_complete = 0.00;
    DecimalFormat formatter = new DecimalFormat("#0");
    String Sql_Str = "";
    String runer_id = request.getParameter("runer_id");
    System.out.println("Count Check runer_id = " + runer_id);
    String[] parts = runer_id.split("-");
    runer_id = parts[0] + "'";
    int count_day = Integer.parseInt(parts[1]);
    
    System.out.println("Split runer_id = " + runer_id);

    Integer percent_obj = new Integer(percent);
    Integer count_day_obj = new Integer(count_day);
    double percent_count_day = percent_obj.doubleValue() / count_day_obj.doubleValue();
    
    String table_name = "tmp_stock_rawmat_friction_daily" ;

    //System.out.println("percent_count_day = " + percent_count_day);
    
    if (runer_id != null) {

        Sql_Str = " select count(*) as record_count from " + table_name + " where log_id = " + runer_id;

        statusck = 5;
        //System.out.println("runer_id <> null = " + runer_id);

        //System.out.println("Sql_Str  = " + Sql_Str);
        obj_record = r_c.Fn_Record_Count(obj_record, Sql_Str);
        record_complete = Integer.parseInt(obj_record.getRecord_count());
        percent_complete = percent_count_day * record_complete;
    }

    //System.out.println("statusck = " + statusck);
    switch (statusck) {

        case 5:
            //System.out.println("percent = " + percent);
            //System.out.println("count_day = " + count_day);
            //System.out.println("percent / count_day = " + percent / count_day);
            //System.out.println("getRecord_count = " + record_complete);

            //System.out.println("percent / count_day = " + (percent / count_day));
            //System.out.println("getRecord_count = " + record_complete);
            //System.out.println("percent_complete = " + percent_complete);
/*            
             String process_wait = "";
             if (percent_complete < 100) {
             process_wait = "ระบบกำลังประมวลผล กรุณารอสักครู่ ...";
             } else {
                
             String str_qry = "select max(create_date),min(create_date) from tmp_stock_rawmat_friction_daily " ; 
                
                
                
             }

             String str_complete1 = " \nประมวลผลเสร็จสิ้นแล้วจำนวน " + record_complete + " วัน ";
             String str_complete2 = " จากทั้งหมด " + count_day + " วัน ";
             String str_complete3 = " \nคิดเป็นเปอร์เซ็นต์ = " + formatter.format(percent_complete) + " % ";
             */
            
            out.print(Process_Progress.Check_Process("t_process_log_stock", percent_complete, record_complete, count_day,runer_id));

            //System.out.println("Record Count = " + obj_record.getRecord_count());
            break;
        default:
            out.print("No Statment");
            break;
    }

%>