<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!
	UtiDatabase uti = new UtiDatabase();
	ThaiUtil en = new ThaiUtil();
	Timestamp ts;
	DataBeanMPROCESS objdb = new DataBeanMPROCESS();
	MPROCESSDAO objex = new MPROCESSDAO();

%>
<%
int statusck =0;
int statusnum = 0;
if(request.getParameter("status_d") == null)
{
	statusnum = uti.numRowdatabase("Select Count(*) As num from  mprocess where process_id like '"+en.EncodeTexttoTIS(request.getParameter("process_id").trim())+"' and delete_flag <> 'Y'");
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
	objdb.setProcess_id(en.EncodeTexttoTIS(request.getParameter("process_id")));
	objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
	objdb.setProcgrp_id(en.EncodeTexttoTIS(request.getParameter("procgrp_id")));
	objdb.setWareHouse_id(en.EncodeTexttoTIS(request.getParameter("warehouse_id")));
	objdb.setWh_bg(en.EncodeTexttoTIS(request.getParameter("wh_bg")));
	objdb.setWh_en(en.EncodeTexttoTIS(request.getParameter("wh_en")));
	if(request.getParameter("remark") != null)
		objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
	ts = new Timestamp( new java.util.Date().getTime());
	objdb.setDate(ts);

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
		if(objex.UpDel(objdb) != -1)
		{
			out.print("ลบข้อมูลสำเร็จ");
		}
		break;
	default:
		out.print("No Statment");
	}
%>