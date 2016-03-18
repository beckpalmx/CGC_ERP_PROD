<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.report.PrintReport"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%! InputStream path;
    String report_code, docId, start, end, employee_id,report_cond1,report_cond2;
    int type, cond;
    PrintReport report = new PrintReport();
%>
<%
    report_code = (String) request.getParameter("report_code");
    type = Integer.parseInt((String) request.getParameter("type_report"));
    path = getServletConfig().getServletContext().getResourceAsStream("/REPORT/" + report_code + ".jasper");
    if (type == 1) {
        report.printReport_1(request, response, path);
    } else if (type == 2) {
        //JOptionPane.showConfirmDialog(null, request.getParameter("wh_in_desc"));
        if (request.getParameter("doc_id") != null) {
            docId = (String) request.getParameter("doc_id");
            employee_id = (String) request.getParameter("emp_id");
        } else {
            docId = (String) request.getParameter("DOC_ID_desc");
            employee_id = (String) request.getParameter("emp_id");
        }
        System.out.println("doc_no : " + (String) request.getParameter("doc_no"));
        System.out.println("DOC_ID : " + docId);
        System.out.println("Emp_ID : " + employee_id);

        report.printReport_2(request, response, path, docId, employee_id);
    } else if (type == 3) {        
        report_code = (String) request.getParameter("report_code");
        cond = Integer.parseInt((String) request.getParameter("cond_report"));
        start = (String) request.getParameter("param_f");
        end = (String) request.getParameter("param_t");
        report_cond1 = (String) request.getParameter("report_cond1");
        report_cond2 = (String) request.getParameter("report_cond2");
        String date_to = (String) request.getParameter("date_to");
        String date_form = (String) request.getParameter("date_form");
        String spec_size = (String) request.getParameter("spec_size");
        String iod_value = (String) request.getParameter("iod_value");
        String SQL = "";
        System.out.println(cond);
        System.out.println("------------------");

        System.out.println("Size Catbon = " + request.getParameter("spec_size"));
        System.out.println("iod_value = " + request.getParameter("iod_value"));

        if (!start.equals("")) {

            if (cond == 3) {
                SQL = SQL + "where job_id between '" + start + "' AND '" + end + "' ";
            } else {
                SQL = SQL + "where doc_id between '" + start + "' AND '" + end + "' ";
            }

            if (!date_form.equals("")) {
                SQL = SQL + "AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD')";
            }
        } else if (!date_form.equals("")) {
            SQL = SQL + "where to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
        }

        /*  สำหรับรายงาน RP_075 สรุปใบแจ้งการผลิต*/
        
        System.out.println("report_cond1 : " + report_cond1);
        System.out.println("report_cond2 : " + report_cond2);
        
        //if ((!spec_size.equals("0")) && (report_code.equals("RP_075"))) {
        if ((!spec_size.equals("0")) && (report_cond1.equals("1"))) {        
           if (!SQL.equals("")) {
                SQL = SQL + " AND size_id = " + spec_size;
            } else {
                SQL = SQL + " WHERE size_id = " + spec_size;
            }
        }
        
        
        
        /*  สำหรับรายงาน RP_075 สรุปใบแจ้งการผลิต*/

        //JOptionPane.showConfirmDialog(null, SQL);
        System.out.println(SQL);
        report.printReport_3(request, response, path, SQL);

    } else if (type == 4) {
        String p_id = (String) request.getParameter("product_id");
        String pg_id = (String) request.getParameter("pgroup_id");
        String wh_id = (String) request.getParameter("warehouse_id");
        String date_to = (String) request.getParameter("date_to");
        String date_form = (String) request.getParameter("date_form");
        String branch_id = (String) request.getParameter("branch");
        String SQL = "";
        if (!p_id.equals("")) {
            SQL = "where product_id = '" + p_id + "' ";
            if (!pg_id.equals("")) {
                SQL = SQL + "AND pgroup_id = '" + pg_id + "' ";
            }
            if (!wh_id.equals("")) {
                SQL = SQL + "AND warehouse_id = '" + wh_id + "' ";
            }
            if (!date_to.equals("")) {
                //SQL = SQL + "AND date(update_date) between '" + date_form + "' AND '" + date_to + "'";
                SQL = SQL + "AND to_date(to_char(update_date,'YYYY-MM-DD'),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            }
        } else if (!pg_id.equals("")) {
            SQL = "where pgroup_id = '" + pg_id + "' ";
            if (!wh_id.equals("")) {
                SQL = SQL + "AND warehouse_id = '" + wh_id + "' ";
            }
            if (!date_to.equals("")) {
                //SQL = SQL + "AND date(update_date) between '" + date_form + "' AND '" + date_to + "'";
                SQL = SQL + "AND to_date(to_char(update_date,'YYYY-MM-DD'),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            }
        } else if (!wh_id.equals("")) {
            SQL = "where warehouse_id = '" + wh_id + "' ";
            if (!date_to.equals("")) {
                //SQL = SQL + "AND date(update_date) between '" + date_form + "' AND '" + date_to + "'";
                SQL = SQL + "AND to_date(to_char(update_date,'YYYY-MM-DD'),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            }
        } else if (!date_form.equals("")) {
            //SQL = "where date(update_date) between '" + date_form + "' AND '" + date_to + "'";
            SQL = "where to_date(to_char(update_date,'YYYY-MM-DD'),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
        }

        System.out.println("Before : " + SQL);

        if (report_code.equalsIgnoreCase("RP_012")) {
            if (SQL.isEmpty()) {
                SQL = " where branch_id = '" + branch_id + "' ";
                System.out.println("Case 1: " + SQL);
            } else {
                SQL = SQL + " and branch_id = '" + branch_id + "' ";
                System.out.println("Case 2: " + SQL);
            }
        }

        System.out.println("Final : " + SQL);
        report.printReport_4(request, response, path, SQL);

    } else if (type == 5) {
        //JOptionPane.showConfirmDialog(null, request.getParameter("date_to"));

        String date_form = (String) request.getParameter("date_form");
        String date_to = (String) request.getParameter("date_to");
        String job_type_id = (String) request.getParameter("job_type_id");
        String status = (String) request.getParameter("status");
        String status1 = (String) request.getParameter("status1");
        String status2 = (String) request.getParameter("status2");
        String product_id = (String) request.getParameter("product_id");
        String supplier_id = (String) request.getParameter("supplier_id");
        String year_document = (String) request.getParameter("year_document");


        //System.out.println(job_type_id);
        System.out.println("status : " + status);
        System.out.println("status1 : " + status1);
        System.out.println("status2 : " + status2);
        String SQL = " ";

        //SQL = SQL + "where to_date(doc_date,'DD-MM-YYYY') between '" + date_form + "' AND '" + date_to + "' ";
        if (status.equals("1")) {
            SQL = SQL + "where to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            SQL = SQL + " and job_type_id = '" + job_type_id + "'";
        } else {
            SQL = SQL + "where to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
        }

        if (status1.equals("1") && (status.equals("0") || status.equals(""))) {
            SQL = SQL + " and product_id = '" + product_id + "'";
        }

        if (status2.equals("1") && (status.equals("0") || status.equals(""))) {
            SQL = SQL + " and supplier_id = '" + supplier_id + "'";
        }
        //JOptionPane.showConfirmDialog(null, SQL);
        System.out.println(SQL);
        //System.out.println(report_code);

        String rp_code = report_code.substring(0, 6);
        System.out.println(rp_code);
        if (rp_code.equals("RP_073")) {
            System.out.println("Case 1 : " + rp_code);
            report.printReport_5(request, response, path, SQL);
        } else if (report_code.equals("RP_0718") || report_code.equals("RP_0719") || report_code.equals("RP_0758")) {
            report.printReport_6(request, response, path, SQL);
        } else {
            System.out.println("Case 2 : " + rp_code);
            report.printReport_4(request, response, path, SQL);
        }


    }
%>