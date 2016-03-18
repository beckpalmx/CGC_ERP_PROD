<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<head>
    <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
    <script type="text/javascript">
        function EncodeBefor_Search() {

            str = getId("searchid").value;
            for (var i = 0; i < str.length; i++) {
                getId("searchid").value = (getId("searchid").value.indexOf(" ") !== -1) ? getId("searchid").value.replace(" ", "_") : getId("searchid").value;
            }

            getId("serForm").submit();
        }
        function Click_Select_Search(objthis) {
            getId("select_search_value_txt").value = objthis.value;
        }
    </script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <meta Http-Equiv="Cache-Control" Content="no-cache">
    <meta Http-Equiv="Pragma" Content="no-cache">
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
<%!    String stadment, select_search_value;
    UtiDatabase objselect;
%>
<%
//JOptionPane.showConfirmDialog(null, request);
    if (request.getParameter("stadment") != null) {
        stadment = new String(request.getParameter("stadment").getBytes("ISO8859-1"), "TIS-620");
    } else {
        stadment = "";
    }
    select_search_value = "";
    objselect = new UtiDatabase();
%>
<body>
    <%
        Serchselect ss = new Serchselect();
        int inputpage = Integer.parseInt(request.getParameter("page"));
        String inputtable = request.getParameter("table");
        String[] memcolom, memcoloumShow, memcoloumFill;
        String SQL, SQL2, Encode, strid, memtable, memID, memfillname;
        memtable = ss.SelectTable(inputtable);
        memcolom = ss.SelectColoum(inputpage, inputtable);
        memID = ss.SelectID(inputpage, inputtable);
        memcoloumShow = ss.SelectColoumShow(inputpage, inputtable);
        memcoloumFill = ss.SelectFillName(inputpage, inputtable);
        select_search_value = request.getParameter("select_search_value") == null ? memcoloumShow[0] : request.getParameter("select_search_value");
    %>
    <form name="serForm" id="serForm" method="get" action="Search_ConfigRawMatt.jsp">
        <input type="hidden" name="table" id="table" value="<%=request.getParameter("table")%>">
        <input type="hidden" name="page" id="page" value="<%=request.getParameter("page")%>">
        <input type="hidden" name="coloum" id="coloum" value="<%=request.getParameter("coloum")%>">
        <input type="hidden" name="stadment" id="stadment" value="<%=stadment%>">
        <input type ="hidden" name="select_search_value_txt" id="select_search_value_txt" value="<%=select_search_value%>">

        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>ค้นหาข้อมูล</b></div>
                <div class="panel-footer">        

                    <div style="width: 650px;" align="center">
                        <table width="650" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <!--td width="90"><input type="button" class="cgcButton_5" name="bt1" value="ย้อนกลับ" onClick="javascript:window.close();"/></td-->
                                <td width="100"><B>เลือก</B></td>
                                <td width="46"><%=objselect.ShowSelectBoxSearch(select_search_value, memcoloumFill, memcoloumShow, "select_search_value")%></td>
                                <td width="199"><input type='text' class="inputs" name="searchid" id="searchid" value="<%=request.getParameter("searchid") != null ? new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") : ""%>" size="30"/></td>                                
                            </tr>
                            <tr>
                                <td width="100"></td>
                                <td width="46">
                                </td>
                                <td width="199">
                                    &nbsp;<input type="button" class="cgcButton_6" value="ค้นหา" onclick="EncodeBefor_Search()">
                                    &nbsp;<input type="button" class="cgcButton_5" name="bt1" value="ย้อนกลับ" onClick="javascript:window.close();"/>                                                                                                                                                
                                </td>                                
                            </tr>

                            <tr>

                                <td>&nbsp;</td>
                                <td> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><!--<input type='text' class="inputs" name="searchtxt" id="searchtxt" value="" size="40"/>--></td>
                                <td></td>
                                <td colspan="2"></td>
                            </tr>
                            <%if (request.getParameter("table").equals("vproduct") || request.getParameter("table").equals("Vproduct")) {%>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><%=objselect.ShowSelectBoxSearch("select * from mproduct_type order by name_t", "ptype_id", "name_t", "mproduct_type")%></td>

                                <td colspan="2"></td>
                            </tr>
                            <%}%>
                        </table>
                    </div>
                    <div style="width: 700; height: 320px; overflow: auto;" align="center">
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <%

                                    for (int i = 0; i < memcoloumFill.length; i++) {%>
                                <td class="header2"><div align="left"><%= memcoloumFill[i]%></div></td>
                                    <%
                                        }
                                    %>
                            </tr>
                            <%
                                int start, screen;
                                int row_page = 12;
                                int total = 0;
                                int count = 0;
                                UtiDatabase objut = new UtiDatabase();
                                DBConnect db = new DBConnect();
                                Connection Conn = db.openNewConnection();
                                if (request.getParameter("searchid") == null) {
                                    SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' " + stadment;
                                    System.out.println("Search 1 SQL = " + SQL);
                                    total = objut.numRowdatabase(SQL);
                                } else if (request.getParameter("searchid") != null) {
                                    strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + select_search_value + " like '" + strid + "%'  " + stadment;
                                    System.out.println("Search 2 SQL = " + SQL);
                                    total = objut.numRowdatabase(SQL);
                                }
                                if (total == 0) {%>
                            <tr>
                                <td></td>
                                <td align="center">ไม่พบข้อมูลที่ต้องการ</td>
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
                                String getshowdata;
                            %>
                            <%                                    rs2 = null;
                                try {
                                    String sql2;
                                    if (request.getParameter("searchid") == null) {

                                        sql2 = "select * from " + memtable + " where delete_flag <> 'Y' " + stadment + " order by runno desc limit " + row_page + " offset " + start;
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                    } else if (request.getParameter("searchid") != null) {
                                        sql2 = "select * from " + memtable + " where delete_flag <> 'Y'  and " + select_search_value + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by runno desc limit " + row_page + " offset " + start;
                                        rs2 = Conn.createStatement().executeQuery(sql2);
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
                                        }
                            %>
                        <tr>
                            <%
                                for (int y = 0; y < memcoloumShow.length; y++) {
                                    if (y == 0) {


                            %>
                            <td  class="detailLeft"><a  href="#" onClick="gettoShow('<%=getshowdata%>', '<%=memID%>')" class="link_transparent"><%=rs2.getString(memcoloumShow[y])%></a></td>
                                <%
                                } else {

                                %>

                            <td  class="detailLeft"><%= rs2.getString(memcoloumShow[y])%></td>
                            <%
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
                                if (request.getParameter("searchid") == null) {%>
                        <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent">ย้อนกลับ</a>
                        <%
                        } else if (request.getParameter("searchid") != null) {%>
                        <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent">ย้อนกลับ</a>
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
                            if (request.getParameter("searchid") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent"><%=i%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent"><%=i%></a> |
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
                            if (request.getParameter("searchid") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent"><%=y%></a> |
                        <%
                        } else if (request.getParameter("searchid") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent"><%=y%></a> |
                        <%
                                        }
                                    }
                                }
                            }
                            if (screen < total_page) {
                                if (request.getParameter("searchid") == null) {%>
                        <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                        } else if (request.getParameter("searchid") != null) {%>
                        <a href="../SEARCHSCREEN/Search_ConfigRawMatt.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>&select_search_value=<%=select_search_value%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                                        }
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace(System.out);
                                } finally {
                                    if (rs2 != null) {
                                        rs2.close();
                                    }
                                    if (Conn != null) {
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
