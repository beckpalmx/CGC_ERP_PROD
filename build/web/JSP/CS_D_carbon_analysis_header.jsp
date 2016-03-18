<%@page import="com.cgc.Util.Runer_Doc_id_New"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.bean.DataBeanCS_D_carbon_analysis_detail"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.CS_D_carbon_analysis_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanCS_D_carbon_analysis_header"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%

    String[] request_String_name = new String[]{
        "A_doc_id",
        "A_doc_date",
        "A_job_type",
        "A_lab_leader_id",
        "A_doc_type",
        "A_send_doc_time"

    };
    ArrayList<DataBeanCS_D_carbon_analysis_detail> objAL = new ArrayList<DataBeanCS_D_carbon_analysis_detail>();
    ThaiUtil en = new ThaiUtil();
    DataBeanCS_D_carbon_analysis_header objdb = new DataBeanCS_D_carbon_analysis_header();
    CS_D_carbon_analysis_headerDAO objex = new CS_D_carbon_analysis_headerDAO();
    Runer_Doc_id_New objrunno = new Runer_Doc_id_New();
    UtiDatabase uti = new UtiDatabase();
    UserBean userbean = (UserBean) session.getAttribute("user");
    int statusck = 0;//เลือกการทำงาน
    int status_complete_flag = 0;//สถานะเอกสารสมบูรณ์  
    int statusnum, statusnum2 = 0;//นับ row ของข้อมูล    
    int i = 0, maxline = 0;
    if (request.getParameter("D_status") == null && request.getParameter("status_runid") == null) {

        System.out.println("Second lab confirm value = " + request.getParameter("quality_confirm"));
        System.out.println("Second A_lab_leader_id value = " + request.getParameter("A_lab_leader_id"));

        statusnum = uti.numRowdatabase("SELECT Count(doc_id) As num from  d_carbon_analysis_all_header where doc_id = '" + request.getParameter("A_doc_id") + "' and delete_flag = 'N' ");
        statusnum2 = uti.numRowdatabase("SELECT Count(doc_id) As num from  d_carbon_analysis_all_detail where doc_id = '" + request.getParameter("A_doc_id") + "' and delete_flag = 'N' ");

        //+ "and (product_id <> '') and (size_name <> '') and (product_no <> '') "
        //+ "and (wh_product_id is null or wh_product_id = '' or wh_id is null or wh_id = '' or location_id is null or location_id = '' ) ");
        System.out.println("statusnum = " + statusnum);
        System.out.println("statusnum2 = " + statusnum2);

        if (statusnum == 0) {
            if (uti.numRowdatabase("SELECT Count(doc_id) As num from  d_carbon_analysis_all_header where doc_id = '" + request.getParameter("A_doc_id") + "' and delete_flag = 'N' ") == 1) {
                //if (uti.numRowdatabase("SELECT Count(doc_id) As num from  d_carbon_send_product_header where doc_id = '" + request.getParameter("A_doc_id") + "' and delete_flag = 'N' and wh_leader_confirm = 'Y'") == 1) {
                statusck = -1;
            } else {
                statusck = 1;
            }
        } else if (statusnum == 1) {
            statusck = 2;
        } else {
            statusck = -2;
        }

        //----------------------------SetData--------------------------------------
        if (statusck == 1 || (statusck == 2 && request.getParameter("confirm") != null)) {
            if (statusck == 1) {
                maxline = Integer.parseInt(request.getParameter("maxline"));
                System.out.println("maxline = " + maxline);
            }
            objdb.setDoc_id(request.getParameter(request_String_name[i]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));
            i += 1;
            objdb.setDoc_date(request.getParameter(request_String_name[i]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));
            i += 1;
            objdb.setJob_type(request.getParameter(request_String_name[i]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));
            i += 1;            
            //System.out.println("setLab_leader_id = " + en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));            
            objdb.setLab_leader_id(request.getParameter(request_String_name[i]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));
            i += 1;
            objdb.setDoc_type(request.getParameter(request_String_name[i]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));
            i += 1;
            objdb.setSend_doc_time(request.getParameter(request_String_name[i]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[i]).trim()));
            i += 1;           
            
            objdb.setQuality_confirm(request.getParameter("quality_confirm"));
            objdb.setLab_emp_id(request.getParameter("lab_emp_id"));
            
            System.out.println("quality_confirm = " + request.getParameter("quality_confirm"));

            objdb.setBy(userbean.getUsername());
            objdb.setDate(new Timestamp(new java.util.Date().getTime()));

            if (statusck == 1) {
                for (int loop = 1; loop <= maxline; loop++) {
                    DataBeanCS_D_carbon_analysis_detail bean = new DataBeanCS_D_carbon_analysis_detail();
                    bean.setLine_no(Integer.toString(loop));
                    bean.setBag_quatity(request.getParameter("P_bag_qty_" + loop).equals("") || request.getParameter("P_bag_qty_" + loop) == null ? "0" : en.EncodeTexttoTIS(request.getParameter("P_bag_qty_" + loop)));                                        
                    bean.setMachine_id(request.getParameter("P_machine_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_machine_" + loop)));                                        
                    bean.setJob_id(request.getParameter("P_job_id_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_job_id_" + loop)));
                    bean.setParam_header_id(request.getParameter("P_job_id_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_job_id_" + loop)));                    
                    bean.setProduct_id(request.getParameter("P_product_id_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_product_id_" + loop)));                    
                    bean.setSize_name(request.getParameter("P_size_id_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_size_id_" + loop)));                                        
                    bean.setProduct_no(request.getParameter("P_prod_no_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_prod_no_" + loop)));                    
                    bean.setH2o(request.getParameter("P_h2o_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_h2o_" + loop)));                    
                    bean.setButane(request.getParameter("P_butane_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_butane_" + loop)));                    
                    bean.setIod(request.getParameter("P_iod_" + loop) == null ? "" : en.EncodeTexttoTIS(request.getParameter("P_iod_" + loop)));                    
                    bean.setRemark(request.getParameter("P_remark_" + loop) == null ? "-" : en.EncodeTexttoTIS(request.getParameter("P_remark_" + loop)));
                    objAL.add(bean);

/*                    
                    if (loop==1) {
                    System.out.println("Final = " + request.getParameter("P_bag_qty_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_machine_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_job_id_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_product_id_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_size_id_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_prod_no_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_h2o_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_butane_" + loop) );
                    System.out.println("Final = " + request.getParameter("P_iod_" + loop) );                    
                    System.out.println("Final = " + request.getParameter("P_remark_" + loop) );                       
                    }    
*/        
                    
                }
            }

        }
        //-------------------------------------------------------------------------

    } else if (request.getParameter("D_status") != null) {
        if (uti.numRowdatabase("SELECT Count(doc_id) As num from  d_carbon_send_product_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("A_doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
            status_complete_flag = 1;

            System.out.println("2. status_complete_flag= " + status_complete_flag);
        }
        statusck = Integer.parseInt(request.getParameter("D_status"));
        objdb.setDoc_id(request.getParameter(request_String_name[0]) == null ? "" : en.EncodeTexttoTIS(request.getParameter(request_String_name[0]).trim()));
        objdb.setBy(userbean.getUsername());
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));

        System.out.println("3. status_complete_flag= " + status_complete_flag);

    } else if (request.getParameter("status_runid") != null) {
        statusck = Integer.parseInt(request.getParameter("status_runid"));
    }

    System.out.println("statusck= " + statusck);

    System.out.println("final status_complete_flag= " + status_complete_flag);

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว !!!");
            break;
        case 1:
            objdb.setDoc_id(objrunno.Run_id_DB(request.getParameter("A_screen_id"), objdb.getDoc_date(), request.getParameter("A_dept_doc_id")));
            objex.insert(objdb, objAL);
            objAL.clear();
            out.print("บันทึกสำเร็จ");
            break;
        case 2:
            if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                objex.update(objdb);
                out.print("แก้ไขสำเร็จ");
            } else {
                out.print("edit");
            }
            break;
        case 3:
            objex.updel(objdb);
            out.print("ลบข้อมูลสำเร็จ");
            break;
        case 4:
            out.print(new Runer_Doc_id_New().Run_id("d_product_accept_header"));
            break;
        default:
            out.print("No Statment");
            break;
    }
%>