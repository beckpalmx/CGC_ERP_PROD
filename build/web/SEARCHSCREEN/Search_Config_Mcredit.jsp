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
            var str = getId("searchtxt").value;
            for (var i = 0; i < str.length; i++) {
                getId("searchtxt").value = (getId("searchtxt").value.indexOf(" ") !== -1) ? getId("searchtxt").value.replace(" ", "_") : getId("searchtxt").value;
            }
            str = getId("searchid").value;
            for (var i = 0; i < str.length; i++) {
                getId("searchid").value = (getId("searchid").value.indexOf(" ") !== -1) ? getId("searchid").value.replace(" ", "_") : getId("searchid").value;
            }

            getId("serForm").submit();
        }
    </script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">

    <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
    <link href="../CSS/component.css" rel="stylesheet" type="text/css">                     

    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
    <script src="../JS/jquery/jquery-2.1.4.js"></script>
    <script src="../JS/bootstrap/js/bootstrap.min.js"></script>    

    <!-- Add fancyBox main JS and CSS files -->
    <script type="text/javascript" src="../JS/source/jquery.fancybox.js?v=2.1.4"></script>
    <link rel="stylesheet" type="text/css" href="../JS/source/jquery.fancybox.css?v=2.1.4" media="screen" />

    <!-- Add Button helper (this is optional) -->
    <link rel="stylesheet" type="text/css" href="../JS/source/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
    <script type="text/javascript" src="../JS/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>

    <!-- Add Thumbnail helper (this is optional) -->
    <link rel="stylesheet" type="text/css" href="../JS/source/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
    <script type="text/javascript" src="../JS/source/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>

    <!-- Add Media helper (this is optional) -->
    <script type="text/javascript" src="../JS/source/helpers/jquery.fancybox-media.js?v=1.0.5"></script>      

</head>
<%!    String stadment;
    UtiDatabase objselect;
%>
<%
//JOptionPane.showConfirmDialog(null, request);
    if (request.getParameter("stadment") != null) {
        stadment = new String(request.getParameter("stadment").getBytes("ISO8859-1"), "TIS-620");
        //JOptionPane.showConfirmDialog(null, stadment);
    } else {
        stadment = "";
    }
    objselect = new UtiDatabase();
%>
<body>
    <form name="serForm" id="serForm" method="get" action="Search_Config_Mcredit.jsp">
        <input type="hidden" name="table" id="table" value="<%=request.getParameter("table")%>">
        <input type="hidden" name="page" id="page" value="<%=request.getParameter("page")%>">
        <input type="hidden" name="coloum" id="coloum" value="<%=request.getParameter("coloum")%>">
        <input type="hidden" name="stadment" id="stadment" value="<%=stadment%>">

        <%

            Serchselect ss = new Serchselect();
            int inputpage = Integer.parseInt(request.getParameter("page"));
            //int inputFillColoum = Integer.parseInt(request.getParameter("coloum"));
            //JOptionPane.showConfirmDialog(null, request.getParameter("table"));
            String inputtable = request.getParameter("table");
            String[] memcolom, memcoloumShow, memcoloumFill;
            String SQL, SQL2, Encode, strid, memtable, memID, memfillname;

        %>
        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>ค้นหาข้อมูล</b></div>
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
                                <td width="199"></td>
                                <td><input type="button" class="cgcButton_5" name="bt1" value=" ย้อนกลับ " onClick="javascript:window.close();"/></td>                                 
                                <td><input type="button"  class="cgcButton_6" value=" ค้นหา " onclick="EncodeBefor_Search()"></td>                                
                            </tr>
                            <%if (request.getParameter("table").equals("vproduct") || request.getParameter("table").equals("Vproduct")) {%>
                            <tr>
                                <td>ประเภท&nbsp;</td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td><%=objselect.ShowSelectBoxSearch("select * from mproduct_cat where delete_flag <> 'Y' order by name_t", "pcat_id", "name_t", "mproduct_cat")%></td>
                                <td colspan="2"></td>
                            </tr>
                            <%}%>
                        </table>
                    </div>
                    <div style="width: 500px; height: 300px; overflow: auto;" align="center">
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <%
                                    memcoloumFill = ss.SelectFillName(inputpage, inputtable);

                                    for (int i = 0; i < memcoloumFill.length; i++) {%>
                                <td class="header2"><div align="left"><%= memcoloumFill[i]%></div></td>
                                    <%
                                        }
                                    %>
                            </tr>
                            <%
                                memtable = ss.SelectTable(inputtable);
                                memcolom = ss.SelectColoum(inputpage, inputtable);
                                memID = ss.SelectID(inputpage, inputtable);
                                memcoloumShow = ss.SelectColoumShow(inputpage, inputtable);

                                int start, screen;
                                int row_page = 12;
                                int total = 0;
                                int count = 0;
                                UtiDatabase objut = new UtiDatabase();
                                DBConnect db = new DBConnect();
                                Connection Conn = db.openNewConnection();
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {
                                    SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' " + stadment;
                                    System.out.println("SQL1 = " + SQL);
                                    total = objut.numRowdatabase(SQL);
                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                                    strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                    Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + strid + "%' and " + memcolom[1] + " like '" + Encode + "%' " + stadment;
                                    System.out.println("SQL2 = " + SQL);
                                    total = objut.numRowdatabase(SQL);
                                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                                    strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + strid + "%' " + stadment;
                                    System.out.println("SQL3 = " + SQL);
                                    total = objut.numRowdatabase(SQL);
                                } else {
                                    Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620");
                                    SQL = "Select Count(*) As num from  " + memtable + " where delete_flag <> 'Y' and " + memcolom[1] + " like '" + Encode + "%' " + stadment;
                                    System.out.println("SQL4 = " + SQL);
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
                                    String getshowdata;%>
                            <%                                    rs2 = null;
                                try {
                                    String sql2;
                                    if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {

                                        sql2 = "select * from " + memtable + " where delete_flag <> 'Y' " + stadment + " order by cred_code desc limit " + row_page + " offset " + start;
                                        System.out.println("sql21 = " + sql2);
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                    } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {
                                        sql2 = "select * from " + memtable + " where delete_flag <> 'Y'  and " + memcolom[0] + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' and " + memcolom[1] + " like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by cred_code desc limit " + row_page + " offset " + start;
                                        System.out.println("sql22 = " + sql2);
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                    } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {
                                        sql2 = "select * from " + memtable + " where delete_flag <> 'Y' and " + memcolom[0] + " like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by cred_code desc limit " + row_page + " offset " + start;
                                        System.out.println("sql23 = " + sql2);
                                        rs2 = Conn.createStatement().executeQuery(sql2);
                                    } else {
                                        sql2 = "select * from " + memtable + " where delete_flag <> 'Y' and " + memcolom[1] + " like '" + new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620") + "%' " + stadment + " order by cred_code desc limit " + row_page + " offset " + start;
                                        System.out.println("sql24 = " + sql2);
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
                            <td  class="detailLeft"><a  href="#" onClick="gettoShow('<%=objut.DecodeNewLine(getshowdata)%>', '<%=memID%>')" class="link_transparent"><%=rs2.getString(memcoloumShow[y])%></a></td>
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
                    if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent">ย้อนกลับ</a>
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent">ย้อนกลับ</a>
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent">ย้อนกลับ</a>
                        <%
            } else {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen - 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent">ย้อนกลับ</a>
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
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent"><%=i%></a> |
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent"><%=i%></a> |
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent"><%=i%></a> |
                        <%
            } else {%>
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=i%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent"><%=i%></a> |
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
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent"><%=y%></a> |
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent"><%=y%></a> |
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent"><%=y%></a> |
                        <%
            } else {%>
                        | <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=y%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent"><%=y%></a> |
                        <%
                                        }
                                    }
                                }
                            }
                            if (screen < total_page) {
                                if (request.getParameter("searchid") == null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&stadment=<%=stadment%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
            } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") == null) {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchid=<%=request.getParameter("searchid")%>&stadment=<%=stadment%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
            } else {%>
                        <a href="../SEARCHSCREEN/Search_Config_Mcredit.jsp?screen=<%=screen + 1%>&page=<%=request.getParameter("page")%>&table=<%=request.getParameter("table")%>&searchtxt=<%=new String(request.getParameter("searchtxt").getBytes("ISO8859-1"), "TIS-620")%>&stadment=<%=stadment%>" class="link_transparent">ไปข้างหน้า</a>
                        <%
                                        }
                                    } else {
                                        ;

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
