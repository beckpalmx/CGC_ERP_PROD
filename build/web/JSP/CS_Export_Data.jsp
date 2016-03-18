<%@page import="com.cgc.DB.Mdata_exportDAO"%>
<%@page import="com.cgc.bean.DataBean_MData_export"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!
	UtiDatabase uti = new UtiDatabase();
	ThaiUtil en = new ThaiUtil();
	Timestamp ts;
	DataBean_MData_export objdb = new DataBean_MData_export();
	Mdata_exportDAO objex = new Mdata_exportDAO();

%>
<%
int statusck =0;
int statusnum = 0;
if(request.getParameter("status_d") == null)
{
	statusnum = uti.numRowdatabase("Select Count(export_id) As num from  mdata_export where export_id = '"+en.EncodeTexttoTIS(request.getParameter("export_id").trim())+"' and status = 'Y'");
	if(statusnum == 0)
	{
		statusck = 1;
	}
	else if(statusnum == 1)
	{
		statusck = 2;
	}
	else
	{
		statusck = -1;
	}
}
else
{
	statusck = Integer.parseInt(request.getParameter("status_d"));
}
	objdb.setExport_id(en.EncodeTexttoTIS(request.getParameter("export_id")));
        objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
        objdb.setLookup_name(request.getParameter("lookup_name"));
        objdb.setParam_name(en.EncodeTexttoTIS(request.getParameter("param_name")));
        objdb.setParam_value(request.getParameter("param_value"));
        objdb.setParam_from(request.getParameter("param_from"));
        objdb.setParam_value_from(request.getParameter("param_value_from"));
        objdb.setOrder_by(request.getParameter("order_by"));
        objdb.setComplete_flag(request.getParameter("complete_flag"));
        objdb.setRetro_flag(request.getParameter("retro_flag"));
        objdb.setCancel_flag(request.getParameter("cancel_flag"));
	if(request.getParameter("remark") != null)
		objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
	ts = new Timestamp( new java.util.Date().getTime());
	objdb.setDate(ts);
        objdb.setBy(request.getParameter("username"));

	switch(statusck)
	{
	case 1:
			if(objex.insert(objdb) != -1)
			{
				out.print("บันทึกสำเร็จ");
			}
			break;
	case 2:
			if(objex.update(objdb) != -1)
			{
				out.print("แก้ไขสำเร็จ");
			}
			break;
	case 3:
		if(objex.updateDel(objdb) != -1)
		{
			out.print("ลบข้อมูลสำเร็จ");
		}
		break;
	default:
		out.print("No Statment");
	}
%>