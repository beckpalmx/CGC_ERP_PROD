<%@page import="com.cgc.DB.MPROCESS_GRPDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS_GRP"%>
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
	DataBeanMPROCESS_GRP objdb = new DataBeanMPROCESS_GRP();
	MPROCESS_GRPDAO objex = new MPROCESS_GRPDAO();

%>
<%
int statusck =0;
int statusnum = 0;
if(request.getParameter("status_d") == null)
{
	statusnum = uti.numRowdatabase("Select Count(*) As num from  mprocess_group where procgrp_id like '"+en.EncodeTexttoTIS(request.getParameter("procgrp_id").trim())+"' and delete_flag <> 'Y'");
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
	objdb.setProcgrp_id(en.EncodeTexttoTIS(request.getParameter("procgrp_id")));
	objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
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