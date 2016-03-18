<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.report.PrintReport"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page language="java" trimDirectiveWhitespaces="true"%>
<%! InputStream path;
    String report_code, docId, start, end, employee_id, report_cond1, report_cond2, price_year, SQL;
    int type, cond;
    PrintReport report = new PrintReport();
%>
<%
    report_code = (String) request.getParameter("report_code");
    price_year = (String) request.getParameter("price_year");
    type = Integer.parseInt((String) request.getParameter("type_report"));
    path = getServletConfig().getServletContext().getResourceAsStream("/REPORT/" + report_code + ".jasper");
    SQL = "";

    System.out.println("price_year = " + request.getParameter("price_year"));

    if (report_code.equals("RP_059") || report_code.equals("RP_059_RAW")) {
        if (!(price_year.equals("-")) && !(price_year.equals(null)) && !(price_year.equals("")) && !(price_year.equals("price_year"))) {
            if (!SQL.equals("")) {
                SQL = SQL + " AND price_year = '" + price_year + "'";
            } else {
                SQL = SQL + " WHERE price_year = '" + price_year + "'";
            }
            System.out.append("SQL = " + SQL);
        }
    }

    if (type == 1) {
        System.out.println("SQL = " + SQL);
        report.printReport_1(request, response, path, SQL);
    } else if (type == 2) {
        //JOptionPane.showConfirmDialog(null, request.getParameter("wh_in_desc"));
        if (request.getParameter("doc_id") != null) {
            docId = (String) request.getParameter("doc_id");
            employee_id = (String) request.getParameter("emp_id");
        } else if (request.getParameter("A_doc_id") != null) {
            docId = (String) request.getParameter("A_doc_id");
            employee_id = (String) request.getParameter("emp_id");
        } else {
            docId = (String) request.getParameter("DOC_ID_desc");
            employee_id = (String) request.getParameter("emp_id");
        }
        System.out.println("Case 2 ");
        System.out.println("doc_id : " + (String) request.getParameter("doc_id"));
        System.out.println("A_doc_id : " + (String) request.getParameter("A_doc_id"));
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
        String location_id = (String) request.getParameter("location_id");
        String product_id = (String) request.getParameter("product_id");
        SQL = "";

        System.out.println(cond);
        System.out.println("------------------");
        System.out.println("Size Catbon = " + request.getParameter("spec_size"));
        System.out.println("iod_value = " + request.getParameter("iod_value"));

        if (!start.equals("")) {

            if (cond == 3) {
                SQL = SQL + " WHERE job_id between '" + start + "' AND '" + end + "' ";
            } else {
                SQL = SQL + " WHERE doc_id between '" + start + "' AND '" + end + "' ";
            }

            if (!date_form.equals("")) {
                SQL = SQL + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD')";
            }
        } else if (!date_form.equals("")) {
            SQL = SQL + "WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
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

        if (!(product_id.equals("-")) && !(product_id.equals(null)) && !(product_id.equals(""))) {
            if (!SQL.equals("")) {
                SQL = SQL + " AND product_id = '" + product_id + "'";
            } else {
                SQL = SQL + " WHERE product_id = '" + product_id + "'";
            }
        }

        if (!(location_id.equals("-")) && !(location_id.equals(null)) && !(location_id.equals(""))) {
            if (!SQL.equals("")) {
                SQL = SQL + " AND location_id = '" + location_id + "'";
            } else {
                SQL = SQL + " WHERE location_id = '" + location_id + "'";
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
        String location_id = (String) request.getParameter("location_id");
        String product_id = (String) request.getParameter("product_id");
        String friction_house = (String) request.getParameter("friction_house");

        String SQL = "";
        System.out.println("date_form = " + date_form);
        System.out.println("date_to = " + date_to);
        System.out.println("p_id = " + p_id);
        System.out.println("pg_id = " + pg_id);
        System.out.println("wh_id = " + wh_id);
        System.out.println("branch_id = " + branch_id);
        System.out.println("friction_house = " + friction_house);
        System.out.println("report code = " + report_code);
        System.out.println("-------------------------");
        System.out.println(" product_id = " + request.getParameter("product_id"));
        System.out.println(" pgroup_id = " + request.getParameter("pgroup_id"));
        System.out.println(" warehouse_id = " + request.getParameter("warehouse_id"));
        System.out.println(" date_to = " + request.getParameter("date_to"));
        System.out.println(" date_form = " + request.getParameter("date_form"));
        System.out.println(" branch = " + request.getParameter("branch"));
        System.out.println(" location_id = " + request.getParameter("location_id"));
        System.out.println(" friction_house = " + request.getParameter("friction_house"));

        if (report_code.equals("RP_012")) {
            SQL = " WHERE pgroup_id like '" + pg_id + "%' ";
            if (branch_id.equalsIgnoreCase("K")) {
                SQL = SQL + " AND branch_id <> 'B' ";
                System.out.println("Case 1: " + SQL);
            } else {
                SQL = SQL + " AND branch_id = 'B' ";
                System.out.println("Case 2: " + SQL);
            }
        }

        System.out.println("Step = 1 ");

        if (report_code.equalsIgnoreCase("RP_028") || report_code.equalsIgnoreCase("RP_029") || report_code.equalsIgnoreCase("RP_0795")) {
            //SQL = " WHERE wh_id like '" + wh_id + "%'";
            System.out.println("DATE : " + date_form + " - " + date_to);
            if (!date_form.equalsIgnoreCase("") && !date_to.equalsIgnoreCase("")) {
                SQL = SQL + " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            }

        } else {
            SQL = " WHERE pgroup_id like '" + pg_id + "%' ";
        }

        System.out.println("Step = 2 ");

        if (!wh_id.equalsIgnoreCase("")) {
            SQL = SQL + " AND wh_id like '" + wh_id + "%' ";
            System.out.println("Step = 2.1 ");
        }

        System.out.println("Step = 3 ");

        if (!branch_id.equalsIgnoreCase("") && !(report_code.equalsIgnoreCase("RP_028")) && !(report_code.equalsIgnoreCase("RP_029"))
                && !(report_code.equalsIgnoreCase("RP_015")) && !(report_code.equalsIgnoreCase("RP_015_1"))) {
            SQL = SQL + " AND branch_id like '" + branch_id + "%' ";
            System.out.println("RP Report Case 1: " + SQL);
        }

        System.out.println("Step = 4 ");

        if (!(location_id.equals("-")) && !(location_id.equals(null)) && !(location_id.equals(""))) {
            if (!SQL.equals("")) {
                SQL = SQL + " AND location_id = '" + location_id + "' ";
            } else {
                SQL = SQL + " WHERE location_id = '" + location_id + "' ";
            }
        }

        System.out.println("Step = 5 ");

        if (!(friction_house.equals("-")) && !(friction_house.equals(null)) && !(friction_house.equals(""))) {
            if (!SQL.equals("")) {
                SQL = SQL + " AND friction_house = '" + friction_house + "' ";
            } else {
                SQL = SQL + " WHERE friction_house = '" + friction_house + "' ";
            }
        }

        System.out.println("Step = 6 ");

        if (!(product_id.equals("-")) && !(product_id.equals(null)) && !(product_id.equals(""))) {
            if (!SQL.equals("")) {
                SQL = SQL + " AND product_id = '" + product_id + "' ";
            } else {
                SQL = SQL + " WHERE product_id = '" + product_id + "' ";
            }
        }

        System.out.println("Step = 8 ");

        if (report_code.equalsIgnoreCase("RP_015") || report_code.equalsIgnoreCase("RP_015_1")) {

            if (!date_form.equalsIgnoreCase("") && !date_to.equalsIgnoreCase("")) {
                String date_start = "";
                //date_start = date_form.substring(0, 5) + "01-01";
                date_start = "2556-12-24";
                System.out.print("date start : " + date_start);
                SQL = SQL + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_start + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";

            }
        }

        System.out.println("Step = 9 ");

        if (report_code.equalsIgnoreCase("RP_014") || report_code.equalsIgnoreCase("RP_014_1")) {
            SQL = " WHERE pgroup_id like '" + pg_id + "%' ";
            System.out.println("DATE : " + date_form + " - " + date_to);
            if (!date_form.equalsIgnoreCase("") && !date_to.equalsIgnoreCase("")) {
                String date_start = "";
                //date_start = date_form.substring(0, 5) + "01-01";
                date_start = "2556-12-22";
                System.out.print("date start : " + date_start);
                SQL = SQL + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_start + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";

            }
        }

        System.out.println("Step = 10 ");

        if (report_code.equalsIgnoreCase("RP_VTMP_STOCK_DAILY") || report_code.equalsIgnoreCase("RP_VTMP_STOCK_RAWMAT_FRICTION_DAILY")) {

            if (!date_form.equalsIgnoreCase("") && !date_to.equalsIgnoreCase("")) {
                SQL = " Where to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            }
        }

        System.out.println("Step = 11 ");

        if (report_code.equalsIgnoreCase("RP_021_RAW_REC_WITDRAW_FRICTION")
                || report_code.equalsIgnoreCase("RP_021_WH")
                || report_code.equalsIgnoreCase("RP_021_WH_2")
                || report_code.equalsIgnoreCase("RP_021_RAW_FRICTION")
                || report_code.equalsIgnoreCase("RP_RAWMAT_TRANS_V1")
                || report_code.equalsIgnoreCase("RP_RAWMAT_RAW_TRANS_V1")
                || report_code.equalsIgnoreCase("RP_015_WH_BALANCE")
                || report_code.equalsIgnoreCase("RP_015_RAW_BALANCE")
                || report_code.equalsIgnoreCase("RP_VTMP_STOCK_NOT_MOVEMENT")) {
            SQL = "";
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
        String location_id = (String) request.getParameter("location_id");
        String product_id2 = (String) request.getParameter("product_id2");
        String wh_id = (String) request.getParameter("wh_id");

        //System.out.println(job_type_id);
        System.out.println("status : " + status);
        System.out.println("status1 : " + status1);
        System.out.println("status2 : " + status2);
        System.out.println("location_id : " + location_id);
        System.out.println("product_id2 : " + product_id2);
        String SQL = " ";

        //SQL = SQL + "WHERE to_date(doc_date,'DD-MM-YYYY') between '" + date_form + "' AND '" + date_to + "' ";
        if (status.equals("1")) {
            SQL = SQL + "WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
            SQL = SQL + " AND job_type_id = '" + job_type_id + "'";
        } else {
            SQL = SQL + "WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + date_form + "'),'YYYY-MM-DD') AND to_date(format_date2('" + date_to + "'),'YYYY-MM-DD') ";
        }

        if (status1.equals("1") && (status.equals("0") || status.equals(""))) {
            System.out.println("product_id : " + product_id);
            SQL = SQL + " AND product_id = '" + product_id + "'";
        }

        if (status2.equals("1") && (status.equals("0") || status.equals(""))) {
            System.out.println("supplier_id : " + supplier_id);
            SQL = SQL + " AND supplier_id = '" + supplier_id + "'";
        }

        if (!product_id2.equals("") && !product_id2.equals("-")) {
            System.out.println("product_id2 : " + product_id2);
            SQL = SQL + " AND product_id = '" + product_id2 + "'";
        }

        if (!wh_id.equals("") && !wh_id.equals("-")) {
            String rp_code = report_code.substring(0, 8);
            System.out.println("rp_code" + rp_code);
            System.out.println("wh_id : " + wh_id);

            if (rp_code.equals("RP_025_C")) {
                SQL = SQL + " AND friction_house = '" + wh_id + "'";
            }

            if (rp_code.equals("RP_025_D")) {
                SQL = SQL + " AND wh_id = '" + wh_id + "'";
            }
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