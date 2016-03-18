<%@page import="com.cgc.DB.MDRIVERDAO"%>
<%@page import="com.cgc.bean.DataBeanMDRIVER"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!
	UtiDatabase uti = new UtiDatabase();
	ThaiUtil en = new ThaiUtil();
	Timestamp ts;
	DataBeanMDRIVER objdb = new DataBeanMDRIVER();
	MDRIVERDAO objex = new MDRIVERDAO();

%>
<%
int statusck =0;
int statusnum = 0;
if(request.getParameter("status_d") == null)
{
	statusnum = uti.numRowdatabase("Select Count(*) As num from  mdriver where driver_id like '"+en.EncodeTexttoTIS(request.getParameter("driver_id").trim())+"' and delete_flag <> 'Y'");
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
	objdb.setDriver_id(en.EncodeTexttoTIS(request.getParameter("driver_id")));
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