
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>

<%
ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_friction_receive_header objdb = new DataBeanD_carbon_friction_receive_header();
    D_carbon_friction_receive_headerDAO objex = new D_carbon_friction_receive_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
//JOptionPane.showConfirmDialog(null, request.getQueryString());
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_receive_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_receive_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                        statusck = -1;
                    } else {
                        statusck = 1;
                    }
                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            } else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            objdb.setComplete_flag(request.getParameter("complete_flag"));
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            objdb.setDoc_date(request.getParameter("doc_date"));
            objdb.setTime_from(request.getParameter("time_from"));
            objdb.setTime_to(request.getParameter("time_to"));
            objdb.setRunner_id(request.getParameter("runner_id"));
            objdb.setShift(request.getParameter("shift"));
            objdb.setWh_in(request.getParameter("wh_in"));
            objdb.setWh_out(request.getParameter("wh_out"));
            if (request.getParameter("loc_total") != null) {
                objdb.setLoc_total(request.getParameter("loc_total"));
            }
            if (request.getParameter("loc_1") != null) {
                objdb.setLoc_1(request.getParameter("loc_1"));
            }
            if (request.getParameter("s_bag_loc1") != null) {
                objdb.setS_bag_loc1(request.getParameter("s_bag_loc1"));
            }
            if (request.getParameter("q_bag_loc1") != null) {
                objdb.setQ_bag_loc1(request.getParameter("q_bag_loc1"));
            }
            if (request.getParameter("w_bag_loc1") != null) {
                objdb.setW_bag_loc1(request.getParameter("w_bag_loc1"));
            }
            if (request.getParameter("loc_1_desc") != null) {
                objdb.setLoc_1_desc(request.getParameter("loc_1_desc"));
            }
            if (request.getParameter("loc_2") != null) {
                objdb.setLoc_2(request.getParameter("loc_2"));
            }
            if (request.getParameter("s_bag_loc2") != null) {
                objdb.setS_bag_loc2(request.getParameter("s_bag_loc2"));
            }
            if (request.getParameter("q_bag_loc2") != null) {
                objdb.setQ_bag_loc2(request.getParameter("q_bag_loc2"));
            }
            if (request.getParameter("w_bag_loc2") != null) {
                objdb.setW_bag_loc2(request.getParameter("w_bag_loc2"));
            }
            if (request.getParameter("loc_2_desc") != null) {
                objdb.setLoc_2_desc(request.getParameter("loc_2_desc"));
            }
            if (request.getParameter("loc_3") != null) {
                objdb.setLoc_3(request.getParameter("loc_3"));
            }
            if (request.getParameter("s_bag_loc3") != null) {
                objdb.setS_bag_loc3(request.getParameter("s_bag_loc3"));
            }
            if (request.getParameter("q_bag_loc3") != null) {
                objdb.setQ_bag_loc3(request.getParameter("q_bag_loc3"));
            }
            if (request.getParameter("w_bag_loc3") != null) {
                objdb.setW_bag_loc3(request.getParameter("w_bag_loc3"));
            }
            if (request.getParameter("loc_3_desc") != null) {
                objdb.setLoc_3_desc(request.getParameter("loc_3_desc"));
            }
            if (request.getParameter("c_weight1") != null) {
                objdb.setC_weight1(request.getParameter("c_weight1"));
            }
            if (request.getParameter("c_weight2") != null) {
                objdb.setC_weight2(request.getParameter("c_weight2"));
            }
            if (request.getParameter("c_weight3") != null) {
                objdb.setC_weight3(request.getParameter("c_weight3"));
            }
            if (request.getParameter("c_weight4") != null) {
                objdb.setC_weight4(request.getParameter("c_weight4"));
            }
            if (request.getParameter("c_weight5") != null) {
                objdb.setC_weight5(request.getParameter("c_weight5"));
            }
            if (request.getParameter("c_weight6") != null) {
                objdb.setC_weight6(request.getParameter("c_weight6"));
            }
            if (request.getParameter("u_weight1") != null) {
                objdb.setU_weight1(request.getParameter("u_weight1"));
            }
            if (request.getParameter("u_weight2") != null) {
                objdb.setU_weight2(request.getParameter("u_weight2"));
            }
            if (request.getParameter("u_weight3") != null) {
                objdb.setU_weight3(request.getParameter("u_weight3"));
            }
            if (request.getParameter("u_weight4") != null) {
                objdb.setU_weight4(request.getParameter("u_weight4"));
            }
            if (request.getParameter("u_weight5") != null) {
                objdb.setU_weight5(request.getParameter("u_weight5"));
            }
            if (request.getParameter("u_weight6") != null) {
                objdb.setU_weight6(request.getParameter("u_weight6"));
            }
            if (request.getParameter("p_weight1") != null) {
                objdb.setP_weight1(request.getParameter("p_weight1"));
            }
            if (request.getParameter("p_weight2") != null) {
                objdb.setP_weight2(request.getParameter("p_weight2"));
            }
            if (request.getParameter("p_weight3") != null) {
                objdb.setP_weight3(request.getParameter("p_weight3"));
            }
            if (request.getParameter("p_weight4") != null) {
                objdb.setP_weight4(request.getParameter("p_weight4"));
            }
            if (request.getParameter("p_weight5") != null) {
                objdb.setP_weight5(request.getParameter("p_weight5"));
            }
            if (request.getParameter("p_weight6") != null) {
                objdb.setP_weight6(request.getParameter("p_weight6"));
            }
            //*********************************loc_
            if (request.getParameter("loc_c1") != null) {
                objdb.setLoc_c1(request.getParameter("loc_c1"));
            }
            if (request.getParameter("loc_c2") != null) {
                objdb.setLoc_c2(request.getParameter("loc_c2"));
            }
            if (request.getParameter("loc_c3") != null) {
                objdb.setLoc_c3(request.getParameter("loc_c3"));
            }
            if (request.getParameter("loc_c4") != null) {
                objdb.setLoc_c4(request.getParameter("loc_c4"));
            }
            if (request.getParameter("loc_c5") != null) {
                objdb.setLoc_c5(request.getParameter("loc_c5"));
            }
            if (request.getParameter("loc_c6") != null) {
                objdb.setLoc_c6(request.getParameter("loc_c6"));
            }
            if (request.getParameter("loc_p1") != null) {
                objdb.setLoc_p1(request.getParameter("loc_p1"));
            }
            if (request.getParameter("loc_p2") != null) {
                objdb.setLoc_p2(request.getParameter("loc_p2"));
            }
            if (request.getParameter("loc_p3") != null) {
                objdb.setLoc_p3(request.getParameter("loc_p3"));
            }
            if (request.getParameter("loc_p4") != null) {
                objdb.setLoc_p4(request.getParameter("loc_p4"));
            }
            if (request.getParameter("loc_p5") != null) {
                objdb.setLoc_p5(request.getParameter("loc_p5"));
            }
            if (request.getParameter("loc_p6") != null) {
                objdb.setLoc_p6(request.getParameter("loc_p6"));
            }
            if (request.getParameter("loc_u1") != null) {
                objdb.setLoc_u1(request.getParameter("loc_u1"));
            }
            if (request.getParameter("loc_u2") != null) {
                objdb.setLoc_u2(request.getParameter("loc_u2"));
            }
            if (request.getParameter("loc_u3") != null) {
                objdb.setLoc_u3(request.getParameter("loc_u3"));
            }
            if (request.getParameter("loc_u4") != null) {
                objdb.setLoc_u4(request.getParameter("loc_u4"));
            }
            if (request.getParameter("loc_u5") != null) {
                objdb.setLoc_u5(request.getParameter("loc_u5"));
            }
            if (request.getParameter("loc_u6") != null) {
                objdb.setLoc_u6(request.getParameter("loc_u6"));
            }
// Add For Bag And Weight 
             if (request.getParameter("c_bag_qty") != null) {
                objdb.setC_bag_qty(request.getParameter("c_bag_qty"));
            }
            if (request.getParameter("c_bag_weight") != null) {
                objdb.setC_bag_weight(request.getParameter("c_bag_weight"));
            }
            if (request.getParameter("p_bag_qty") != null) {
                objdb.setP_bag_qty(request.getParameter("p_bag_qty"));
            }
            if (request.getParameter("p_bag_weight") != null) {
                objdb.setP_bag_weight(request.getParameter("p_bag_weight"));
            }
            if (request.getParameter("u_bag_qty") != null) {
                objdb.setU_bag_qty(request.getParameter("u_bag_qty"));
            }
            if (request.getParameter("u_bag_weight") != null) {
                objdb.setU_bag_weight(request.getParameter("u_bag_weight"));
            }
            if (request.getParameter("c_bag_qty1") != null) {
                objdb.setC_bag_qty1(request.getParameter("c_bag_qty1"));
            }
            if (request.getParameter("c_bag_weight1") != null) {
                objdb.setC_bag_weight1(request.getParameter("c_bag_weight1"));
            }
            if (request.getParameter("p_bag_qty1") != null) {
                objdb.setP_bag_qty1(request.getParameter("p_bag_qty1"));
            }
            if (request.getParameter("p_bag_weight1") != null) {
                objdb.setP_bag_weight1(request.getParameter("p_bag_weight1"));
            }
            if (request.getParameter("u_bag_qty1") != null) {
                objdb.setU_bag_qty1(request.getParameter("u_bag_qty1"));
            }
            if (request.getParameter("u_bag_weight1") != null) {
                objdb.setU_bag_weight1(request.getParameter("u_bag_weight1"));
            }           
                       
            //objdb.
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }

            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1 && objdb.getComplete_flag().equals("N")) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print(objex.ReturnAlert());
                    }
                    //objdb = null;
                    break;
                case 2:
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        if (objex.update(objdb) != -1 && objdb.getComplete_flag().equals("N")) {
                            out.print("แก้ไขสำเร็จ");
                        } else {
                            out.print(objex.ReturnAlert());
                        }
                    } else {
                        out.print("edit");
                    }
                    break;
                case 3:
                    objex.UpDel(objdb);

                    out.print("ลบข้อมูลสำเร็จ");

                    break;
                default:
                    out.print("No Statment");
            }
%>