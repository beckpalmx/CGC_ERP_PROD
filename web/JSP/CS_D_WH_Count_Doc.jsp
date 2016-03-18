<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page isThreadSafe="false"%>
<%
    DataBean_Display_Document_Status obj_record = new DataBean_Display_Document_Status();
    Display_Document_Status r_c = new Display_Document_Status();
    int statusck = 0;
    String Sql_Str = "";
    String runer_id = request.getParameter("runer_id");
    //System.out.println("runer_id = " + runer_id);
    if (runer_id != null) {

        if (runer_id.equals("1")) {
            // WH Check complete_flag and doc_type  CS_052
            Sql_Str = " select count(*) as record_count from vd_packing_product_header_wh where complete_flag <> 'Y' and  doc_type = 'Y'   ";
        } else if (runer_id.equals("2")) { 
            Sql_Str = " select count(*) as record_count from vd_packing_product_header_wh where complete_flag <> 'Y' and  doc_type = 'N'   ";
        } else if (runer_id.equals("3")) { 
            Sql_Str = " select count(*) as record_count from vd_packing_product_header where complete_flag <> 'Y' and  count_send_complete <> '0'   ";
        } else if (runer_id.equals("4")) { 
            Sql_Str = " select count(*) as record_count from vd_requisition_product_header where complete_flag <> 'Y' and  count_send_complete <> '0'   ";
        } else if (runer_id.equals("5")) { 
            Sql_Str = " select count(*) as record_count from vd_carbon_withdraw_header where complete_flag <> 'Y' and  count_send_complete <> '0'   ";
        } else if (runer_id.equals("6")) { 
            Sql_Str = " select count(*) as record_count from vd_carbon_return_header where complete_flag <> 'Y' and  count_send_complete <> '0'   ";
        } else if (runer_id.equals("7")) { 
            Sql_Str = " select count(*) as record_count from vd_carbon_burn_in_header where complete_flag <> 'Y' and  count_send_complete <> '0'   ";
        } else if (runer_id.equals("8")) { 
            Sql_Str = " select count(*) as record_count from vd_carbon_burn_in_header_wh where complete_flag <> 'Y' and doc_type <> 'Y' " ;
        } else if (runer_id.equals("9")) { 
            Sql_Str = " select count(*) as record_count from vd_carbon_burn_in_header_wh where complete_flag <> 'Y' and doc_type = 'Y' " ;
        } else if (runer_id.equals("10")) { 
            Sql_Str = " select count(*) as record_count from vd_packing_product_header where complete_flag <> 'Y' and  count_send_complete = '0'   ";
        }

        statusck = 5;
        //System.out.println("runer_id <> null = " + runer_id);

        //System.out.println("Sql_Str  = " + Sql_Str);
        obj_record = r_c.Fn_Record_Count(obj_record, Sql_Str);
    }

    //System.out.println("statusck = " + statusck);
    switch (statusck) {

        case 5:
            out.print(obj_record.getRecord_count());
            //System.out.println("Record Count = " + obj_record.getRecord_count());
            break;
        default:
            out.print("No Statment");
            break;
    }

%>