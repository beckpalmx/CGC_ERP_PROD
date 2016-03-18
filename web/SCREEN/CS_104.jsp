<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
    </head>
    <body>
        <table  cellpadding="0"  cellspacing="0">
            <tr>
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2"><DIV id="u50_rtf">รายการใบแจ้งคืนถ่านกัมมันต์ที่เหลือจากการผลิตเข้าคลังสินค้า   (รอยืนยัน)</DIV></td>
                <td class="ftopright"></td>
            </tr>
            <tr>
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter"><div align="center">
                        <table width="94%"  cellpadding="0" cellspacing="0" >

                            <tr>
                                <td width="756" class='blankspace'></td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <div>
                                        <table width="200" border="0" cellpadding="0" cellspacing="1">
                                            <tr>
                                                <td class="row3"><div align="center">เลขที่เอกสาร</div></td>
                                                <td class="row3"><div align="center">เลขที่ใบแจ้งการผลิต</div></td>
                                                <td class="row3"><div align="center">วันที่เอกสาร</div></td>
                                                <td class="row3"><div align="center">เวลา</div></td>
                                                <td class="row3"><div align="center">สถานะเอกสาร</div></td>
                                            </tr>
                                            <%
                                                        DBConnect dbcon = new DBConnect();
                                                        Connection con = dbcon.openNewConnection();
                                                        String sql = "SELECT * FROM d_carbon_return_header where complete_flag = 'N'";
                                                        PreparedStatement p = null;
                                                        p = con.prepareStatement(sql);
                                                        ResultSet rs = null;

                                                        rs = p.executeQuery();
                                                        while (rs.next()) {
                                            %>
                                            <tr>
                                            <input type="hidden" name="id_" id="id_" value="<%= rs.getString("doc_id")%>"/>
                                            <td><div align="center"><a href="javascript:;" onclick="linkPage()"><%= rs.getString("doc_id")%></a></div></td>
                                            <td><div align="center"><%= rs.getString("prd_no")%></div></td>
                                            <td><div align="center"><%= rs.getString("doc_date")%></div></td>
                                            <td><div align="center"><%= rs.getString("doc_time")%></div></td>
                                            <td><div align="center">ยังไม่ยืนยัน</div></td>
                                            </tr>
                                            <%}
                                                        p.close();
                                                        con.close();
                                            %>
                                        </table>
                                    </div>                                 </td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                            <tr>
                                <td class='blankspace'></td>
                            </tr>
                        </table>
                    </div></td>
                <td class="fcenterright"></td>
            </tr>
            <tr bordercolor="0069B3">
                <td class="ffootleft"></td>
                <td  class="ffootcenter" colspan="2"></td>
                <td class="ffootright"></td>
            </tr>
        </table>
        <script type="text/javascript">
            function linkPage(){
                window.location.href="CS_114.jsp?doc_id="+getId("id_").value;
            }
        </script>
    </body>
</html>
