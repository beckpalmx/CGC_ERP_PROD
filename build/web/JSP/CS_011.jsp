
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.MSTD_COST_MAINDAO"%>
<%@page import="com.cgc.bean.DataBeanMSTD_COST_MAIN"%><%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!
	UtiDatabase uti = new UtiDatabase();
	ThaiUtil en = new ThaiUtil();
	Timestamp ts;
	DataBeanMSTD_COST_MAIN objdb = new DataBeanMSTD_COST_MAIN();
	MSTD_COST_MAINDAO objex = new MSTD_COST_MAINDAO();

%>
<%
int statusck =0;
int statusnum = 0;
if(request.getParameter("status_d") == null)
{
	statusnum = uti.numRowdatabase("Select Count(*) As num from  mstd_cost_main where std_id like '"+en.EncodeTexttoTIS(request.getParameter("std_id").trim())+"' and delete_flag <> 'Y'");
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
        if(request.getParameter("std_id") != null)
            objdb.setStd_id(en.EncodeTexttoTIS(request.getParameter("std_id")));
        if(request.getParameter("name_t") != null)
            objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
        if(request.getParameter("process_id") != null)
            objdb.setProcess_id(en.EncodeTexttoTIS(request.getParameter("process_id")));
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