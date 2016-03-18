
<%@page import="com.cgc.bean.DataBeanD_carbon_analyze_detail"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_analyze_header"%>
<%@page import="com.cgc.DB.D_carbon_analyze_detailDAO"%>
<%@page import="com.cgc.DB.D_carbon_analyze_headerDAO"%>
<%@page import="com.cgc.DB.D_carbon_analyze_value_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    getSave(URLsend('doc_id,bag,prd_place,c_type,prd_code,h2o,ba,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,remark,status_a,username,job_id','../JSP/CS_109.jsp'));
                    opener.getId("child_ck").value = "1";
                    opener.getId("doc_id").disabled = true;
                    //showTable("show","doc_id","../JSP/CS_Show109.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show109.jsp?doc_id=")', 1000);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,bag,prd_place,c_type,prd_code,h2o,ba,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,remark,header_id,status_u,username,job_id','../JSP/CS_109.jsp'));
                    opener.getId("doc_id").disabled = true;
                    //showTable("show","doc_id","../JSP/CS_Show109.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show109.jsp?doc_id=")', 1000);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }
            
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull";
                if(ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function goDelChild()
            {
                var Deleteflag ="";
                var SURL;

                //alert(getId("ckbox_1").checked);
                if(getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_Parameter109.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&header_id="+getId("header_id").value;
                    Delete_Line_no(SURL);
                    window.location.reload();
                    //showTableNonPopup2("show","doc_id,header_id","../JSP/CS_ShowParameter109.jsp");
                    getId("chk_all").checked =false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_Parameter109.jsp?status_d=3&ckbox=";
                    for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                    {
                        
                        if(document.getElementsByName("ckbox")[i].checked ===true){
                            Deleteflag += (i+1).toString()+",";
                        }
                    }
                    
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&header_id="+getId("header_id").value+"&username="+getId("username").value;
                    Delete_Line_no(SURL);
                    //window.location.reload();
                    showTableNonPopup2("show","doc_id,header_id","../JSP/CS_ShowParameter109.jsp");
                    setTimeout('showTableNonPopup2("show","doc_id,header_id","../JSP/CS_ShowParameter109.jsp")', 1000);
                }
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <body >
        <!--<form action="../SCREEN/CS_109.jsp" method="get" id="newref" name="newref">-->
        <%!            ThaiUtil en;
            D_carbon_analyze_detailDAO objDAO;
            D_carbon_analyze_value_detailDAO objDAO_value ;
            D_carbon_analyze_headerDAO objHDAO;
            DataBeanD_carbon_analyze_header objBeanH ;
            DataBeanD_carbon_analyze_detail objBean;
            String doc_id, line_no, status_a, status_u, bag, prd_place, grade, p_type, prd_code, h2o, ba, iod, hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8, hd9, hd10, hd11, hd12, hd13, hd14, hd15, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12, hc13, hc14, hc15, valuepass, remark,job_id,job_id_desc;
        %>
    <%
    en = new ThaiUtil();
    objDAO = new D_carbon_analyze_detailDAO();
    objDAO_value = new D_carbon_analyze_value_detailDAO();
    objHDAO = new D_carbon_analyze_headerDAO();
    objBeanH = new DataBeanD_carbon_analyze_header();
    objBean = new DataBeanD_carbon_analyze_detail();
                    doc_id = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    bag = "จำนวนถุง";
                    prd_place = "แหล่งผลิต";
                    p_type = "ชนิดถ่าน";
                    prd_code = "รหัส";
                    job_id = "เลขที่ใบแจ้งการผลิต";
                    h2o = "H2O(%)";
                    ba = "B.A.(%) ";
                    iod = "ไอโอดีน(mg/g)";
                    hd1 = "";
                    hd2 = "";
                    hd3 = "";
                    hd3 = "";
                    hd4 = "";
                    hd5 = "";
                    hd6 = "";
                    hd7 = "";
                    hd8 = "";
                    hd9 = "";
                    hd10 = "";
                    hd11 = "";
                    hd12 = "";
                    hd13 = "";
                    hd14 = "";
                    hd15 = "";
                    hc1 = "";
                    hc2 = "";
                    hc3 = "";
                    hc4 = "";
                    hc5 = "";
                    hc6 = "";
                    hc7 = "";
                    hc8 = "";
                    hc9 = "";
                    hc10 = "";
                    hc11 = "";
                    hc12 = "";
                    hc13 = "";
                    hc14 = "";
                    hc15 = "";
                    //valuepass = "";
                    grade = "";
                    remark = "";
                    job_id_desc = "";
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                        bag = objBean.getBag();
                        prd_place = objBean.getPrd_place();
                        p_type = objBean.getP_type();
                        prd_code = objBean.getPrd_code();
                        h2o = objBean.getH2o();
                        ba = objBean.getButane();
                        iod = objBean.getIod();
                        hd1 = objBean.getHc1();
                        hd2 = objBean.getHc2();
                        hd3 = objBean.getHc3();
                        hd4 = objBean.getHc4();
                        hd5 = objBean.getHc5();
                        hd6 = objBean.getHc6();
                        hd7 = objBean.getHc7();
                        hd8 = objBean.getHc8();
                        hd9 = objBean.getHc9();
                        hd10 = objBean.getHc10();
                        hd11 = objBean.getHc11();
                        hd12 = objBean.getHc12();
                        hd13 = objBean.getHc13();
                        hd14 = objBean.getHc14();
                        hd15 = objBean.getHc15();
                        //valuepass = objBean.getPass();
                        grade = objBean.getGrade();
                        remark = objBean.getRemark();
                        job_id = objBean.getJob_id();
                        job_id_desc = objBean.getJob_id_desc();
                        status_u = "2";
                    } else {
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        status_a = request.getParameter("status_a");
                        valuepass = "N";

                    }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" name="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="header_id" name="header_id" value="<%=line_no%>">
        <input type="hidden" id="status_a" name="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_a_parameter" name="status_a_parameter" value="1">
        <input type="hidden" id="status_u" name="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" name="chkNull" value="bag,prd_place,c_type,prd_code">
        <input type="hidden" id="status_d" name="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td height="119" class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลวิเคราะห์คุณภาพถ่าน</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="16"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"></td>
                                <td colspan="15" class="columnobject">
                                    <input type='hidden' name='bag' size='20' id="bag"  value="<%=bag%>" />
                                    <input name="prd_place" type="hidden" id="prd_place" size="20" value="<%=prd_place%>">
                                    <input name="c_type" type="hidden" id="c_type" size="20" value="<%=p_type%>">
                                    <input name="prd_code" type="hidden" id="prd_code" size="20" value="<%=prd_code%>">
                                    <input name="h2o" type="hidden" id="h2o" size="20" value="<%=h2o%>">
                                    <input name="ba" type="hidden" id="ba" size="20" value="<%=ba%>">
                                    <input name="iod" type="hidden" id="iod" size="20" value="<%=iod%>">
                                    <input name="job_id" type="hidden" id="job_id" value="<%=job_id%>" size="20">
                                    <input name="job_id_desc" type="hidden" id="job_id_desc" value ="<%=job_id_desc%>"size="30"></td>
                            </tr>
                            
                            <tr>
                                <td height="51" class="columnlabel">&nbsp;</td>
                                <td colspan="15" class="columnobject"  ><table width="100%" border="0" id="tbExp">
                                        <%if (status_u.equals("2")) {%>
                                        <tr>
                                            <td colspan="21" class="row3"><div align="right">
                                                    <input type="button" class="cgcButton_4" name="add" id="add" value=" เพิ่ม " onClick="javascript:goAddChild(URLsend('doc_id,job_id,job_id_desc,header_id,bag,prd_place,c_type,prd_code,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,status_a_parameter,username','CS_Parameter109.jsp'));"/>
                                                    <input type="button" class="cgcButton_3" name="del2" id="del3" value=" ลบ " onClick="goDelChild()">
                                                    <!--<input type="button" name="test" id="test" value=" เพิ่มck " onClick="testck()">-->
                                                </div></td>
                                        </tr>
                                        <%}%>
                                        <tr>
                                            <td class="row3"></td>
                                            <td class="row3">&nbsp;</td>
                                            <td class="row3">&nbsp;</td>
                                            <td class="row3">&nbsp;</td>
                                            <td class="row3">&nbsp;</td>
                                            <td colspan="15" class="row3"><div align="center">P.S.D.</div></td>
                                            <td class="row3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="row3" width='3%'><input type="checkbox" name="chk_all" id="chk_all" onClick="ckall(this.checked)"></td>
                                            <td class="row3"  width='5%'>ลำดับ</td>
                                            <td class="row3"  width='5%'>H2O<br>(%)</td>
                                            <td class="row3" width='5%' >B.A.<br>(%)</td>
                                            <td class="row3" width='5%'>ไอโอดีน<br>(mg/g)</td>
                                            <td class="row3" width='5%'><input name="hd1" type='text' class="inputs" id="hd1" size="4" value="<%=hd1%>"></td>
                                            <td class="row3" width='5%'><input name="hd2" type='text' class="inputs" id="hd2" size="4" value="<%=hd2%>"></td>
                                            <td class="row3" width='5%'><input name="hd3" type='text' class="inputs" id="hd3" size="4" value="<%=hd3%>"></td>
                                            <td class="row3" width='5%'><input name="hd4" type='text' class="inputs" id="hd4" size="4" value="<%=hd4%>"></td>
                                            <td class="row3" width='5%'><input name="hd5" type='text' class="inputs" id="hd5" size="4" value="<%=hd5%>"></td>
                                            <td class="row3" width='5%'><input name="hd6" type='text' class="inputs" id="hd6" size="4" value="<%=hd6%>"></td>
                                            <td class="row3" width='5%'><input name="hd7" type='text' class="inputs" id="hd7" size="4" value="<%=hd7%>"></td>
                                            <td class="row3" width='5%'><input name="hd8" type='text' class="inputs" id="hd8" size="4" value="<%=hd8%>"></td>
                                            <td class="row3" width='5%'><input name="hd9" type='text' class="inputs" id="hd9" size="4" value="<%=hd9%>"></td>
                                            <td class="row3" width='5%'><input name="hd10" type='text' class="inputs" id="hd10" size="4" value="<%=hd10%>"></td>
                                            <td class="row3" width='5%'><input name="hd11" type='text' class="inputs" id="hd11" size="4" value="<%=hd11%>"></td>
                                            <td class="row3" width='5%'><input name="hd12" type='text' class="inputs" id="hd12" size="4" value="<%=hd12%>"></td>
                                            <td class="row3" width='5%'><input name="hd13" type='text' class="inputs" id="hd13" size="4" value="<%=hd13%>"></td>
                                            <td class="row3" width='5%'><input name="hd14" type='text' class="inputs" id="hd14" size="4" value="<%=hd14%>"></td>
                                            <td class="row3" width='5%'><input name="hd15" type='text' class="inputs" id="hd15" size="4" value="<%=hd15%>"></td>
                                            <td class="row3">สถานะ</td>
                                        </tr>

                                    </table>
                                  <div style="width:100%; height: 100px; overflow: auto;" id="show"><%if (status_u.equals("2")) {
                                                                out.print(objDAO_value.showDetail(doc_id, line_no));
                                                            }%></div>                                </td>
                            </tr>

                            <tr>

                                <td class="columnlabel">หมายเหตุ</td>
                                <td colspan="15" class="columnobject"><textarea class="text_inputs" name="remark" id="remark" cols="45" rows="5"><%=remark%></textarea></td>
                            </tr>

                            <tr>
                                <td colspan='16'  align="right">
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
                                <td colspan='16' class='blankspace'>                                </td>
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
                                    <!--</form>-->
        <!--
<table width="445" border="1" >
<tr>
<td><div align="center">Column 1 </div></td>
<td><div align="center">Column 2 </div></td>
<td><div align="center">Column 3 </div></td>
<td><div align="center">Column 4 </div></td>
<td><div align="center">Column 5 </div></td>
</tr>
</table>
        -->
    </body>
</html>
