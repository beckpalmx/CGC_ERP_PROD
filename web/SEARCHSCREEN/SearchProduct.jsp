
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%><script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<head>
    <script type="text/javascript">
 
    </script>
    <script language="javascript" src="../JS/myAjaxFramework.js"></script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    <%
                String SQL, SQL2, Encode, strid;
                int start, screen;
                int row_page = 12;
                int total = 0;
                int count = 0;
                UtiDatabase objut = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {
                    SQL = "Select Count(*) As num from  mproduct where delete_flag <> 'Y' ";
                    total = objut.numRowdatabase(SQL);
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                    strid = request.getParameter("searchid");
                    Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                    SQL = "Select Count(*) As num from  mproduct where delete_flag <> 'Y' and product_id like '" + strid + "%' and name_t like '" + Encode + "%'";
                    total = objut.numRowdatabase(SQL);
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                    strid = request.getParameter("searchid");
                    SQL = "Select Count(*) As num from  mproduct where delete_flag <> 'Y' and product_id like '" + strid + "%'";
                    total = objut.numRowdatabase(SQL);
                    out.print(total);
                } else {
                    Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                    SQL = "Select Count(*) As num from  mproduct where delete_flag <> 'Y' and name_t like '" + Encode + "%'";
                    total = objut.numRowdatabase(SQL);
                    out.print(total);
                }
                if (total == 0) {
                    out.print("<a href ='SearchProduct.jsp'>ไม่พบข้อมูลที่ค้นหา กลับสู่หน้าค้นหา</a>");
                }
                int total_page = (int) Math.ceil((double) total / (double) row_page);
                if (request.getParameter("screen") == null) {
                    screen = 1;
                } else {
                    screen = Integer.parseInt(request.getParameter("screen"));
                }
                if (screen >= 1 && screen <= total) {
                    start = (screen - 1) * row_page;
                    //row_page=row_page*screen;


    %>
</head>
<body>
    <form name="serForm" method="get" action="SearchProduct.jsp">
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
                                <td colspan="3"  class="blankspace"></td>
                            </tr>
                            <td height="22" align="right" valign="middle">ชื่อ :&nbsp;</td>
                            <td colspan="2" align="left"><input type='text' class="inputs" name="searchtxt" value="" size="40"/>
                                <a href="javascript:;" ><img src="../IMAGES/BUTTON/MAIN/SEARCH20.png" width="17" height="17" border="0" onClick="document.serForm.submit()"></a>
                            </td>
                </tr>
                <tr>
                    <td width="6%" align="right" valign="middle">ID :&nbsp;</td>
                    <td colspan="2" align="left"><label>
                            <input type='text' class="inputs" name="searchid" value="" size="40"/>
                        </label></td>
                <tr>
                    <td colspan="3" align="center">&nbsp;</td>
                </tr>

                <tr>
                    <td colspan="2" class="header2"><div align="left">รหัสสินค้า</div></td><td width="30%" class="header2"><div align="left">ชื่อสินค้า</div></td>
                </tr>
                <%!ResultSet rs2;%>
                <%
                            String sql2;
                            if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {
                                sql2 = "select * from vproduct where delete_flag <> 'Y' order by 1 limit " + row_page + " offset " + start;
                                rs2 = Conn.createStatement().executeQuery(sql2);
                            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                                sql2 = "select * from vproduct where delete_flag <> 'Y' and product_id like '" + request.getParameter("searchid") + "%' and name_t like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' order by 1 limit " + row_page + " offset " + start;
                                rs2 = Conn.createStatement().executeQuery(sql2);
                            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                                sql2 = "select * from vproduct where delete_flag <> 'Y' and product_id like '" + request.getParameter("searchid") + "%' order by 1 limit " + row_page + " offset " + start;
                                rs2 = Conn.createStatement().executeQuery(sql2);
                            } else {
                                sql2 = "select * from vproduct where delete_flag <> 'Y' and name_t like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' order by 1 limit " + row_page + " offset " + start;
                                rs2 = Conn.createStatement().executeQuery(sql2);
                            }
                            while (rs2.next()) {
                                count++;
                                String getshowdata;
                                getshowdata = rs2.getString("product_id") + "," + rs2.getString("name_t")+","+rs2.getString("pgroup_id")+","+rs2.getString("pgroup_name")+","+rs2.getString("pcat_id")+","+rs2.getString("pcat_name")+","+rs2.getString("ptype_id")+","+rs2.getString("ptype_name")+","+rs2.getString("price")+","+rs2.getString("min")+","+rs2.getString("max")+","+rs2.getString("safety")+","+rs2.getString("warehouse_id")+","+rs2.getString("wh_name")+","+rs2.getString("location_id")+","+rs2.getString("value")+","+rs2.getString("remark");
                %>
                <tr>
                    <td colspan="2" align="left"><a  href="#" onClick="gettoShow('<%=getshowdata%>','product_id,name_t_product,pgroup_id,name_t_pgroup,pcat_id,name_t_pcat,ptype_id,name_t_ptype,price,min,max,safety,warehouse_id,name_t_warehouse,location_id,value,remark_product')" class="link_transparent"><%=rs2.getString("product_id")%></a></td>
                    <td><%= rs2.getString("name_t")%></td>
                </tr>
                <%
                            }
                %>
            </table>
                        <br>
                        <%
                        if (screen > 1) {
                            if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen - 1%>" class="link_transparent">ปิดหน้าต่าง</a>
            <%
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen - 1%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ปิดหน้าต่าง</a>
            <%
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen - 1%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent">ปิดหน้าต่าง</a>
            <%
                } else {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen - 1%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ปิดหน้าต่าง</a>
            <%
                            }
                        }
                        if ((screen % 10) != 0 && screen <= 10) {
                            for (int i = 1; i <= 10 && i <= total_page; i++) {

                                if (i == screen) {
            %>
            <%="<b><font color='blue'>[" + i + "]</font></b>"%>
            <%
                    } else {
                        if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
		| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=i%>" class="link_transparent"><%=i%></a> |
            <%
                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
		| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=i%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=i%></a> |
            <%
                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
		| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=i%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent"><%=i%></a> |
            <%
                                } else {%>
		| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=i%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=i%></a> |
            <%
                        }
                    }

                }
            } else {
                for (int y = (screen - 5); y <= (screen + 5) && y <= total_page; y++) {
                    if (y == screen) {
            %>
            <%="<b><font color='blue'>[" + y + "]</font></b>"%>
            <%
                            } else {
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
			| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=y%>" class="link_transparent"><%=y%></a> |
            <%
                                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
			| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=y%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=y%></a> |
            <%
                                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
			| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=y%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent"><%=y%></a> |
            <%
                                                } else {%>
			| <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=y%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=y%></a> |
            <%
                                    }
                                }
                            }
                        }
                        if (screen < total_page) {
                            if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen + 1%>" class="link_transparent">ไปข้างหน้า</a>
            <%
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen + 1%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ไปข้างหน้า</a>
            <%
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen + 1%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent">ไปข้างหน้า</a>
            <%
                } else {%>
            <a href="../SEARCHSCREEN/SearchProduct.jsp?screen=<%=screen + 1%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ไปข้างหน้า</a>
            <%
                                }
                            } else {
                                ;

                            }
                            rs2.close();
                            Conn.close();
                        }
            %>
            </tr>
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
