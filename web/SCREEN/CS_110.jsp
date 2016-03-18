
<%@page import="com.cgc.DB.D_analyze_packing_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_analyze_packing_detail"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
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
                    getSave(URLsend('doc_id,bag,prd_place,lat,prd_code,h2o,ba,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,valuepass,remark,status_a,username','../JSP/CS_110.jsp'));
                    opener.getId("child_ck").value = "1";
                    opener.getId("doc_id").disabled = true;
                    for(var i=0;i<=5;i++){
                        //alert("test");
                        showTable("show","doc_id","../JSP/CS_Show110.jsp?doc_id=");
                    }
                    setTimeout('window.close()', 2000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,bag,prd_place,lat,prd_code,h2o,ba,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,valuepass,remark,line_no,status_u,username','../JSP/CS_110.jsp'));
                    opener.getId("doc_id").disabled = true;
                    for(var i=0;i<=5;i++){
                        showTable("show","doc_id","../JSP/CS_Show110.jsp?doc_id=");
                    }
                    setTimeout('window.close()', 2000);
                }
            }
            function goBack()
            {
                window.close();
            }
            function passvaluechk(){
                if(getId("valuepass").value == "Y"){
                    getId("pass").checked = true;
                    getId("nopass").checked = false;
                }else{
                    getId("pass").checked = false;
                    getId("nopass").checked = true;
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    </head>
    <body onLoad="passvaluechk()">
        <%!            ThaiUtil en = new ThaiUtil();
            D_analyze_packing_detailDAO objDAO = new D_analyze_packing_detailDAO();
            DataBeanD_analyze_packing_detail objBean = new DataBeanD_analyze_packing_detail();
            String doc_id, line_no, status_a, status_u, bag, prd_place, lat, p_type, prd_code, h2o, ba, iod, hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8, hd9, hd10, hd11, hd12, hd13, hd14, hd15, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12, hc13, hc14, hc15, valuepass, remark;
        %>
        <%
                    doc_id = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    bag = "";
                    prd_place = "";
                    p_type = "";
                    prd_code = "";
                    h2o = "";
                    ba = "";
                    iod = "";
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
                    valuepass = "";
                    lat = "";
                    remark = "";
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                        bag = objBean.getBag();
                        prd_place = objBean.getPrd_place();
                        lat = objBean.getLat();
                        prd_code = objBean.getPrd_code();
                        h2o = objBean.getH2o();
                        ba = objBean.getBa();
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
                        valuepass = objBean.getStatus1();
                        remark = objBean.getRemark();
                        status_u = "2";
                        if (request.getParameter("hc1") != null) {
                            hc1 = en.EncodeTexttoTIS(request.getParameter("hc1"));
                        }
                        if (request.getParameter("hc2") != null) {
                            hc2 = en.EncodeTexttoTIS(request.getParameter("hc2"));
                        }
                        if (request.getParameter("hc3") != null) {
                            hc3 = en.EncodeTexttoTIS(request.getParameter("hc3"));
                        }
                        if (request.getParameter("hc4") != null) {
                            hc4 = en.EncodeTexttoTIS(request.getParameter("hc4"));
                        }
                        if (request.getParameter("hc5") != null) {
                            hc5 = en.EncodeTexttoTIS(request.getParameter("hc5"));
                        }
                        if (request.getParameter("hc6") != null) {
                            hc6 = en.EncodeTexttoTIS(request.getParameter("hc6"));
                        }
                        if (request.getParameter("hc7") != null) {
                            hc7 = en.EncodeTexttoTIS(request.getParameter("hc7"));
                        }
                        if (request.getParameter("hc8") != null) {
                            hc8 = en.EncodeTexttoTIS(request.getParameter("hc8"));
                        }
                        if (request.getParameter("hc9") != null) {
                            hc9 = en.EncodeTexttoTIS(request.getParameter("hc9"));
                        }
                        if (request.getParameter("hc10") != null) {
                            hc10 = en.EncodeTexttoTIS(request.getParameter("hc10"));
                        }
                        if (request.getParameter("hc11") != null) {
                            hc11 = en.EncodeTexttoTIS(request.getParameter("hc11"));
                        }
                        if (request.getParameter("hc12") != null) {
                            hc12 = en.EncodeTexttoTIS(request.getParameter("hc12"));
                        }
                        if (request.getParameter("hc13") != null) {
                            hc13 = en.EncodeTexttoTIS(request.getParameter("hc13"));
                        }
                        if (request.getParameter("hc14") != null) {
                            hc14 = en.EncodeTexttoTIS(request.getParameter("hc14"));
                        }
                        if (request.getParameter("hc15") != null) {
                            hc15 = en.EncodeTexttoTIS(request.getParameter("hc15"));
                        }
                    } else {
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        status_a = request.getParameter("status_a");
                        valuepass = "N";
                        if (request.getParameter("hc1") != null) {
                            hc1 = en.EncodeTexttoTIS(request.getParameter("hc1"));
                        }
                        if (request.getParameter("hc2") != null) {
                            hc2 = en.EncodeTexttoTIS(request.getParameter("hc2"));
                        }
                        if (request.getParameter("hc3") != null) {
                            hc3 = en.EncodeTexttoTIS(request.getParameter("hc3"));
                        }
                        if (request.getParameter("hc4") != null) {
                            hc4 = en.EncodeTexttoTIS(request.getParameter("hc4"));
                        }
                        if (request.getParameter("hc5") != null) {
                            hc5 = en.EncodeTexttoTIS(request.getParameter("hc5"));
                        }
                        if (request.getParameter("hc6") != null) {
                            hc6 = en.EncodeTexttoTIS(request.getParameter("hc6"));
                        }
                        if (request.getParameter("hc7") != null) {
                            hc7 = en.EncodeTexttoTIS(request.getParameter("hc7"));
                        }
                        if (request.getParameter("hc8") != null) {
                            hc8 = en.EncodeTexttoTIS(request.getParameter("hc8"));
                        }
                        if (request.getParameter("hc9") != null) {
                            hc9 = en.EncodeTexttoTIS(request.getParameter("hc9"));
                        }
                        if (request.getParameter("hc10") != null) {
                            hc10 = en.EncodeTexttoTIS(request.getParameter("hc10"));
                        }
                        if (request.getParameter("hc11") != null) {
                            hc11 = en.EncodeTexttoTIS(request.getParameter("hc11"));
                        }
                        if (request.getParameter("hc12") != null) {
                            hc12 = en.EncodeTexttoTIS(request.getParameter("hc12"));
                        }
                        if (request.getParameter("hc13") != null) {
                            hc13 = en.EncodeTexttoTIS(request.getParameter("hc13"));
                        }
                        if (request.getParameter("hc14") != null) {
                            hc14 = en.EncodeTexttoTIS(request.getParameter("hc14"));
                        }
                        if (request.getParameter("hc15") != null) {
                            hc15 = en.EncodeTexttoTIS(request.getParameter("hc15"));
                        }
                    }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="bag,prd_place,lat,prd_code,h2o,ba,iod">
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
                                <td class="columnlabel">จำนวนถุง*&nbsp;</td>
                                <td colspan="15" class="columnobject"><input type='text' class="inputs" name='bag' size='20' id="bag"  value="<%=bag%>" />                            &nbsp;&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="28" class="columnlabel">แหล่งผลิต*&nbsp;</td>
                                <td colspan="15" class="columnobject"><input name="prd_place" type='text' class="inputs" id="prd_place" size="20" value="<%=prd_place%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เลท*&nbsp;</td>
                                <td colspan="15" class="columnobject"><input name="lat" type='text' class="inputs" id="lat" size="20" value="<%=lat%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสผลิต*&nbsp;</td>
                                <td colspan="15" class="columnobject"><input name="prd_code" type='text' class="inputs" id="prd_code" size="20" value="<%=prd_code%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">H2O(%)*</td>
                                <td colspan="15" class="columnobject"><input name="h2o" type='text' class="inputs" id="h2o" size="20" value="<%=h2o%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">B.A.(%)*&nbsp;</td>
                                <td colspan="15" class="columnobject"><input name="ba" type='text' class="inputs" id="ba" size="20" value="<%=ba%>"></td>
                            </tr>
                            <tr>
                                <td height="22" class="columnlabel">ไอโอดีน(mg/g)*&nbsp;</td>
                                <td colspan="15" class="columnobject"><input name="iod" type='text' class="inputs" id="iod" size="20" value="<%=iod%>"></td>
                            </tr>
                            <tr>
                                <td height="51" class="columnlabel">&nbsp;</td>
                                <td colspan="29" class="row3" ><div align="center">Parameter</div></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">&nbsp;</td>
                                <td class="row3" ><%=hc1%></td>
                                <td class="row3"><%=hc2%></td>
                                <td class="row3"><%=hc3%></td>
                                <td class="row3"><%=hc4%></td>
                                <td class="row3"><%=hc5%></td>
                                <td class="row3"><%=hc6%></td>
                                <td class="row3"><%=hc7%></td>
                                <td class="row3"><%=hc8%></td>
                                <td class="row3"><%=hc9%></td>
                                <td class="row3"><%=hc10%></td>
                                <td class="row3"><%=hc11%></td>
                                <td class="row3"><%=hc12%></td>
                                <td class="row3"><%=hc13%></td>
                                <td class="row3"><%=hc14%></td>
                                <td class="row3"><%=hc15%></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">&nbsp;</td>
                                <td class="columnobject"><input name="hd1" type='text' class="inputs" id="hd1" size="5" value="<%=hd1%>"></td>
                                <td class="columnobject"><input name="hd2" type='text' class="inputs" id="hd2" size="5" value="<%=hd2%>"></td>
                                <td class="columnobject"><input name="hd3" type='text' class="inputs" id="hd3" size="5" value="<%=hd3%>"></td>
                                <td class="columnobject"><input name="hd4" type='text' class="inputs" id="hd4" size="5" value="<%=hd4%>"></td>
                                <td class="columnobject"><input name="hd5" type='text' class="inputs" id="hd5" size="5" value="<%=hd5%>"></td>
                                <td class="columnobject"><input name="hd6" type='text' class="inputs" id="hd6" size="5" value="<%=hd6%>"></td>
                                <td class="columnobject"><input name="hd7" type='text' class="inputs" id="hd7" size="5" value="<%=hd7%>"></td>
                                <td class="columnobject"><input name="hd8" type='text' class="inputs" id="hd8" size="5" value="<%=hd8%>"></td>
                                <td class="columnobject"><input name="hd9" type='text' class="inputs" id="hd9" size="5" value="<%=hd9%>"></td>
                                <td class="columnobject"><input name="hd10" type='text' class="inputs" id="hd10" size="5" value="<%=hd10%>"></td>
                                <td class="columnobject"><input name="hd11" type='text' class="inputs" id="hd11" size="5" value="<%=hd11%>"></td>
                                <td class="columnobject"><input name="hd12" type='text' class="inputs" id="hd12" size="5" value="<%=hd12%>"></td>
                                <td class="columnobject"><input name="hd13" type='text' class="inputs" id="hd13" size="5" value="<%=hd13%>"></td>
                                <td class="columnobject"><input name="hd14" type='text' class="inputs" id="hd14" size="5" value="<%=hd14%>"></td>
                                <td class="columnobject"><input name="hd15" type='text' class="inputs" id="hd15" size="5" value="<%=hd15%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">สถานะ</td>
                                <td colspan="15" class="columnobject"><input type="radio" name="status1" id="pass" value="Y" onClick="javascript:getId('valuepass').value = this.value;">
                                    ผ่าน
                                    <input type="radio" name="status1" id="nopass" value="N" onClick="javascript:getId('valuepass').value = this.value;">
                                    ไม่ผ่าน
                                    <input name="valuepass" type="hidden" id="valuepass" value="<%=valuepass%>"></td>
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
                                    <input type="button" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>

                                    <input type="button" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
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

    </body>
</html>
