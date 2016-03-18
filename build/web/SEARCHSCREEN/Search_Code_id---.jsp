<%@page import="com.cgc.Util.SelectSearch_Doc_id" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<head>
    <script type="text/javascript"></script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <meta http-equiv="pragma" content="no-cache" />
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
<%!    String stadment;
%>
<%
//JOptionPane.showConfirmDialog(null, stadment);
    if (request.getParameter("stadment") != null) {
        stadment = new String(request.getParameter("stadment").getBytes("ISO8859-1"), "TIS-620");
    } else {
        stadment = "";
    }
%>
<body>
    <form name="serForm" method="get" action="Search_Code_id.jsp">
        <input type="hidden" name="table" value="<%=request.getParameter("table")%>">
        <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
        <input type="hidden" name="coloum" value="<%=request.getParameter("coloum")%>">
        <input type="hidden" name="stadment" value="<%=stadment%>">
        <%
            SelectSearch_Code_id ss = new SelectSearch_Code_id();
            int inputpage = Integer.parseInt(request.getParameter("page"));
            String inputtable = request.getParameter("table");
            String[] memcolom, memcoloumShow, memcoloumFill;
            String SQL, SQL2, Encode, strid, memURLShowdeatil, memID, memfillname;

        %>
        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>ค้นหาข้อมูล</b></div>
                <div class="panel-footer">
                    <div style="width: 500px;" align="center">
                        <table width="550" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td width="46">รหัส  : &nbsp;</td>
                                <td width="199"><input type='text' class="inputs" name="searchid" id="searchid" value="" size="40"/></td>
                            </tr>
                            <tr>
                                <td>ชื่อ : &nbsp;</td>
                                <td><input type='text' class="inputs" name="searchtxt" id="searchtxt" value="" size="40"/></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td><input type="button" class="cgcButton_5" name="bt1" value=" ย้อนกลับ " onClick="javascript:window.close();"/></td>                                 
                                <td><input type="submit" class="cgcButton_6" id="submit" value="ค้นหา"></td>
                            </tr>                                

                        </table>
                    </div>
                    <div style="width: 500px; height: 320px; overflow: auto;" align="center">
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <%                                        memcoloumFill = ss.SelectFillName(inputpage, inputtable);

                                    for (int i = 0; i < memcoloumFill.length; i++) {%>
                                <td class="header2"><div align="left"><%= memcoloumFill[i]%></div></td>
                                    <%
                                        }
                                    %>
                            </tr>
                            <%
                                //memtable = ss.SelectTable(inputtable);
                                memcolom = ss.SelectColoum(inputpage, inputtable);
                                memID = ss.SelectID(inputpage, inputtable);
                                memcoloumShow = ss.SelectColoumShow(inputpage, inputtable);
                                memURLShowdeatil = ss.SelectURLShowDetail(inputpage, inputtable);

                                System.out.println("memcoloumShow" + memcoloumShow);
                                System.out.println("memURLShowdeatil" + memURLShowdeatil);

                                int start, screen;
                                int row_page = 12;
                                int total = 0;
                                int count = 0;
                                UtiDatabase objut = new UtiDatabase();
                                DBConnect db = new DBConnect();
                                Connection Conn = db.openNewConnection();
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {
                                    SQL = "Select Count(*) As num from  " + inputtable + " where delete_flag <> 'Y' " + stadment;
                                    total = objut.numRowdatabase(SQL);
                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                                    strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                    Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + inputtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + strid + "%' and " + memcolom[1] + " like '" + Encode + "%' " + stadment;
                                    total = objut.numRowdatabase(SQL);
                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                                    strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + inputtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + strid + "%' " + stadment;
                                    total = objut.numRowdatabase(SQL);
                                } else {
                                    Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + inputtable + " where delete_flag <> 'Y' and " + memcolom[1] + " like '" + Encode + "%' " + stadment;
                                    total = objut.numRowdatabase(SQL);
                                }
                                if (total == 0) {%>
                            <tr>
                                <td  align="left"></td>
                                <td  align="left">ไม่พบสิ่งที่ค้นหา</td>
                            </tr></table>
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
                            <%                                    rs2 = null;
                                try {
                                    String sql2;
                                    if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {

                                        sql2 = "select * from " + inputtable + " where delete_flag <> 'Y' " + stadment + "  order by runno desc limit " + row_page + " offset " + start;
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                        //System.out.println("sql2 1 = " + sql2);
                                    } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                                        sql2 = "select * from " + inputtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' and " + memcolom[1] + " like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by runno desc limit " + row_page + " offset " + start;
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                        //System.out.println("sql2 2 = " + sql2);
                                    } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                                        sql2 = "select * from " + inputtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by runno desc limit " + row_page + " offset " + start;
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                        //System.out.println("sql2 3 = " + sql2);
                                    } else {
                                        sql2 = "select * from " + inputtable + " where delete_flag <> 'Y' and " + memcolom[1] + " like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by runno desc limit " + row_page + " offset " + start;
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                        //System.out.println("sql2 4 = " + sql2);
                                    }
                                    while (rs2.next()) {

                                        count++;
                                        getshowdata = "";
                                        for (int i = 0; i < memcolom.length; i++) {

                                            if (i != (memcolom.length - 1)) {

                                                getshowdata += rs2.getString(memcolom[i]) + "|";
                                            } else {

                                                getshowdata += rs2.getString(memcolom[i]);

                                            }

                                            //JOptionPane.showConfirmDialog(null, getshowdata);
                                        }
                            %>
                        <tr>
                            <%
                                //System.out.println("PAGE = " + request.getParameter("page"));
                                if (request.getParameter("page").equals("25")
                                        || request.getParameter("page").equals("36")
                                        || request.getParameter("page").equals("40")
                                        || request.getParameter("page").equals("41")
                                        || request.getParameter("page").equals("32") || request.getParameter("page").equals("306")
                                        || request.getParameter("page").equals("322") || request.getParameter("page").equals("28")
                                        || request.getParameter("page").equals("115") || request.getParameter("page").equals("117")) {
                                    for (int y = 0; y < memcoloumShow.length; y++) {
                                        if (y == 0) {

                                       //System.out.println("gettoShow_Code_id2 1 ");
%>
                            <td  class="detailLeft"><a  href="#" class="link_transparent" onClick="gettoShow_Code_id2('<%=objut.DecodeNewLine(getshowdata)%>', '<%=memID%>', '<%=memURLShowdeatil%>', 'show', 'show2', '<%=rs2.getString(memcolom[0])%>')"><%=rs2.getString(memcoloumShow[y])%></a></td>
                                <%
                                } else {
                                       //System.out.println("gettoShow_Code_id2 2 ");                                                        

                                %>

                            <td  class="detailLeft"><%= rs2.getString(memcoloumShow[y])%></td>
                            <%
                                        //System.out.println("Show : " + rs2.getString(memcoloumShow[y]));
                                    }
                                }
                            } else {
                                for (int y = 0; y < memcoloumShow.length; y++) {
                                    if (y == 0) {

                                       // System.out.println("gettoShow_Code_id2 3 ");        
%>
                            <td  class="detailLeft"><a  href="#" class="link_transparent" onClick="gettoShow_Code_id('<%=objut.DecodeNewLine(getshowdata)%>', '<%=memID%>', '<%=memURLShowdeatil%>', 'show', '<%=rs2.getString(memcolom[0])%>')"><%=rs2.getString(memcoloumShow[y])%></a></td>
                                <%
                                } else {
                                     //   System.out.println("gettoShow_Code_id2 4 ");        

                                %>

                            <td  class="detailLeft"><%= rs2.getString(memcoloumShow[y])%></td>
                            <%
                                        }
                                    }

                                }

                            %>
                        </tr>
                        <%	}

                        %>
                        </table>
                    </div >
                    <div align="center">
                        <%                if (screen > 1) {
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent" >ย้อนกลับ</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" >ย้อนกลับ</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent" >ย้อนกลับ</a>
                        <%
                        } else {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" >ย้อนกลับ</a>
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
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent" ><%=i%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" ><%=i%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent" ><%=i%></a> |
                        <%
                        } else {%>
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" ><%=i%></a> |
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
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent" ><%=y%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" ><%=y%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>"><%=y%></a> |
                        <%
                        } else {%>
                        | <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" ><%=y%></a> |
                        <%
                                        }
                                    }
                                }
                            }
                            if (screen < total_page) {
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent" >ไปข้างหน้า</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" >ไปข้างหน้า</a>
                        <%
                        } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent" >ไปข้างหน้า</a>
                        <%
                        } else {%>
                        <a href="../SEARCHSCREEN/Search_Code_id.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent" >ไปข้างหน้า</a>
                        <%
                                        }
                                    } else {
                                        ;

                                    }
                                } catch (Exception e) {
                                    e.printStackTrace(System.out);
                                } finally {
                                    if (rs2 != null) //JOptionPane.showConfirmDialog(null, "close rs");
                                    {
                                        rs2.close();
                                    }
                                    if (Conn != null) //JOptionPane.showConfirmDialog(null, "close con");
                                    {
                                        Conn.close();
                                    }
                                }

                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
