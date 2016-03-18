<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%><script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<head>
<script type="text/javascript">
 
</script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
</head>
<body>
    <form name="serForm" method="get" action="Serch_Config.jsp">
    <input type="hidden" name="table" value="<%=request.getParameter("table")%>">
    <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
        <div style="width: 600px;">
            <table width="64%" cellpadding="0"  cellspacing="0">
                <tr >
                    <td width="20" class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">ค้นหาข้อมูล&nbsp;</td>
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
                              <td colspan="3" align="right">รหัส  : &nbsp;</td>
                              <td width="74%" align="left"><input type='text' class="inputs" name="searchid" value="" size="40"/></td>
                            </tr>
                            <tr>
                              <td colspan="3" align="right">ชื่อ : &nbsp;</td>
                              <td align="left"><input type='text' class="inputs" name="searchtxt" value="" size="40"/>
                              <input type="submit" class="cgcButton_6" id="submit" value="ค้นหา"></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="left">&nbsp;</td>
                            </tr>


                            <tr>
                                <td colspan="2" class="header2"><div align="left">รหัส</div></td><td colspan="2" class="header2"><div align="left">ชื่อ</div></td>
                            </tr>
<%
	Serchselect ss = new Serchselect();
	int inputpage = Integer.parseInt(request.getParameter("page"));
	String inputtable = request.getParameter("table");
	String[] memcolom;
	String SQL,SQL2,Encode,strid,memtable,memID,memfillname;
	memtable = ss.SelectTable(inputtable);
	memcolom = ss.SelectColoum(inputpage,inputtable);
	memID = ss.SelectID(inputpage,inputtable);

	int start,screen;
	int row_page=15;
	int total=0;
	int count = 0;
	UtiDatabase objut = new UtiDatabase();
	DBConnect db = new DBConnect();
	Connection Conn = db.openNewConnection();
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null)
	{
		SQL = "Select Count(*) As num from  "+memtable+" where delete_flag <> 'Y' ";
		total = objut.numRowdatabase(SQL);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null)
	{
		strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"),"TIS-620");
		Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620");
		SQL = "Select Count(*) As num from  "+memtable+" where delete_flag <> 'Y' and "+memcolom[0]+" like '"+strid+"%' and "+memcolom[1]+" like '"+Encode+"%'";
		total = objut.numRowdatabase(SQL);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null)
	{
		strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"),"TIS-620");
		SQL = "Select Count(*) As num from  "+memtable+" where delete_flag <> 'Y' and "+memcolom[0]+" like '"+strid+"%'";
		total = objut.numRowdatabase(SQL);
	}
	else
	{
		Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620");
		SQL = "Select Count(*) As num from  "+memtable+" where delete_flag <> 'Y' and "+memcolom[1]+" like '"+Encode+"%'";
		total = objut.numRowdatabase(SQL);
	}
	if(total == 0)
	{%>
		<tr>
	                                <td colspan="2" align="left">No Data</td>
	                                <td colspan="2" align="left">ไม่พบสิ่งที่ค้นหา</td>
	                            </tr>
            </table>
	<%}
	int total_page=(int)Math.ceil((double)total/(double)row_page);
	if(request.getParameter("screen")==null )
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
<%!ResultSet rs2; 
String getshowdata;%>
<%
String sql2;
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
	{
		sql2="select * from "+memtable+" where delete_flag <> 'Y' order by 2 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
	{
		sql2="select * from "+memtable+" where delete_flag <> 'Y' and "+memcolom[0]+" like '"+new String(request.getParameter("searchid").getBytes("ISO8859-1"),"TIS-620")+"%' and "+memcolom[1]+" like '"+new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")+"%' order by 2 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
	{
		sql2="select * from "+memtable+" where delete_flag <> 'Y' and "+memcolom[0]+" like '"+new String(request.getParameter("searchid").getBytes("ISO8859-1"),"TIS-620")+"%' order by 2 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);	
	}
	else
	{
		sql2="select * from "+memtable+" where delete_flag <> 'Y' and "+memcolom[1]+" like '"+new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")+"%' order by 2 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);
	}
	while(rs2.next())
	{
		if(!request.getParameter("page").equals("4"))
		{
		count++;
		getshowdata = "";
		for(int i=0;i<memcolom.length;i++)
		{
			if(i!=(memcolom.length-1))
			{
				getshowdata += rs2.getString(memcolom[i])+"|";
			}
			else
			{
				getshowdata += rs2.getString(memcolom[i]);
			}
		}
%>
                            <tr>
                                <td colspan="2" align="left"><a  href="#" onClick="gettoShow('<%=getshowdata%>','<%=memID%>')"><%=rs2.getString(memcolom[0])%></a></td>
                                <td colspan="2" align="left"><%= rs2.getString(memcolom[1]) %></td>
                            </tr>
<%
		}
		else 
		{
			count++;
			getshowdata = "";
			for(int i=0;i<memcolom.length;i++)
			{
				if(i<=2)
				{
					getshowdata += rs2.getString(memcolom[i])+",";
				}
				else
				{
					getshowdata += rs2.getString(memcolom[i]);
				}
			}
	%>
	                            <tr>
	                                <td colspan="2" align="left"><a  href="#" onClick="gettoShowpage4('<%=getshowdata%>','priviledge_id,name_t,remark,<%=rs2.getString("main_menu_id")%><%=rs2.getString("sub_menu_id")%>')"><%=rs2.getString(memcolom[0])%></a></td>
	                                <td colspan="2" align="left"><%= rs2.getString(memcolom[1]) %></td>
	                            </tr>
	<%
		}
		
}
	
%>
                        </table>
                        <div align="center">
<%
if(screen>1)
{
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
	{%>
	                      <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen-1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%></a>">ย้อนกลับ</a>
	                      <%
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
	{%>
	                      <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen-1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>">ย้อนกลับ</a>
	                      <%	
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
	{%>
	                      <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen-1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>">ย้อนกลับ</a>
	                      <%	
	}
	else
	{%>
	                      <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen-1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>">ย้อนกลับ</a>
	                      <%	
	}
}
if((screen%10)!= 0 && screen <= 10)
{
for(int i=1;i<=10 && i <= total_page ;i++)
{
	
	if(i==screen) 
	{
	%>
		                  <%="["+i+"]"%>
	                      <%
	}
	else 
	{
		if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
		{%>
		| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>"><%=i%></a> |
		<%
		}
		else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
		{%>
		| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>"><%=i%></a> |
		<%	
		}
		else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
		{%>
		| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>"><%=i%></a> |
		<%	
		}
		else
		{%>
		| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>"><%=i%></a> |
		<%	
		}
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
			if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
			{%>
			| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>"><%=y%></a> |
			<%
			}
			else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
			{%>
			| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>"><%=y%></a> |
			<%	
			}
			else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
			{%>
			| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>"><%=y%></a> |
			<%	
			}
			else
			{%>
			| <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>"><%=y%></a> |
			<%	
			}
		}
	}
}
if(screen<total_page)
{
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
	{%>
	        <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen+1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>">ไปข้างหน้า</a>
	        <%
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
	{%>
	        <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen+1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>">ไปข้างหน้า</a>
	        <%	
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
	{%>
	        <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen+1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>">ไปข้างหน้า</a>
	        <%	
	}
	else
	{%>
	        <a href="../SEARCHSCREEN/Serch_Config.jsp?screen=<%=screen+1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")%>">ไปข้างหน้า</a>
	        <%	
	}
}
else{;

}
rs2.close();
Conn.close();
}
%>
                        </div></td>
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
