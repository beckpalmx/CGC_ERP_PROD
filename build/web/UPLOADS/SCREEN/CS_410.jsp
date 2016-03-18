
<%@page import="com.cgc.bean.DataBeanDHeaderAnalyze"%>
<%@page import="com.cgc.DB.D_Header_AnalyzeDAO"%>

<%@page import="com.cgc.bean.DataBeanCS_D_carbon_send_product_header"%>
<%@page import="com.cgc.DB.D_carbon_send_product_headerDAO"%>

<%@page import="com.cgc.bean.DataBeanCS_D_carbon_send_product_detail"%>
<%@page import="com.cgc.DB.D_carbon_send_product_detail_analyzeDAO"%>

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
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,bag,prd_place,c_type,prd_code,h2o,butane,iod,psd1,psd2,psd3,psd4,psd5,psd6,psd7,psd8,psd9,psd10,psd11,psd12,psd13,psd14,psd15,remark,status_a,username,job_id', '../JSP/CS_109.jsp'));
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
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,bag,prd_place,c_type,prd_code,h2o,ba,iod,psd1,psd2,psd3,psd4,psd5,psd6,psd7,psd8,psd9,psd10,psd11,psd12,psd13,psd14,psd15,remark,header_id,status_u,username,job_id', '../JSP/CS_109.jsp'));
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
                if (ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function goDelChild()
            {
                var Deleteflag = "";
                var SURL;

                //alert(getId("ckbox_1").checked);
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_Parameter109.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&header_id=" + getId("header_id").value;
                    Delete_Line_no(SURL);
                    window.location.reload();
                    //showTableNonPopup2("show","doc_id,header_id","../JSP/CS_ShowParameter109.jsp");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_Parameter109.jsp?status_d=3&ckbox=";
                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {

                        if (document.getElementsByName("ckbox")[i].checked == true) {
                            Deleteflag += (i + 1).toString() + ",";
                        }
                    }

                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&header_id=" + getId("header_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    //window.location.reload();
                    showTableNonPopup2("show", "doc_id,header_id", "../JSP/CS_ShowParameter109.jsp");
                    setTimeout('showTableNonPopup2("show","doc_id,header_id","../JSP/CS_ShowParameter109.jsp")', 1000);
                }
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
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
        <%!
            ThaiUtil en;
            D_Header_AnalyzeDAO objDAO;
            D_carbon_send_product_detail_analyzeDAO objDAO_value;
            D_carbon_send_product_headerDAO objHDAO;
            DataBeanCS_D_carbon_send_product_header objBeanH;
            DataBeanDHeaderAnalyze objBean;
            DataBeanCS_D_carbon_send_product_detail objBeanD;
            
            String doc_id, line_no, status_a, status_u, bag, pass, n_pass, prd_place, grade, p_type, prd_code, h2o, ba, iod, psd1, psd2, psd3, psd4, psd5, psd6, psd7, psd8, psd9, psd10, psd11, psd12, psd13, psd14, psd15, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12, hc13, hc14, hc15, valuepass, remark, job_id, job_id_desc;
        %>
        <%
            en = new ThaiUtil();
            objDAO = new D_Header_AnalyzeDAO();
            objDAO_value = new D_carbon_send_product_detail_analyzeDAO();
            objHDAO = new D_carbon_send_product_headerDAO();
            objBeanH = new DataBeanCS_D_carbon_send_product_header();
            objBean = new DataBeanDHeaderAnalyze();
            objBeanD = new DataBeanCS_D_carbon_send_product_detail();
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
            psd1 = "";
            psd2 = "";
            psd3 = "";
            psd3 = "";
            psd4 = "";
            psd5 = "";
            psd6 = "";
            psd7 = "";
            psd8 = "";
            psd9 = "";
            psd10 = "";
            psd11 = "";
            psd12 = "";
            psd13 = "";
            psd14 = "";
            psd15 = "";
            //valuepass = "";
            grade = "เกรด";
            pass = "ผ่าน";
            n_pass = "ไม่ผ่าน";
            remark = "หมายเหตุ";
            job_id_desc = "";
            out.println(request.getParameter("doc_id"));
            out.println(request.getParameter("job_id"));
            
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                job_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBeanD = objDAO_value.selectData(doc_id,line_no);
            }    
            
            /*
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                job_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                out.println(job_id);
                objBean = objDAO.selectData(job_id);
                h2o = objBean.getH2o();
                ba = objBean.getButane();
                iod = objBean.getIod();
                psd1 = objBean.getPsd_1();
                psd2 = objBean.getPsd_2();
                psd3 = objBean.getPsd_3();
                psd4 = objBean.getPsd_4();
                psd5 = objBean.getPsd_5();
                psd6 = objBean.getPsd_6();
                psd7 = objBean.getPsd_7();
                psd8 = objBean.getPsd_8();
                psd9 = objBean.getPsd_9();
                psd10 = objBean.getPsd_10();
                psd11 = objBean.getPsd_11();
                psd12 = objBean.getPsd_12();
                psd13 = objBean.getPsd_13();
                psd14 = objBean.getPsd_14();
                psd15 = objBean.getPsd_15();
                //valuepass = objBean.getPass();
                pass = objBean.getPass();
                n_pass = objBean.getN_pass();
                grade = objBean.getGrade();
                remark = objBean.getRemark();
                job_id = objBean.getJob_id();
                status_u = "2";
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                status_a = request.getParameter("status_a");
                valuepass = "N";

            }
                    */
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
                                    <input type='hidden' name='bag' size='20' id="bag"  value="" />
                                    <input name="prd_place" type="hidden" id="prd_place" size="20" value="">
                                    <input name="c_type" type="hidden" id="c_type" size="20" value="">
                                    <input name="prd_code" type="hidden" id="prd_code" size="20" value="">
                                    <input name="h2o" type="hidden" id="h2o" size="20" value="<%=h2o%>">
                                    <input name="ba" type="hidden" id="ba" size="20" value="<%=ba%>">
                                    <input name="iod" type="hidden" id="iod" size="20" value="<%=iod%>">
                                    <input name="job_id" type="hidden" id="job_id" value="<%=job_id%>" size="20">                                    
                            </tr>

                            <tr>
                                <td height="51" class="columnlabel">&nbsp;</td>
                                <td colspan="15" class="columnobject"  ><table width="100%" border="0" id="tbExp">
                                        <%if (status_u.equals("2")) {%>
                                        <tr>
                                            <td colspan="21" class="row3"><div align="right">
                                                    <input type="button" class="cgcButton_4" name="add" id="add" value=" เพิ่ม " onClick="javascript:goAddChild(URLsend('doc_id,job_id,job_id_desc,header_id,bag,prd_place,c_type,prd_code,psd1,psd2,psd3,psd4,psd5,psd6,psd7,psd8,psd9,psd10,psd11,psd12,psd13,psd14,psd15,status_a_parameter,username', 'CS_Parameter410.jsp'));"/>
                                                    <input type="button" class="cgcButton_3" name="del2" id="del3" value=" ลบ " onClick="goDelChild()">                                                    
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
                                            <!--td class="row3"  width='5%'>ลำดับ</td-->
                                            <td class="row3"  width='5%'>H2O<br>(%)</td>
                                            <td class="row3" width='5%' >B.A.<br>(%)</td>
                                            <td class="row3" width='5%'>ไอโอดีน<br>(mg/g)</td>
                                            <td class="row3" width='5%'><input name="psd1" type='text' class="inputs" id="psd1" size="4" value="<%=psd1%>"></td>
                                            <td class="row3" width='5%'><input name="psd2" type='text' class="inputs" id="psd2" size="4" value="<%=psd2%>"></td>
                                            <td class="row3" width='5%'><input name="psd3" type='text' class="inputs" id="psd3" size="4" value="<%=psd3%>"></td>
                                            <td class="row3" width='5%'><input name="psd4" type='text' class="inputs" id="psd4" size="4" value="<%=psd4%>"></td>
                                            <td class="row3" width='5%'><input name="psd5" type='text' class="inputs" id="psd5" size="4" value="<%=psd5%>"></td>
                                            <td class="row3" width='5%'><input name="psd6" type='text' class="inputs" id="psd6" size="4" value="<%=psd6%>"></td>
                                            <td class="row3" width='5%'><input name="psd7" type='text' class="inputs" id="psd7" size="4" value="<%=psd7%>"></td>
                                            <td class="row3" width='5%'><input name="psd8" type='text' class="inputs" id="psd8" size="4" value="<%=psd8%>"></td>
                                            <td class="row3" width='5%'><input name="psd9" type='text' class="inputs" id="psd9" size="4" value="<%=psd9%>"></td>
                                            <td class="row3" width='5%'><input name="psd10" type='text' class="inputs" id="psd10" size="4" value="<%=psd10%>"></td>
                                            <td class="row3" width='5%'><input name="psd11" type='text' class="inputs" id="psd11" size="4" value="<%=psd11%>"></td>
                                            <td class="row3" width='5%'><input name="psd12" type='text' class="inputs" id="psd12" size="4" value="<%=psd12%>"></td>
                                            <td class="row3" width='5%'><input name="psd13" type='text' class="inputs" id="psd13" size="4" value="<%=psd13%>"></td>
                                            <td class="row3" width='5%'><input name="psd14" type='text' class="inputs" id="psd14" size="4" value="<%=psd14%>"></td>
                                            <td class="row3" width='5%'><input name="psd15" type='text' class="inputs" id="psd15" size="4" value="<%=psd15%>"></td>
                                            <td class="row3">สถานะ</td>
                                        </tr>

                                    </table>
                                    <div style="width:100%; height: 100px; overflow: auto;" id="show"><%if (status_u.equals("2")) {
                                                out.print(objDAO_value.ShowDetail_1(doc_id, job_id));                                                
                                            }%></div>                                
                                </td>
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
