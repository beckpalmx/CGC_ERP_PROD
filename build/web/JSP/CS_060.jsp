<%@page import="com.cgc.bean.DataBeanDHeaderAnalyze"%>
<%@page import="com.cgc.DB.D_Header_AnalyzeDAO"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>

<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%!    D_Header_AnalyzeDAO ppDAO = new D_Header_AnalyzeDAO();
    DataBeanDHeaderAnalyze ppBean, selectPpBean;
    Timestamp ts;
    ThaiUtil en = new ThaiUtil();
    String doc_id, job_id, iod, status_copy;
%>
<%
    ppBean = new DataBeanDHeaderAnalyze();

    doc_id = request.getParameter("doc_id");
    job_id = request.getParameter("doc_id");
    iod = request.getParameter("iod");
    status_copy = request.getParameter("status_copy");

    ppBean.setDoc_id(request.getParameter("doc_id") == null ? "" : en.EncodeTexttoTIS(request.getParameter("doc_id")));
    ppBean.setJob_id(request.getParameter("doc_id") == null ? "" : en.EncodeTexttoTIS(request.getParameter("doc_id")));
    ppBean.setH2o(request.getParameter("h2o") == null ? "" : en.EncodeTexttoTIS(request.getParameter("h2o")));
    ppBean.setButane(request.getParameter("butane") == null ? "" : en.EncodeTexttoTIS(request.getParameter("butane")));
    ppBean.setIod(request.getParameter("iod") == null ? "" : en.EncodeTexttoTIS(request.getParameter("iod")));
    ppBean.setPsd_1(request.getParameter("psd_1") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_1")));
    ppBean.setPsd_2(request.getParameter("psd_2") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_2")));
    ppBean.setPsd_3(request.getParameter("psd_3") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_3")));
    ppBean.setPsd_4(request.getParameter("psd_4") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_4")));
    ppBean.setPsd_5(request.getParameter("psd_5") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_5")));
    ppBean.setPsd_6(request.getParameter("psd_6") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_6")));
    ppBean.setPsd_7(request.getParameter("psd_7") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_7")));
    ppBean.setPsd_8(request.getParameter("psd_8") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_8")));
    ppBean.setPsd_9(request.getParameter("psd_9") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_9")));
    ppBean.setPsd_10(request.getParameter("psd_10") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_10")));
    ppBean.setPsd_11(request.getParameter("psd_11") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_11")));
    ppBean.setPsd_12(request.getParameter("psd_12") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_12")));
    ppBean.setPsd_13(request.getParameter("psd_13") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_13")));
    ppBean.setPsd_14(request.getParameter("psd_14") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_14")));
    ppBean.setPsd_15(request.getParameter("psd_15") == null ? "" : en.EncodeTexttoTIS(request.getParameter("psd_15")));
    ppBean.setPass(request.getParameter("pass") == null ? "" : en.EncodeTexttoTIS(request.getParameter("pass")));
    ppBean.setN_pass(request.getParameter("n_pass") == null ? "" : en.EncodeTexttoTIS(request.getParameter("n_pass")));
    ppBean.setGrade(request.getParameter("grade") == null ? "" : en.EncodeTexttoTIS(request.getParameter("grade")));
    ppBean.setRemark(request.getParameter("remark") == null ? "" : en.EncodeTexttoTIS(request.getParameter("remark")));
    ts = new Timestamp(new java.util.Date().getTime());
    ppBean.setCreate_date(ts);
    ppBean.setUpdate_date(ts);
    ppBean.setCreate_by(en.EncodeTexttoTIS(request.getParameter("username")));
    ppBean.setUpdate_by(en.EncodeTexttoTIS(request.getParameter("username")));

    System.out.println("psd_1 = " + request.getParameter("psd_1"));
    System.out.println("chkstatus = " + request.getParameter("chkstatus"));

    if (request.getParameter("status_copy") == null) {

        if (request.getParameter("chkstatus") == null) {
            System.out.println("BSEL doc_id = " + doc_id);
            System.out.println("BSEL job_id = " + job_id);
            selectPpBean = ppDAO.selectData(doc_id);
            System.out.println("selectPpBean = " + selectPpBean);

            if (selectPpBean != null && selectPpBean.getDelete_flag().equals("N")) {
                ppBean.setUpdate_date(ts);
                if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                    ppDAO.update(ppBean);
                    out.print("แก้ไขสำเร็จ");
                } else {
                    out.print("edit");
                }
            } else {
                if (ppDAO.insert(ppBean)) {
                    out.print("บันทึกสำเร็จ");
                } else {
                    out.print("บันทึกไม่สำเร็จ");
                }
            }
        } else { //check for chkstatus condition 
            ppDAO.updateDel(ppBean);
            out.print("ลบข้อมูลสำเร็จ");
        }
    } else {   //check for status_copy condition
        ppBean.setDoc_id(request.getParameter("doc_id_copy_to") == null ? "" : en.EncodeTexttoTIS(request.getParameter("doc_id_copy_to")));
        ppBean.setJob_id(request.getParameter("doc_id_copy_to") == null ? "" : en.EncodeTexttoTIS(request.getParameter("doc_id_copy_to")));
        if (ppDAO.copy(ppBean)) {
            out.print("คัดลอกสำเร็จ");
        } else {
            out.print("คัดลอกไม่สำเร็จ");
        }
    }
%>