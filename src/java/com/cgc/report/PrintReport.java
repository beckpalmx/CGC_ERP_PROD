package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.bean.TReport_LogBean;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;
import com.cgc.Util.StringQuery;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class PrintReport {

    //private static final String company_code = "10";
    private static String sub_menu_id = "";
    private static String employee_id_s = "";
    private static String date_form_send = "";
    private static String date_to_send = "";

    StringQuery objStringQuery;
    TReport_LogBean LogBean = new TReport_LogBean();
    Random r = new Random();

    public void printReport_1(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {
        Connection connection;
        connection = new DBConnect().openNewConnection();
        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("SQL_CODE", sql);
        hashMap.put("fileName", report_code);
        hashMap.put("company_name", Mcompany(connection));
        try (ServletOutputStream servletOutputStream = response.getOutputStream()) {
            InputStream reportStream = path;

            response.setContentType("application/pdf");
            String file = "inline; filename=" + report_code + ".pdf";

            response.setHeader("Content-Disposition", file);

            //response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
            response.setBufferSize(1024);

            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

            System.out.println("servletOutputStream = " + servletOutputStream);
            System.out.println("hashMap = " + hashMap);

            connection.close();
            servletOutputStream.flush();
        }

    }

    public void printReport_2(HttpServletRequest request, HttpServletResponse response, InputStream path, String docId, String employee_id)
            throws Exception {
        ServletOutputStream servletOutputStream;
        try (Connection connection = new DBConnect().openNewConnection()) {
            String report_code = (String) request.getParameter("report_code");
            String doc_no = (String) request.getParameter("doc_no");
            String doc_eff_date = (String) request.getParameter("doc_eff_date");
            sub_menu_id = (String) request.getParameter("sub_menu_id");
            employee_id_s = employee_id;
            String Start_Date = LogTime("1");
            System.out.println("Start_Date = " + Start_Date);
            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("fileName", report_code);
            hashMap.put("DOC_ID", docId);
            hashMap.put("REPORT_UNAME", Memployee(connection));
            if ("".equals(sub_menu_id) || sub_menu_id == null) {
                hashMap.put("iso_doc_ref", doc_no);
            } else {
                hashMap.put("iso_doc_ref", Msub_docno(connection));
            }
            hashMap.put("iso_doc_date", doc_eff_date);
            hashMap.put("company_name", Mcompany(connection));
            hashMap.put("SUB_DOC_ID", docId);
            System.out.println("report_code : " + report_code);
            System.out.println("DOC_ID : " + docId);
            System.out.println("doc_eff_date : " + doc_eff_date);
            System.out.println("Memployee(connection) : " + Memployee(connection));
            System.out.println("sub_menu_id : " + sub_menu_id);
            System.out.println("Msub_docno(connection) : " + Msub_docno(connection));
            hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
            servletOutputStream = response.getOutputStream();
            InputStream reportStream = path;
            response.setContentType("application/pdf");
            String file = "inline; filename=" + report_code + ".pdf";
            response.setHeader("Content-Disposition", file);
            response.setBufferSize(1024);
            System.out.println(servletOutputStream);
            System.out.println("print out = ");
            System.out.println("reportStream = " + reportStream);
            System.out.println("servletOutputStream = " + servletOutputStream);
            System.out.println("hashMap = " + hashMap);
            System.out.println("connection = " + connection);
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);
            String End_Date = LogTime("1");
            System.out.println("End_Date = " + End_Date);

            LogBean.setReport_id(report_code);
            LogBean.setStart_date(Start_Date);
            LogBean.setEnd_date(End_Date);
            LogBean.setCreate_by("Report");
            Save_Report_log(connection, LogBean);
            System.out.println("print out final");
        }
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_3(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {
        String report_code = (String) request.getParameter("report_code");
        String date_to = (String) request.getParameter("date_to");
        String date_form = (String) request.getParameter("date_form");

        String Start_Date = LogTime("1");
        System.out.println("Start_Date = " + Start_Date);

        String size_id = (String) request.getParameter("spec_size");
        String iodine_id = (String) request.getParameter("iod_value");

        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        //String report_code = (String) request.getParameter("report_code");
        HashMap<String, Object> hashMap = new HashMap<>();
        ServletOutputStream servletOutputStream;
        try (Connection connection = new DBConnect().openNewConnection()) {
            hashMap.put("fileName", report_code);
            hashMap.put("company_name", Mcompany(connection));
            hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
            hashMap.put("SQL_CODE", sql);
            hashMap.put("DATE_FORM", date_form);
            hashMap.put("DATE_TO", date_to);
            System.out.print(sql);
            System.out.print("-----");
            System.out.print(report_code);
            servletOutputStream = response.getOutputStream();
            InputStream reportStream = path;
            response.setContentType("application/pdf");
            String file = "inline; filename=" + report_code + ".pdf";
            response.setHeader("Content-Disposition", file);
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);
            String End_Date = LogTime("1");
            System.out.println("End_Date = " + End_Date);

            LogBean.setReport_id(report_code);
            LogBean.setStart_date(Start_Date);
            LogBean.setEnd_date(End_Date);
            LogBean.setCreate_by("Report");
            Save_Report_log(connection, LogBean);
            System.out.println("servletOutputStream = " + servletOutputStream);
            System.out.println("hashMap = " + hashMap);
        }

        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_4(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {

        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        //String date_form = (String) request.getParameter("date_form");
        String date_form;
        String doc_date_form = "";
        String doc_date_to = "";
        String date_to = (String) request.getParameter("date_to");
        String location_id = (String) request.getParameter("location_id");

        String Start_Date = LogTime("1");
        System.out.println("Start_Date = " + Start_Date);

        //if (report_code.equals("RP_014") || report_code.equals("RP_014_1")) {
        //    date_form = "2556-12-22";
        //} else {
        date_form = (String) request.getParameter("date_form");
        //}

        System.out.println("date_form = " + date_form);

        String month_form = "";
        String year_form = "";
        String month_to = "";
        String year_to = "";

        System.out.println("DF : " + request.getParameter("date_form"));
        System.out.println("DT : " + request.getParameter("date_to"));

        if ((date_form != null) && (!date_form.trim().equals(""))) {
            doc_date_form = (String) date_form.substring(8, 10);
            month_form = (String) date_form.substring(5, 7);
            year_form = (String) date_form.substring(0, 4);
        }
        if ((date_to != null) && (!date_to.trim().equals(""))) {
            doc_date_to = (String) date_to.substring(8, 10);
            month_to = (String) date_to.substring(5, 7);
            year_to = (String) date_to.substring(0, 4);
        }

        System.out.println("--> report_code = " + report_code);

        if (report_code.equals("RP_022_D")) {
            if (location_id.equals("-")) {
                sql = " where month = '" + month_form + "'";
            } else {
                sql = " where month = '" + month_form + "' and location_id = '" + location_id + "'";
            }
        }

        if (report_code.equals("RP_023_A")
                || report_code.equals("RP_025_A")
                || report_code.equals("RP_025_B")
                || report_code.equals("RP_025_C")
                || report_code.equals("RP_025_D")) {
            if (!location_id.equals("-") && !(sql == null)) {
                sql = sql + " and location_id = '" + location_id + "'";
            }
        }

        String year_document = (String) request.getParameter("year_document");
        System.out.println("date_to = " + date_to);
        System.out.println("date_form = " + date_form);
        System.out.println("month_form = " + month_form);
        System.out.println("month_to = " + month_to);
        System.out.println("year_to = " + year_to);

        System.out.println("--> sql = " + sql);
        ServletOutputStream servletOutputStream;
        try (Connection connection = new DBConnect().openNewConnection()) {
            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
            hashMap.put("SQL_CODE", sql);
            hashMap.put("fileName", report_code);
            hashMap.put("DATE_FORM", date_form);
            hashMap.put("DATE_TO", date_to);
            hashMap.put("DOC_DATE_TO", doc_date_to);
            hashMap.put("MONTH_FORM", month_form);
            hashMap.put("YEAR_FORM", year_form);
            hashMap.put("MONTH_TO", month_to);
            hashMap.put("YEAR_TO", year_to);
            hashMap.put("YEAR_DOC", year_document);
            hashMap.put("company_name", Mcompany(connection));
            servletOutputStream = response.getOutputStream();
            InputStream reportStream = path;
            response.setContentType("application/pdf");
            String file = "inline; filename=" + report_code + ".pdf";
            response.setHeader("Content-Disposition", file);
            response.setBufferSize(1024);
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);
            String End_Date = LogTime("1");
            System.out.println("End_Date = " + End_Date);

            LogBean.setReport_id(report_code);
            LogBean.setStart_date(Start_Date);
            LogBean.setEnd_date(End_Date);
            LogBean.setCreate_by("Report");
            Save_Report_log(connection, LogBean);
            System.out.println("servletOutputStream = " + servletOutputStream);
            System.out.println("hashMap = " + hashMap);
        }
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_5(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {

        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        String date_to = (String) request.getParameter("date_to");
        String date_form = (String) request.getParameter("date_form");
        String year_document = (String) request.getParameter("year_document");
        Integer year_from, year_to;

        String Start_Date = LogTime("1");
        System.out.println("Start_Date = " + Start_Date);

        if ((date_form != null) && (!date_form.trim().equals(""))) {
            year_from = Integer.parseInt(date_form.substring(0, 4)) - 543;
            date_form_send = date_form.substring(8, 10) + "-" + date_form.substring(5, 7) + "-" + year_from.toString();
        }

        if ((date_to != null) && (!date_to.trim().equals(""))) {
            year_to = Integer.parseInt(date_to.substring(0, 4)) - 543;
            date_to_send = date_to.substring(8, 10) + "-" + date_to.substring(5, 7) + "-" + year_to.toString();
        }

        System.out.println("date_form_send = " + date_form_send);
        System.out.println("date_to_send = " + date_to_send);
        ServletOutputStream servletOutputStream;
        try (Connection connection = new DBConnect().openNewConnectionMySQL()) {
            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
            hashMap.put("SQL_CODE", sql);
            hashMap.put("fileName", report_code);
            hashMap.put("DATE_FORM", date_form_send);
            hashMap.put("DATE_TO", date_to_send);
            hashMap.put("YEAR_DOC", year_document);
            servletOutputStream = response.getOutputStream();
            InputStream reportStream = path;
            response.setContentType("application/pdf");
            String file = "inline; filename=" + report_code + ".pdf";
            response.setHeader("Content-Disposition", file);
            response.setBufferSize(1024);
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);
            String End_Date = LogTime("1");
            System.out.println("End_Date = " + End_Date);

            LogBean.setReport_id(report_code);
            LogBean.setStart_date(Start_Date);
            LogBean.setEnd_date(End_Date);
            LogBean.setCreate_by("Report");
            Save_Report_log(connection, LogBean);
            System.out.println("servletOutputStream = " + servletOutputStream);
            System.out.println("hashMap = " + hashMap);
        }
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_6(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {

        String report_code = (String) request.getParameter("report_code");
        String date_form = (String) request.getParameter("date_form");
        String date_to = (String) request.getParameter("date_to");
        String year_document = (String) request.getParameter("year_document");
        ServletOutputStream servletOutputStream;
        try (Connection connection = new DBConnect().openNewConnection()) {
            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
            hashMap.put("SQL_CODE", sql);
            hashMap.put("fileName", report_code);
            hashMap.put("DATE_FORM", date_form);
            hashMap.put("DATE_TO", date_to);
            hashMap.put("YEAR_DOC", year_document);
            hashMap.put("company_name", Mcompany(connection));
            servletOutputStream = response.getOutputStream();
            InputStream reportStream = path;
            response.setContentType("application/pdf");
            String file = "inline; filename=" + report_code + ".pdf";
            response.setHeader("Content-Disposition", file);
            response.setBufferSize(1024);
            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);
            System.out.println("servletOutputStream = " + servletOutputStream);
            System.out.println("hashMap = " + hashMap);
        }
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_7(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql, String date_form, String date_to, String report_code)
            throws Exception {
        try {

            //String report_code = (String) request.getParameter("report_code");    
            System.out.println("path = " + path);
            System.out.println("report_code = " + report_code);
            System.out.println("date_form = " + date_form);
            System.out.println("date_to = " + date_to);
            ServletOutputStream servletOutputStream;
            try (Connection connection = new DBConnect().openNewConnection()) {
                HashMap<String, Object> hashMap = new HashMap<>();
                hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
                hashMap.put("SQL_CODE", sql);
                hashMap.put("fileName", report_code);
                hashMap.put("DATE_FORM", date_form);
                hashMap.put("DATE_TO", date_to);
                hashMap.put("company_name", Mcompany(connection));
                servletOutputStream = response.getOutputStream();
                InputStream reportStream = path;
                response.setContentType("application/pdf");
                String file = "inline; filename=" + report_code + ".pdf";
                response.setHeader("Content-Disposition", file);
                response.setBufferSize(1024);
                JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);
                System.out.println("servletOutputStream = " + servletOutputStream);
                System.out.println("hashMap = " + hashMap);
            }
            servletOutputStream.flush();
            servletOutputStream.close();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            System.out.println(" To Continue ... ");
        }

    }

    public static String Msub_docno(Connection con) throws Exception {
        String str_return = "";
        ResultSet rs;
        try (Connection connection = new DBConnect().openNewConnection()) {
            rs = connection.createStatement().executeQuery("select doc_no from mmenu_sub where sub_menu_id = '" + sub_menu_id + "'");
            while (rs.next()) {
                str_return = rs.getString("doc_no");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            //if (rs != null) {
            //rs.close();
            //}            
        }
        return str_return;

    }

    public static String Mcompany(Connection con) throws Exception {
        String str_return = "";
        ResultSet rs;
        try (Connection connection = new DBConnect().openNewConnection()) {
            //rs = con.createStatement().executeQuery("select name_t from mcompany where company_id = '" + company_code + "'");
            rs = connection.createStatement().executeQuery("select name_t from mcompany where delete_flag = 'N' and doc_type = 'Y'");
            while (rs.next()) {
                str_return = rs.getString("name_t");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            //if (rs != null) {
            //rs.close();
            //}            
        }

        return str_return;

    }

    public static String Memployee(Connection con) throws Exception {
        String str_return = "";
        ResultSet rs;
        try (Connection connection = new DBConnect().openNewConnection()) {
            rs = connection.createStatement().executeQuery("select fullname from vemployee_fullname where emp_id = '" + employee_id_s + "'");
            while (rs.next()) {
                str_return = rs.getString("fullname");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            //if (rs != null) {
            //rs.close();
            //}
        }
        return str_return;
    }

    public static String Report_Name(String screen_id) throws Exception {
        
        String str_return = "";
        ResultSet rs;
        try (Connection connection = new DBConnect().openNewConnection()) {            
            //rs = con.createStatement().executeQuery("select name_t from mcompany where company_id = '" + company_code + "'");
            rs = connection.createStatement().executeQuery("select name_t from mmenu_sub where delete_flag = 'N' and screen_id = '" + screen_id + "'");
            while (rs.next()) {
                str_return = rs.getString("name_t");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {                        
            System.out.println(str_return);
        }        
        return str_return;

    }

    public void Save_Report_log(Connection con, TReport_LogBean ReportBean) throws Exception {
        String[] String_insert = new String[]{
            "log_print_id",
            "report_id",
            "report_name",
            "start_date",
            "end_date",
            "time_usage",
            "create_date",
            "create_by",
            "company_name"
        };
        objStringQuery = new StringQuery();
        PreparedStatement p;
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        Date d1 = sdf.parse(ReportBean.getStart_date());
        Date d2 = sdf.parse(ReportBean.getEnd_date());

        System.out.println("d1 = " + d1);
        System.out.println("d2 = " + d2);

        long diff = d2.getTime() - d1.getTime();
        long diffSeconds = diff / 1000 % 60;
        long diffMinutes = diff / (60 * 1000) % 60;
        long diffHours = diff / (60 * 60 * 1000) % 24;

        String r_create = ReportBean.getReport_id() + "_" + Long.toString(Math.abs(r.nextLong()), 36);

        int i = 1;
        try (Connection connection = new DBConnect().openNewConnection()) {
            p = connection.prepareStatement(objStringQuery.Insert_String(String_insert, "t_print_report_log"));
            p.setString(i, r_create);
            i += 1;
            p.setString(i, ReportBean.getReport_id());
            i += 1;
            p.setString(i, Report_Name(ReportBean.getReport_id()));
            i += 1;
            p.setString(i, ReportBean.getStart_date());
            i += 1;
            p.setString(i, ReportBean.getEnd_date());
            i += 1;
            p.setString(i, (String.format("%02d", diffHours) + ":" + String.format("%02d", diffMinutes) + ":" + String.format("%02d", diffSeconds)));
            i += 1;
            p.setTimestamp(i, new Timestamp(new java.util.Date().getTime()));
            i += 1;
            p.setString(i, ReportBean.getCreate_by());
            i += 1;
            p.setString(i, Mcompany(con));
            i += 1;
            p.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            System.out.println("Report Log = " + r_create);
        }
    }

    public static String LogTime(String Condition) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
        String str_return = sdf.format(cur_time);
        return str_return;
    }

}
