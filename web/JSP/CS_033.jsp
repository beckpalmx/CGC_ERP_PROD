
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="com.cgc.DB.D_job_order_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_job_order_detail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_job_order_detail objdb = new DataBeanD_job_order_detail();
    D_job_order_detailDAO objex = new D_job_order_detailDAO();


%>
<%

            int total = 0;
            int statusck = 0;
            int statusnum = 0;
            String SQL = "";
            if (request.getParameter("status_a") != null) {
                statusck = 1;
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_job_order_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_job_order_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag = 'N'");
                    if (statusnum == 0) {
                        objdb.setLine_no(Integer.toString(15));
                    } else {
                        SQL = "select line_no from d_job_order_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag = 'N' order by to_number(line_no,'999') desc";
                        DBConnect objcon = new DBConnect();
                        Connection con = objcon.openNewConnection();
                        ResultSet rs = con.createStatement().executeQuery(SQL);

                        while (rs.next()) {
                            if(rs.isFirst()){
                            statusnum = Integer.parseInt(rs.getString("line_no"));
                            break;
                            }
                        }
                        rs.close();
                        con.close();
                        objdb.setLine_no(Integer.toString(statusnum + 1));
                    }
                }
            } else if (request.getParameter("status_u") != null) {
                statusck = 2;
                objdb.setLine_no(request.getParameter("line_no"));

            } else if (request.getParameter("status_d") != null) {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            } else {
                statusck = -1;
            }
            if (request.getParameter("doc_id") != null) {
                objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            }
            if (request.getParameter("param") != null) {
                objdb.setParam(en.EncodeTexttoTIS(request.getParameter("param")));
            }
            if (request.getParameter("method") != null) {
                objdb.setMethod(en.EncodeTexttoTIS(request.getParameter("method")));
            }
            if (request.getParameter("spec") != null) {
                objdb.setSpec(en.EncodeTexttoTIS(request.getParameter("spec")));
            }
            if (request.getParameter("add_desc") != null) {
                objdb.setAdd_desc(en.EncodeTexttoTIS(request.getParameter("add_desc")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));

            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                    }
                    break;
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("แก้ไขสำเร็จ");
                    }
                    break;
                case 3:

                    if (request.getParameter("chk_all") != null) {
                        objex.Delete_line_no_All(objdb);
                    } else {
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);

                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>