<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import ="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.sql.*"%>

<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
    <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">

    <script src="../JS/jquery/jquery-2.1.4.js"></script>
    <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                           

    <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/>     

    <script src="../JS/alertify/alertify.js"></script>        

    <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />

    <!-- alertify theme Section -->
    <!--link rel="stylesheet" href="../CSS/alertify/alertify.bootstrap.css"-->
    <link rel="stylesheet" href="../CSS/alertify/alertify.default.css">

    <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />     

</head>

<body>
    <form name="serForm" method="get" action="Search_Config.jsp">
        <input type="hidden" name="table" value="<%=request.getParameter("table")%>">
        <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>ค้นหาข้อมูล</b></div>
                <div class="panel-footer">            
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
                            String SQL, SQL2, Encode, strid, memtable, memID, memfillname;
                            memtable = ss.SelectTable(inputtable);
                            memcolom = ss.SelectColoum(inputpage, inputtable);
                            memID = ss.SelectID(inputpage, inputtable);

                            int start, screen;
                            int row_page = 12;
                            int total = 0;
                            int count = 0;
                            UtiDatabase objut = new UtiDatabase();
                            DBConnect db = new DBConnect();
                            Connection Conn = db.openNewConnection();
                            if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {
                                SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' ";
                                total = objut.numRowdatabase(SQL);
                            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                                strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                                SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + strid + "%' and " + memcolom[1] + " like '" + Encode + "%'";
                                total = objut.numRowdatabase(SQL);
                            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                                strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + strid + "%'";
                                total = objut.numRowdatabase(SQL);
                            } else {
                                Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                                SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + memcolom[1] + " like '" + Encode + "%'";
                                total = objut.numRowdatabase(SQL);
                            }
                            if (total == 0) {%>
                        <tr>
                            <td colspan="2" align="left">No Data</td>
                            <td colspan="2" align="left">ไม่พบสิ่งที่ค้นหา</td>
                        </tr>
                    </table>
                    <%}
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
                    <%!ResultSet rs2;
                        String getshowdata;%>
                    <%    String sql2;
                        if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {
                            sql2 = "select * from " + memtable + " where delete_flag <> 'Y' order by 2 limit " + row_page + " offset " + start;
                            rs2 = Conn.createStatement().executeQuery(sql2);
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                            sql2 = "select * from " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' and " + memcolom[1] + " like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' order by 2 limit " + row_page + " offset " + start;
                            rs2 = Conn.createStatement().executeQuery(sql2);
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                            sql2 = "select * from " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' order by 2 limit " + row_page + " offset " + start;
                            rs2 = Conn.createStatement().executeQuery(sql2);
                        } else {
                            sql2 = "select * from " + memtable + " where delete_flag <> 'Y' and " + memcolom[1] + " like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' order by 2 limit " + row_page + " offset " + start;
                            rs2 = Conn.createStatement().executeQuery(sql2);
                        }
                        while (rs2.next()) {
                            if (!request.getParameter("page").equals("4")) {
                                count++;
                                getshowdata = "";
                                for (int i = 0; i < memcolom.length; i++) {
                                    if (i != (memcolom.length - 1)) {
                                        if (memcolom[i].equals("password")) {
                                            byte[] pass_decode = Base64.decodeBase64(rs2.getString(memcolom[i]));
                                            getshowdata += new String(pass_decode) + "|";
                                            //System.out.println("Loop 1.1 = " + memcolom[i] + " = " + rs2.getString(memcolom[i]) + " : " + new String(pass_decode));
                                        } else {
                                            getshowdata += rs2.getString(memcolom[i]) + "|";
                                            //System.out.println("Loop 1.2 = " + memcolom[i] + " : " + rs2.getString(memcolom[i]) );
                                        }

                                        //  getshowdata += rs2.getString(memcolom[i]) + "|";
                                    } else {
                                        getshowdata += rs2.getString(memcolom[i]);
                                        //System.out.println("Loop 2 = " + memcolom[i] + " " + rs2.getString(memcolom[i]) );
                                    }
                                }
                    %>
                    <tr>
                        <td colspan="2" align="left"><a  href="#" onClick="gettoShow('<%=getshowdata%>', '<%=memID%>')" class="link_transparent"><%=rs2.getString(memcolom[0])%></a></td>
                        <td colspan="2" align="left"><%= rs2.getString(memcolom[1])%></td>
                    </tr>
                    <%
                    } else {
                        count++;
                        getshowdata = "";
                        for (int i = 0; i < memcolom.length; i++) {
                            if (i <= 2) {
                                getshowdata += rs2.getString(memcolom[i]) + ",";
                            } else {
                                getshowdata += rs2.getString(memcolom[i]);
                            }
                        }
                    %>
                    <tr>
                        <td colspan="2" align="left"><a  href="#" onClick="gettoShowpage4('<%=getshowdata%>', 'priviledge_id,name_t,remark,<%=rs2.getString("main_menu_id")%><%=rs2.getString("sub_menu_id")%>')" class="link_transparent"><%=rs2.getString(memcolom[0])%></a></td>
                        <td colspan="2" align="left"><%= rs2.getString(memcolom[1])%></td>
                    </tr>
                    <%
                            }

                        }

                    %>
                    </table>
                    <div align="center">
                        <%    if (screen > 1) {
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%></a>" class="link_transparent">ย้อนกลับ</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ย้อนกลับ</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent">ย้อนกลับ</a>
                        <%
                        } else {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ย้อนกลับ</a>
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
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>" class="link_transparent"><%=i%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=i%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent"><%=i%></a> |
                        <%
                        } else {%>
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=i%></a> |
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
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>" class="link_transparent"><%=y%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"<%=y%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent"><%=y%></a> |
                        <%
                        } else {%>
                        | <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent"><%=y%></a> |
                        <%
                                        }
                                    }
                                }
                            }
                            if (screen < total_page) {
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                        } else {%>
                        <a href="../SEARCHSCREEN/Search_Config.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                                    }
                                } else {;

                                }
                                rs2.close();
                                Conn.close();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
