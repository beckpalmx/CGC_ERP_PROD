
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="com.cgc.Util.UtiDatabase"%><script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.*,java.sql.*"%>
<head>
<script type="text/javascript">
 
</script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
<%
	String SQL,SQL2,searchtxt,Encode;
	int start,screen;
	int row_page=15;
	int total=0;
	int count = 0;
	UtiDatabase objut = new UtiDatabase();
	DBConnect db = new DBConnect();
	Connection Conn = db.openNewConnection();
	if(request.getParameter("searchtxt") == null)
	{
		searchtxt = request.getParameter("searchtxt");
	SQL = "Select Count(*) As num From mamphor";
	total = objut.numRowdatabase(SQL);
	}
	else
	{
		Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620");
		SQL = "select Count(*) As num From mamphor where name_t like '"+Encode+"%'";
		searchtxt = Encode;
		total = objut.numRowdatabase(SQL);
		if(total == 0)
		{
			out.print("<a href =' ../JSP/SR_mamphor.jsp '>ไม่พบข้อมูลที่ค้นหา กลับสู่หน้าึค้นหา</a>");
		}
	}
	//total = objut.numRowdatabase(SQL);
	int total_page=(int)Math.ceil((double)total/(double)row_page);
	if(request.getParameter("screen")==null)
	{
		screen=1;
	}
	else
	{
		screen=Integer.parseInt(request.getParameter("screen"));
	}
	if (screen>=1 && screen<=total )
	{
		start=(screen-1)*row_page;
		//row_page=row_page*screen;
		
%>
</head>
<body>
    <form name="serForm" method="get" action="SR_mamphor.jsp">
        <div style="width: 600px;">
            <table width="64%" cellpadding="0"  cellspacing="0">
                <tr >
                    <td width="20" class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน&nbsp;</td>
                    <td width="7" class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="4"  class="blankspace"></td>
                            </tr>

                            <tr>
                                <td colspan="3" align="left"><div align="right">ชื่ออำเภอ :</div></td>
                                <td width="73%" align="left"><input type='text' class="inputs" name="searchtxt" value="" size="40"/>
                                <input type="submit" value="ค้นหา" ></td>
                            </tr>

                            <tr>
                                <td colspan="4" align="center">&nbsp;</td>
                            </tr>

                            <tr>
                                <td colspan="2" class="header2"><div align="left">รหัสอำเภอ</div></td><td colspan="2" class="header2"><div align="left">ชื่ออำเภอ</div></td>
                            </tr>
<%
if(searchtxt == null)
{
String sql2="select * from mamphor order by name_t limit "+row_page+" offset "+start;
ResultSet rs2 = Conn.createStatement().executeQuery(sql2);
while(rs2.next())
{
	count++;
	String getshowdata = rs2.getString("amp_code")+","+ rs2.getString("name_t");
%>
                        <tr>
                            <td colspan="2" align="center"><a  href="#" onClick="gettoShow('<%=getshowdata%>','amp_code,amp_name')"><%=rs2.getString("amp_code")%></a></td>
                            <td colspan="2" align="left"><%= rs2.getString("name_t") %></td>
                        </tr>
<%
}
%>
                    </table>
                        <div align="center">
                          <%
if(screen>1)
{%>
                          <a href="../JSP/SR_mamphor.jsp?screen=<%=screen-1%>">ย้อนกลับ</a>
                          <%
}
if((screen%10)!= 0 && screen <= 10)
{
for(int i=1;i<=10 && i <= total_page;i++)
{

if(i==screen) 
{
%>
	                      <%="["+i+"]"%>
                          <%
}
else 
{
%>
	| <a href="../JSP/SR_mamphor.jsp?screen=<%=i%>" ><%=i%></a>|
    <%
}

}
}
else
{
for(int y=(screen-5);y<=(screen+5)&& y<= total_page ;y++)
{
	if(y==screen) 
	{
	%>
		<%="["+y+"]"%>
	    <%
	}
	else 
	{
	%>
		| <a href="../JSP/SR_mamphor.jsp?screen=<%=y%>" ><%=y%></a>|
	    <%
	}
}
}
if(screen<total_page)
{%>
        <a href="../JSP/SR_mamphor.jsp?screen=<%=screen+1%>">ไปข้างหน้า</a>
        <%
}
else{;

}
rs2.close();
Conn.close();

}
else
{
	String sql2="select * from mamphor  where name_t like '"+searchtxt+"%' limit "+row_page+" offset "+start;
	ResultSet rs2 = Conn.createStatement().executeQuery(sql2);
	while(rs2.next())
	{
		count++;
		String getshowdata = rs2.getString("amp_code")+","+ rs2.getString("name_t");
	%>
                      </div>
                    <tr>
	                            <td colspan="2" align="center"><a  href="#" onClick="gettoShow('<%=getshowdata%>','amp_code,amp_name')"><%=rs2.getString("amp_code")%></a></td>
	                            <td colspan="2" align="left"><%= rs2.getString("name_t") %></td>
	                        </tr>
	<%
	}
	%>
	                    </table>
	                    <%
	if(screen>1)
	{%>
	<a href="../JSP/SR_mamphor.jsp?screen=<%=screen-1%>&searchtxt=<%= searchtxt%>">ย้อนกลับ</a>
	<%
	}
	if((screen%10)!= 0 && screen <= 10)
	{
	for(int i=1;i<=10 && i <= total_page;i++)
	{

	if(i==screen) 
	{
	%>
		<%="["+i+"]"%>
	<%
	}
	else 
	{
	%>
		| <a href="../JSP/SR_mamphor.jsp?screen=<%=i%>&searchtxt=<%= searchtxt%>" ><%=i%></a>|
	<%
	}

	}
	}
	else
	{
	for(int y=(screen-5);y<=(screen+5)&& y<= total_page ;y++)
	{
		if(y==screen) 
		{
		%>
			<%="["+y+"]"%>
		<%
		}
		else 
		{
		%>
			| <a href="../JSP/SR_mamphor.jsp?screen=<%=y%>&searchtxt=<%= searchtxt%>" ><%=y%></a>|
		<%
		}
	}
	}
	if(screen<total_page)
	{%>
	<a href="../JSP/SR_mamphor.jsp?screen=<%=screen+1%>&searchtxt=<%= searchtxt%>">ไปข้างหน้า</a>
	<%
	}
	else{;

	}
	rs2.close();
	Conn.close();
	
}

}
%>
	 </td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3" style="height: 5px">
                    <td width="20" class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2" ></td>
                    <td width="7" class="ffootright"></td>
                </tr>
            </table>
                   
        </div>
    </form>
</body>
