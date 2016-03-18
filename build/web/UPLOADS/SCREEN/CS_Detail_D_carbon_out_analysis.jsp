<%@page import="com.cgc.bean.DataBeanD_carbon_out_analysis_detail"%>
<%@page import="com.cgc.DB.D_carbon_out_analysis_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<!--%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%-->
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">
            
            function goAdd()
            {
                //
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,line_no,c_type1,bu1,avg1,c_type2,bu2,avg2,c_type3,bu3,avg3,status_a,username','../JSP/CS_Detail_D_carbon_out_analysis.jsp'));
                    opener.showdetail();
                    //showTable("show","doc_id","../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=");
                    //setTimeout('showTable("show","doc_id","../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,line_no,c_type1,bu1,avg1,c_type2,bu2,avg2,c_type3,bu3,avg3,status_u,username','../JSP/CS_Detail_D_carbon_out_analysis.jsp'));
                    showTable("show","doc_id","../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }
            
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <body onLoad="select_value()">
        <%!            ThaiUtil en = new ThaiUtil();
            D_carbon_out_analysis_detailDAO objDAO = new D_carbon_out_analysis_detailDAO();
            DataBeanD_carbon_out_analysis_detail objBean = new DataBeanD_carbon_out_analysis_detail();
            String runno, doc_id, line_no, status_a, status_u, 
                    c_type1,bu1,avg1,c_type2,bu2,avg2,c_type3,bu3,avg3;
        %>
        <%
                    doc_id = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    c_type1 = "";
                    bu1 = "";
                    avg1 = "";
                    c_type2 = "";
                    bu2 = "";
                    avg2 = "";
                    c_type3 = "";
                    bu3 = "";
                    avg3 = "";                    
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        objBean = objDAO.Return_Edit(doc_id, line_no);
                        c_type1 = objBean.getC_type1();
                        bu1 = objBean.getBu1();
                        avg1 = objBean.getAvg1();
                        c_type2 = objBean.getC_type2();
                        bu2 = objBean.getBu2();
                        avg2 = objBean.getAvg2();
                        c_type3 = objBean.getC_type3();
                        bu3 = objBean.getBu3();
                        avg3 = objBean.getAvg3();                        
                        status_u = "2";
                    } else {
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        status_a = request.getParameter("status_a");
                    }
        %>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <!--input type="hidden" id="chkNull" value="c_type1,c_type2,bu1,bu2,avg1,avg2"-->
        <input type="hidden" id="chkNull" value="c_type1,c_type2,c_type3,bu1,bu2,bu3">       
        
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลการวิเคราะห์&nbsp;</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"></td>
                                <td class="columnobject"><b>วัน:<%=request.getParameter("tdate1")%></b>&nbsp;&nbsp;&nbsp;<b>ชื่อ:<%=request.getParameter("tname1")%></b>&nbsp;&nbsp;&nbsp;<b>เวลา:<%=request.getParameter("ttime1")%></b></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชนิด*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="c_type1" id="c_type1" value="<%=c_type1%>"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">บิวเทน*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="bu1" id="bu1" value="<%=bu1%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เฉลี่ย&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="avg1" id="avg1" value="<%=avg1%>"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"></td>
                                <td class="columnobject"><b>วัน:<%=request.getParameter("tdate2")%></b>&nbsp;&nbsp;&nbsp;<b>ชื่อ:<%=request.getParameter("tname2")%></b>&nbsp;&nbsp;&nbsp;<b>เวลา:<%=request.getParameter("ttime2")%></b></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชนิด*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="c_type2" id="c_type2" value="<%=c_type2%>"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">บิวเทน*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="bu2" id="bu2" value="<%=bu2%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เฉลี่ย&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="avg2" id="avg2" value="<%=avg2%>"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"></td>
                                <td class="columnobject"><b>วัน:<%=request.getParameter("tdate3")%></b>&nbsp;&nbsp;&nbsp;<b>ชื่อ:<%=request.getParameter("tname3")%></b>&nbsp;&nbsp;&nbsp;<b>เวลา:<%=request.getParameter("ttime3")%></b></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel">ชนิด*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="c_type3" id="c_type3" value="<%=c_type3%>"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">บิวเทน*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="bu3" id="bu3" value="<%=bu3%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เฉลี่ย&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="avg3" id="avg3" value="<%=avg3%>"/></td>
                            </tr>                            
                            <tr>
                                <td colspan='2'  align="right">
                                    <%
                                                if (request.getParameter("status_a") != null) {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>

                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>                                </td>
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

    </body>
</html>
